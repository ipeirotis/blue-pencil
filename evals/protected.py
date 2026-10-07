#!/usr/bin/env python3
"""Code grader: did the edit change anything that must not change?

This is a Python port of the token classes in scripts/check-protected.sh (the
repo's existing "protected content" check), made to run on any pair of texts
instead of only the hand-written examples. It pulls out the things an editor
must never alter (citations, numbers, equations, cross-references, quotes, and
so on) from the original and the revision, and reports any difference.

How it compares: each class is compared as a multiset, so it can tell that a
number appeared, vanished, or changed, but not that two numbers swapped places
between sentences. It also cannot see wording changes that touch no token, such
as "associated with" becoming "causes". Those need the meaning grader.

Beyond check-protected.sh it also checks units after numbers ("10 mg"), Unicode math
symbols in prose, Markdown emphasis delimiters, and numbered citation groups ("[12, 13]"),
and it reads environments with their line breaks.

Any change to a citation, including reordering the citations inside one group,
is reported. A whole group may move to another sentence; its internal order may not.
A reformatted number (5-9% to 5 to 9 percent) is also reported, because the code
cannot tell a changed number from a reformatted one.

Usage:
    python3 protected.py original.txt revised.txt
"""

import re
import sys
from collections import Counter

LDQ, RDQ, LSQ, RSQ = "\u201c", "\u201d", "\u2018", "\u2019"
ULE, UGE, UMIN = "\u2264", "\u2265", "\u2212"
EUR, GBP, YEN = "\u20ac", "\u00a3", "\u00a5"

CLASSES = ["citations", "authoryear", "crossrefs", "callouts", "math", "symbols", "equations", "environments",
           "macros", "emphasis", "quotes", "comments", "code", "numbers", "numberwords"]

_PROSE_MACROS = {"caption", "emph", "textbf", "textit", "footnote", "section",
                 "subsection", "subsubsection", "paragraph"}

# A name starts with an uppercase letter, Latin-1/Latin Extended-A, Greek and Cyrillic
# included ("Garc\u00eda", "M\u00fcller", "\u0141ukasz"), and continues with any letters.
# The connectors "of" and "for" keep institutional authors whole ("University of Oxford").
# A curly apostrophe counts like a straight one ("O\u2019Neil", "Smith\u2019s (2020)").
_NAME = (r"(?:[A-Z\u00c0-\u00d6\u00d8-\u00de\u0100-\u017f\u0391-\u03a9\u0410-\u042f](?:[^\W\d_]|['\u2019.&-])+|"
         r"van|von|der|de|del|da|di|la|le|ter|ten|dos|and|of|for|et|al\.?|&)")
_DATE_LEAD = re.compile(
    r"^(In|On|At|By|For|From|Since|After|Before|During|Until|Between|Around|Over|Under|"
    r"The|A|An|As|Of|To|With|When|While|January|February|March|April|May|June|July|August|"
    r"September|October|November|December|Early|Late|Mid|"
    # Words that begin ordinary year phrases ("Our 2020 survey", "Version 2020").
    r"Our|Their|This|That|These|Those|Its|His|Her|My|Your|Each|Every|Version|Model|Fiscal|Year|"
    r"Spring|Summer|Fall|Autumn|Winter) ")

# A number, with any scientific-notation exponent kept in the same token ("2e10", "1.5E-3",
# "6 \u00d7 10^23", "6\u00d710\u00b2\u00b3", "10^5"), so changing the mantissa or the exponent is caught.
_SUPDIG = "[\u2070\u00b9\u00b2\u00b3\u2074-\u2079]"
_SUP = "[\u207a\u207b\u2212]?[\u2070\u00b9\u00b2\u00b3\u2074-\u2079]+"
_NUM = (r"(?:[0-9]+(?:,[0-9]{3})*(?:\.[0-9]+)?|\.[0-9]+)"
        r"(?:[eE][+\u2212-]?[0-9]+|\^[+\u2212-]?[0-9]+|" + _SUP + "|"
        r" ?[\u00d7x] ?10(?:\^[+\u2212-]?[0-9]+|" + _SUP + r"))?")
# Scientific units, matched case-sensitively (mM is not mm) and only as whole words, so
# "10 mg" to "10 kg" or "20 \u00b0C" to "20 \u00b0F" is caught. Spelled-out units are matched
# too, with the hyphen and plural normalized so "10 grams" and "a 10-gram dose" agree.
_MICRO = "(?:\u00b5|\u03bc)"
_UNIT_ONE = (r"(?:(?:[kmnMGT]|" + _MICRO + r")?(?:g|l|L|m|M|mol|s|V|W|J|Hz|Pa)|mL|cm|kcal|cal|"
             r"USD|EUR|GBP|JPY|CNY|RMB|CAD|AUD|NZD|CHF|INR|HKD|SGD|SEK|NOK|DKK|KRW|BRL|MXN|ZAR|RUB|TRY|"
             r"min|h|hr|hrs|K|kDa|Da|bp|kb|Mb|[KMGT]B|\u00b0 ?[CF]|\u00b0)"
             r"(?:\^-?[0-9]+|[\u207b\u00b9\u00b2\u00b3\u2070-\u2079]+)?")  # exponent: m^2, s\u207b\u00b9
# A compound unit ("mg/kg", "m/s", "kg\u00b7m", or SI style "mg kg\u207b\u00b9") is one token,
# so changing any part is caught. A space joins a component only if it has a negative
# exponent, so "10 m and" or "5 g s" in prose is not swallowed.
_UNIT_NEG = (r"(?:(?:[kmn]|" + _MICRO + r")?(?:g|l|L|m|M|mol|s|J)|mL|cm|min|h|K)"
             r"(?:\^-[0-9]+|\u207b[\u00b9\u00b2\u00b3\u2070-\u2079]+)")
_UNIT_SYM = (r"(?-i:" + _UNIT_ONE + r"(?:(?:[/\u00b7\u22c5]| per )" + _UNIT_ONE + r"| " + _UNIT_NEG + r")*)"
             r"(?![A-Za-z0-9])")
# ISO currency codes, before or after an amount ("USD 10 million", "10 CAD").
_CUR_CODE = ("(?-i:USD|EUR|GBP|JPY|CNY|RMB|CAD|AUD|NZD|CHF|INR|HKD|SGD|SEK|NOK|DKK|KRW|BRL|"
             "MXN|ZAR|RUB|TRY)")
_UNIT_WORD = (r"(?:(?:micro|milli|centi|kilo|nano)?(?:grams?|litres?|liters?|meters?|metres?|"
              r"moles?|seconds?|minutes?|hours?|volts?|watts?|joules?)|degrees?(?: (?:celsius|fahrenheit|(?-i:[CF])))?|"
              r"kelvin|hertz|calories?|days?|weeks?|months?|years?)\b")
_NUMBER_RE = re.compile(
    r"(?:(?:less than|more than|greater than|fewer than|at least|at most|up to|approximately|"
    r"about|around|roughly|nearly|exceeding|below|above) )?"
    # A spelled-out sign stays with its number, so "minus 5" to "5" is caught.
    r"(?:(?:minus|negative) )?"
    # The space after a comparator belongs to the token; a space before the number does not,
    # so a number that moves to the start of a sentence is the same token.
    r"(?:(?:[<>]=?|" + ULE + "|" + UGE + r")[ ~]?|~)?(?:[+-]|" + UMIN + r")?"
    # A fraction, ratio, or other slash/colon group ("1/2", "1:2") is one ordered token.
    # A range with a hyphen, en dash, or em dash ("1.2-3.4", "1.2\u20133.4") is one ordered token.
    # "1 to 2" is a range too, and either endpoint may carry a sign ("\u22123\u2013\u22121").
    # The first endpoint may carry its own suffix ("5%\u201310%", "5 mg\u201310 mg").
    # A sign may also follow the currency sign ("$-5", "\u20ac\u22125").
    r"(?:(?-i:US|C|A|NZ|HK|S|R)?\$|" + EUR + "|" + GBP + "|" + YEN + r"|\b" + _CUR_CODE + r" ?)?(?:[+-]|" + UMIN + r")?" + _NUM
    # An estimate with its uncertainty ("5 \u00b1 2") is one ordered token too.
    + r"(?:(?: ?%|(?: |-)?" + _UNIT_SYM + r")?(?:[-\u2013\u2014]| to | ?\u00b1 ?)(?:[+-]|" + UMIN + r")?"
    + r"(?:(?-i:US|C|A|NZ|HK|S|R)?\$|" + EUR + "|" + GBP + "|" + YEN + r"|\b" + _CUR_CODE + r" ?)?(?:[+-]|" + UMIN + r")?" + _NUM + r")?"
    r"(?:[/:]" + _NUM + r")*(?: ?%)?"  # SI style puts a space before % ("5 %")
    r"(?:(?: |-)(?:percentage points?|percentage|percent|points?|pp|bps|million|billion|"
    r"thousand|trillion|bn|mn|tn|fold|star|stars)|(?P<abbr>bn|mn|tn|k)(?![A-Za-z0-9])|(?: |-)(?P<uword>" + _UNIT_WORD + r")|(?: |-)?(?P<unit>" + _UNIT_SYM + r"))?"
    # A rate's denominator stays with the number: "$5 per kg", "10 kilometers per hour".
    r"(?: per (?:" + _UNIT_SYM + "|" + _UNIT_WORD + r"))?",
    re.I)
_NUMWORD_RE = re.compile(
    r"\b(?:(?:minus|negative) )?"  # a spelled-out sign stays with its number, as for digits
    r"(?:(?:zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|"
    r"fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|"
    r"seventy|eighty|ninety|hundred|thousand|million|billion|twice|half|dozen)(?:-[a-z]+)?|"
    r"(?:first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth)-[a-z]+)\b"
    # A unit or percent after a spelled-out number stays with it ("five percent").
    # A spaced fraction keeps its denominator ("one third", "three quarters").
    r"(?: (?P<unit>percentage points?|percent|per cent|halves|half|thirds?|quarters?|fourths?|fifths?|"
    r"sixths?|sevenths?|eighths?|ninths?|tenths?|" + _UNIT_WORD + r"))?", re.I)


# Mathematical symbols written as Unicode in prose, outside any math delimiters: Greek
# letters, operators, arrows, letterlike symbols (\u211d), sub/superscripts, primes, and
# math alphanumerics. Each character is one token, so "\u03b2" to "\u03b3" is caught.
_SYMBOL_RE = re.compile(
    "[\u0370-\u03ff\u00b1\u00d7\u00f7\u00b2\u00b3\u00b9\u00bc-\u00be\u2150-\u215e\u2032-\u2037\u2070-\u209f"
    "\u2100-\u214f\u2190-\u21ff\u2200-\u22ff\u27c0-\u27ef\u2980-\u2aff"
    "\U0001d400-\U0001d7ff]")

# Markdown emphasis. The delimiters are protected markup; the text inside is editable
# prose, so only the delimiters are compared (as \emph and \textbf are, by name only).
# Spans that cannot hold emphasis (math, code, macro arguments, link targets) are blanked
# first, and a delimiter touching a word character ("0.05**", snake_case) is not emphasis.
_NO_EMPHASIS = re.compile(r"`[^`]+`|\$\$[^$]+\$\$|\$[^$]+\$|\\\(.*?\\\)|\\\[.*?\\\]|"
                          r"\\[A-Za-z]+\*?(?:\[[^\]]*\])*\{[^}]*\}|\]\([^)]*\)")
_STRONG_RE = re.compile(r"(?<![*_\w\\])(\*\*|__)(?=[^\s*_])(.+?)(?<=[^\s*_\\])\1(?![*_\w])")
_STRIKE_RE = re.compile(r"(?<!~)(~~)(?=\S)(.+?)(?<=\S)~~(?!~)")  # strikethrough
_EM_RE = re.compile(r"(?<![*_\w\\])([*_])(?=[^\s*_])(.+?)(?<=[^\s*_\\])\1(?![*_\w])")

# Numeric citation groups, "[12]" or "[12, 13]" or "[3-5]". The whole bracket is one
# token, so reordering the numbers inside a group is caught.
# Labels may carry a short letter prefix ("[S1]", "[e1, e2]").
_NUMCITE_RE = re.compile(r"\[ ?[A-Za-z]{0,2}[0-9]+(?: ?[,;\u2013-] ?[A-Za-z]{0,2}[0-9]+)* ?\]")


# Bare ASCII equations and comparisons outside math delimiters ("x > y", "a+b=c",
# "n = 412"): operands of at most two letters or a number, joined by = < > + * / ^.
# Whitespace is dropped from the token, so only a change of operand or operator counts.
# A function call ("f(x)", "log(y)") is one operand, so renaming the function is caught.
_FUNC = r"[A-Za-z][A-Za-z0-9_]*\((?:[^()\n]|\([^()\n]*\)){1,40}\)"  # "f(x, y)", "f(g(x))"
_EQ_OPERAND = r"(?:" + _FUNC + r"|[A-Za-z]{1,2}|[0-9]+(?:\.[0-9]+)?|\.[0-9]+)"
# Subtraction counts as an operator when written " - " (spaced) or with a Unicode minus;
# an unspaced hyphen is left out so hyphenated words ("co-op") are not equations.
# Comparisons and assignments may also use named operands ("rate = 5", "dose < limit",
# "rate + dose = total"). A chain with named operands counts only if it holds one of
# = < > or their combinations, so "and/or" style slashes stay prose.
# Unicode sub- and superscripts and primes decorate an identifier ("x\u2081", "x\u2032", "x\u00b2").
_DECOR = "[\u2080-\u209c\u2070-\u207f\u00b2\u00b3\u00b9\u2032-\u2034']*"  # also ASCII primes, "x'"
_IDENT = r"[A-Za-z][A-Za-z0-9_]*" + _DECOR
# A Greek, letterlike, or math-alphanumeric symbol is an operand too ("\u03b1 = \u03b2").
_USYM = "[\u0391-\u03a9\u03b1-\u03c9\u03d1\u03d5\u03f5\u2100-\u214f\U0001d400-\U0001d7ff][A-Za-z0-9_]*" + _DECOR
# A numeric operand may carry a sign and an exponent ("x = -5", "x = 2e10").
# A bracketed side: "x = (a + b)", "x = [a + b]", "S = {a, b}".
_GROUP = (r"(?:\((?:[^()\n]|\([^()\n]*\)){1,60}\)|\[(?:[^\[\]\n]|\[[^\[\]\n]*\]){1,60}\]"
          r"|\{(?:[^{}\n]|\{[^{}\n]*\}){1,60}\})")
# Any operand may carry a unary sign ("x = -y", "x = -(a + b)", "x = -5").
_REL_OPERAND = (r"(?:[+-]|\u2212)?(?:" + _FUNC + "|" + _IDENT + "|" + _USYM + "|" + _GROUP
                + r"|(?:[0-9]+(?:\.[0-9]+)?|\.[0-9]+)(?:[eE](?:[+-]|\u2212)?[0-9]+)?)")
_ARITH_OP = r"(?: ?[+*/^\u2212\u00d7\u00b7\u22c5\u00f7\u00b1\u2213] ?| - )"  # also times, dots, divide, plus-minus
# Unicode relations too: \u2264 \u2265 \u2248 \u2260 \u2261 \u221d \u226a \u226b, and set
# membership and inclusion, \u2208 \u2209 \u2282 \u2283 \u2286 \u2287.
_UREL = "\u2264\u2265\u2248\u2260\u2261\u221d\u226a\u226b\u2208\u2209\u2282\u2283\u2286\u2287\u2254\u225c"
_REL_OP = r" ?(?:<=|>=|!=|==|:=|=:|[=<>" + _UREL + r"]) ?"  # also definitions, ":=", "=:"
_RELATION_RE = re.compile(r"(?<![\w.\\])" + _REL_OPERAND + r"(?:" + _ARITH_OP + _REL_OPERAND + r")*" + _REL_OP
                          + _REL_OPERAND + r"(?:(?:" + _ARITH_OP + "|" + _REL_OP + r")" + _REL_OPERAND + r")*(?![\w])")
_BARE_OPERAND = r"(?:" + _FUNC + "|[A-Za-z]{1,2}" + _DECOR + "|" + _EQ_OPERAND + "|" + _USYM + ")"  # Greek and letterlike operands too ("\u03b1 + \u03b2")
_EQUATION_RE = re.compile(r"(?<![\w.\\])" + _BARE_OPERAND + r"(?:(?: ?(?:<=|>=|!=|==|:=|=:|[=<>+*/^\u2212\u00d7\u00b7\u22c5\u00f7\u00b1\u2213" + _UREL + r"]) ?| - )"
                          + _BARE_OPERAND + r")+(?![\w])")

# A parenthesized panel suffix belongs to its callout: "Figure 2(a)", "Figure 2 (b-d)".
_PANEL = r"(?: ?\([a-z](?:[,\u2013-] ?[a-z])*\))?"


def _dollar_math(flat):
    """$...$ and $$...$$ spans. A pair whose opening $ is followed by an amount and whose
    content has no math characters is two currency signs ("$5 and profit was $2"), not
    math: it is skipped and the scan resumes after the first $. "$5 \\in S$" stays math."""
    out, pos = [], 0
    pat = re.compile(r"\$\$[^$]+\$\$|\$[^$]+\$")
    while True:
        m = pat.search(flat, pos)
        if not m:
            return out
        t = m.group(0)
        # "$5x$": a letter right after the leading number is a variable, so it is math.
        # A slash before a unit word ("$5/kg") is a price, not division.
        inner = re.sub(r"/[A-Za-z]+\b", "", t[1:-1])
        if (not t.startswith("$$") and re.match(r"\$[-+\u2212]?[0-9][0-9,.]*(?![0-9,.A-Za-z])", t)
                and not re.search(r"[\\^_{}=<>+*/]", inner)):
            pos = m.start() + 1
            continue
        out.append(t)
        pos = m.end()


def _delimited(d, n):
    """Emphasis with the delimiter d repeated n times; only the same character may not touch
    it, so nested forms ("**_x_**", "***x***") are found from the outside in."""
    e = re.escape(d)
    return re.compile(r"(?<![" + e + r"\w\\])(" + e * n + r")(?=[^\s" + e + r"])(.+?)(?<=[^\s" + e
                      + r"\\])" + e * n + r"(?![" + e + r"\w])")


# Combined strong emphasis ("***x***") first, then strikethrough, strong, and emphasis.
_EMPH_PATS = ([_delimited(d, 3) for d in "*_"] + [_STRIKE_RE] + [_delimited(d, 2) for d in "*_"]
              + [_delimited(d, 1) for d in "*_"])


def _emphasis(flat):
    text = _NO_EMPHASIS.sub(" ", flat)
    out = []
    for pat in _EMPH_PATS:
        out += [m.group(1) for m in pat.finditer(text)]
        text = pat.sub(lambda m: m.group(2), text)
    return out


# A year ("2020", "2020a"), or an undated or forthcoming work, given in parentheses or
# after a comma ("Smith (n.d.)", "(Smith, in press)").
_YEAR = r"(?:,? \(?[12][0-9]{3}[a-z]?\)?|(?:, | \()(?:n\.d\.|in press|forthcoming)\)?)"
_AY_PAT = re.compile(_NAME + r"(?:,? " + _NAME + r")*" + _YEAR)


_NARRATIVE_CITE = re.compile(_NAME + r"(?:,? " + _NAME + r")* \((?:[12][0-9]{3}[a-z]?|n\.d\.|in press|forthcoming)\)")
_NARRATIVE_RUN = re.compile(_NARRATIVE_CITE.pattern + r"(?:(?:;|,|,? and) " + _NARRATIVE_CITE.pattern + r")+")


_CMD_CITE = r"\\[Cc]ite[a-zA-Z]*\*?(?:\[[^\]]*\])*\{[^}]*\}"
_CMD_RUN = _CMD_CITE + r"(?:[;,]? ?" + _CMD_CITE + r")+"
_NUM_RUN = r"\[[A-Za-z]{0,2}[0-9]+\](?:(?:[;,]? ?|,? (?:and|&) )\[[A-Za-z]{0,2}[0-9]+\])+"  # "[1], [2]", "[1] and [2]"


def _strip_lead(t):
    """Drop leading words that are not names ("As Smith (2020)" -> "Smith (2020)").

    If nothing name-like is left ("In March 2020", "The 2019"), the match is a date,
    not a citation, and "" is returned."""
    while True:
        m = _DATE_LEAD.match(t) or re.match(r"(?:and|of|for|&) ", t)
        if not m:
            break
        t = t[m.end():]
    return t if re.match(_NAME, t) and not re.match(r"(?:et|al\.?)\b", t) else ""


def _citation_groups(flat):
    """Ordered author-year groups inside one parenthetical, e.g. (A 2006; B 2008).

    Only groups of two or more citations are returned. A whole group may move to
    another sentence, but the order inside it must not change.
    """
    groups = []
    for span in re.findall(r"\(([^()]*(?:[12][0-9]{3}|n\.d\.|in press|forthcoming)[^()]*)\)", flat):
        toks = [t.replace("(", "").replace(")", "").replace(RSQ, "'").strip(", ")
                for t in map(_strip_lead, _AY_PAT.findall(span)) if t]
        if len(toks) >= 2:
            groups.append(tuple(toks))
    # Narrative citations next to each other, "Smith (2020); Jones (2021)" or
    # "Smith (2020) and Jones (2021)", are an ordered group too.
    for run in _NARRATIVE_RUN.finditer(flat):
        toks = [t.replace("(", "").replace(")", "").replace(RSQ, "'").strip(", ")
                for t in map(_strip_lead, _NARRATIVE_CITE.findall(run.group(0))) if t]
        if len(toks) >= 2:
            groups.append(tuple(toks))
    # Adjacent citation commands ("\\cite{A}; \\cite{B}") and numbered citations ("[1]; [2]").
    for pat, one in ((_CMD_RUN, _CMD_CITE), (_NUM_RUN, r"\[[A-Za-z]{0,2}[0-9]+\]")):
        for run in re.finditer(pat, flat):
            groups.append(tuple(re.findall(one, run.group(0))))
    return groups


def _brace_group(s, i):
    """If s[i] == '{', return the index just past its matching '}', else None."""
    depth = 0
    for k in range(i, len(s)):
        if s[k] == "{":
            depth += 1
        elif s[k] == "}":
            depth -= 1
            if depth == 0:
                return k + 1
    return None


def _macros(text):
    out = []
    pos = 0
    pat = re.compile(r"\\[A-Za-z]+\*?")
    while True:
        m = pat.search(text, pos)
        if not m:
            break
        tok, rest_i = m.group(0), m.end()
        name = tok.lstrip("\\").rstrip("*")
        if name == "href" and text[rest_i:rest_i + 1] == "{" and _brace_group(text, rest_i):
            # \href{url}{text}: the destination is protected, the link text is editable prose.
            end = _brace_group(text, rest_i)
            closed = text[end:end + 1] == "{" and _brace_group(text, end)
            out.append(tok + text[rest_i:end] + ("{}" if closed else ""))
            pos = end
            continue
        if name in ("verb", "lstinline"):
            # Inline verbatim: the whole span up to the closing delimiter ("\\verb|x_y|",
            # "\\lstinline[style]{x}") is protected code.
            j = rest_i
            if name == "lstinline" and text[j:j + 1] == "[" and text.find("]", j) != -1:
                j = text.find("]", j) + 1
            end = None
            if text[j:j + 1] == "{":
                end = _brace_group(text, j)
            elif j < len(text) and not text[j].isalnum() and not text[j].isspace():
                k = text.find(text[j], j + 1)
                end = k + 1 if k != -1 else None
            if end:
                out.append(text[m.start():end])
                pos = end
                continue
        if name in _PROSE_MACROS:
            # The argument is editable prose, but its delimiters are markup: record
            # whether an optional [..] and a {..} follow ("\\textbf{}" vs "\\textbf").
            j, shape = rest_i, ""
            if text[j:j + 1] == "[" and text.find("]", j) != -1:
                shape, j = "[]", text.find("]", j) + 1
            if text[j:j + 1] == "{" and _brace_group(text, j):
                shape += "{}"
            out.append(tok + shape)
            pos = rest_i
            continue
        while True:
            j = rest_i
            if j < len(text) and text[j] == " " and j + 1 < len(text) and text[j + 1] in "[{":
                rest_i = j + 1
                continue
            if rest_i < len(text) and text[rest_i] == "[":
                p = text.find("]", rest_i)
                if p == -1:
                    break
                tok += text[rest_i:p + 1]
                rest_i = p + 1
            elif rest_i < len(text) and text[rest_i] == "{":
                end = _brace_group(text, rest_i)
                if end is None:
                    break
                tok += text[rest_i:end]
                rest_i = end
            else:
                break
        out.append(tok)
        pos = rest_i
    out += re.findall(r"\\[^A-Za-z0-9\s]", text)
    return out


_FROZEN_ENVS = ["lstlisting", "verbatim", "Verbatim", "minted", "alltt", "code", "tabular", "tabular*",
                "tabularx", "longtable", "array", "equation", "equation*", "align", "align*", "gather",
                "gather*", "multline", "multline*", "eqnarray", "eqnarray*", "matrix", "pmatrix",
                "bmatrix", "vmatrix", "cases", "split", "math", "displaymath", "alignat", "alignat*", "flalign",
                "flalign*", "aligned", "alignedat", "gathered", "Bmatrix", "Vmatrix", "smallmatrix", "dcases"]


def _table_rows(raw):
    """Lines of Markdown tables: any line starting with "|", plus every line with a pipe in a
    block (lines between blank lines) that holds a separator row, so a table written
    without outer pipes ("A | B" over "---|---") is a table too."""
    rows = []
    for block in re.split(r"\n[ \t]*\n", raw):
        lines = block.splitlines()
        is_table = any("|" in ln and "-" in ln and re.fullmatch(r"[\s|:\-]+", ln) for ln in lines)
        rows += [ln for ln in lines if ln.startswith("|") or (is_table and "|" in ln)]
    return rows


def _list_markers(raw):
    """List markers with their nesting depth, so moving an item in or out a level is caught
    while re-indenting a whole list the same way is not.

    Unordered markers keep a task-list box if present ("- [x]", "- [ ]"). Ordered markers
    ("1.", "2)") have at most three digits, so a hard-wrapped line that starts with a year
    ("2006). Moreover") is not taken for a list item. A non-indented line that is not a
    list item ends the list."""
    out, stack = [], []
    for ln in raw.splitlines():
        m = re.match(r"^(\s*)([-*+][ \t](?:\[[ xX]\][ \t])?|[0-9]{1,3}[.)][ \t])", ln)
        if not m:
            if ln.strip() and not ln[:1].isspace():
                stack = []
            continue
        indent = len(m.group(1).expandtabs(4))
        while stack and stack[-1] > indent:
            stack.pop()
        if not stack or stack[-1] < indent:
            stack.append(indent)
        marker = re.sub(r"\s+", " ", m.group(2).strip()).replace("X", "x")
        out.append("  " * (len(stack) - 1) + marker)
    return out


def _strip_captions(text):
    """Caption text is editable prose; blank it before diffing environments."""
    out, pos = [], 0
    while True:
        i = text.find("\\caption", pos)
        if i == -1:
            out.append(text[pos:])
            break
        out.append(text[pos:i] + "\\caption{}")
        j = i + len("\\caption")
        if j < len(text) and text[j] == "*":
            j += 1
        while j < len(text) and text[j] == " ":
            j += 1
        if j < len(text) and text[j] == "[":
            p = text.find("]", j)
            j = p + 1 if p != -1 else j
        while j < len(text) and text[j] == " ":
            j += 1
        if j < len(text) and text[j] == "{":
            end = _brace_group(text, j)
            j = end if end else j
        pos = j
    return "".join(out)


def tokens(cls, raw, flat):
    """Return the list of protected tokens of one class."""
    if cls == "citations":
        return re.findall(
            r"\\[Cc]ite[a-zA-Z]*\*? ?(?:\[[^\]]*\] ?)*\{[^}]*\}|\[[^\]@]*@[^\]]*\]|"
            r"-?@[A-Za-z0-9_][A-Za-z0-9_:-]*(?:\.[A-Za-z0-9_:-]+)*", flat) + [
            re.sub(r" ", "", t).replace("\u2013", "-") for t in _NUMCITE_RE.findall(flat)] + [
            # Parenthesized numeric groups, "(1, 2)" or "(3\u20135)", are ordered tokens too.
            re.sub(r" ", "", t).replace("\u2013", "-")
            for t in re.findall(r"\([0-9]+(?: ?[,;\u2013-] ?[0-9]+)+\)", flat)] + (
            # Superscript citation runs ("work\u00b9,\u00b2", "\u00b9\u207b\u00b3") are one ordered token.
            re.findall(_SUPDIG + r"+(?:[,\u2013\u207b-]" + _SUPDIG + r"+)+", flat)) + [
            # DOIs, bare or as doi.org links, compared by the identifier itself.
            m.rstrip(".").lower() for m in re.findall(r"\b(10\.[0-9]{4,9}/[^\s,;()\[\]<>\"]+)", flat)]
    if cls == "authoryear":
        pat = _AY_PAT
        # Parentheses and trailing commas are stripped so that reordering a citation group,
        # "(A 2006; B 2008)" to "(B 2008; A 2006)", is not mistaken for a changed citation.
        found = [t for t in map(_strip_lead, re.findall(pat, flat)) if t]
        return [t.replace("(", "").replace(")", "").replace(RSQ, "'").strip(", ") for t in found]
    if cls == "crossrefs":
        return re.findall(
            r"\\(?:ref|eqref|autoref|cref|Cref|label) ?\{[^}]*\}|\]\((?:[^()]|\([^()]*\))*\)|"
            r"\]\[[^\]]*\]", flat) + [
            # Reference definitions, "[id]: url" or "[id]:url"; the space is normalized.
            m.group(1) + " " + m.group(2) for m in re.finditer(r"(\[[^\]]+\]:) ?([^ ]+)", flat)] + re.findall(r"!\[", flat) + re.findall(
            r"\[\^[^\]]+\]", flat) + re.findall(r"<(?:https?://|mailto:)[^>\s]+>|<[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+>", flat) + [
            # Bare URLs, outside link destinations and autolinks; trailing punctuation dropped.
            u.rstrip(".,;:!?") for u in re.findall(r"(?<![<({/\w])https?://[^\s<>()\[\]{}\"']+", flat)] + [
            # "![" marks an image; "[^id]" is a footnote reference; <https://...> is an autolink
            # The opening "[" of an inline or reference link; the link text stays editable.
            "[" for _ in re.finditer(r"\[(?=[^\[\]]*\] ?[\[(])", flat)] + [
            # Shortcut reference links, "[label]" whose label has a "[label]: url" definition.
            "[" + m.group(1) + "]" for m in re.finditer(r"\[([^\[\]^]+)\](?![\[(:])", flat)
            if m.group(1).lower() in {d.lower() for d in re.findall(r"\[([^\[\]^]+)\]:", flat)}]
    if cls == "callouts":
        pat = (r"(?:(?:table|figure|section|appendix|column|panel|equation)s?|appendices|figs?\.|eqs?\.)"
               # Roman numerals (uppercase only, so "the figure did" is not a callout): "Section IV".
               r"[ ~]\(?(?:[0-9]+(?:\.[0-9]+)?[a-z]?|(?-i:[IVXLCDM]+)|[a-z][0-9]*)\b" + _PANEL +
               # Later items in a list ("Tables 1, 2 and 3") may not start with 0, so a
               # decimal such as the coefficient 0.15 is not swallowed as a table number.
               # (check-protected.sh lacks this guard; its examples never trigger it.)
               r"(?:,?[ ~](?:and[ ~]|to[ ~])?(?:[1-9][0-9]*(?:\.[0-9]+)?[a-z]?|(?-i:[IVXLCDM]+)|[a-z][0-9]*)\b"
               + _PANEL + r")*")
        return [t.lower() for t in re.findall(pat, flat, re.I)]
    if cls == "math":
        out = [t for t in _dollar_math(flat)
               if not re.match(r"^\$[0-9][0-9,.]* (million|billion|trillion|thousand|hundred|k|bn|mn)( .*)?\$$", t)]
        out += re.findall(r"\\\(.*?\\\)", flat)
        out += re.findall(r"\\\[.*?\\\]", flat)
        return out
    if cls == "equations":
        return [re.sub(r"\s", "", t) for t in _EQUATION_RE.findall(flat) + _RELATION_RE.findall(flat)]
    if cls == "symbols":
        return _SYMBOL_RE.findall(flat.replace("\u00b5", "\u03bc"))  # micro sign == Greek mu
    if cls == "environments":
        # Every \begin/\end marker is protected. Whole contents, read from the raw text
        # with line breaks, are frozen only for environments whose contents are not prose
        # (code, verbatim, tables, display math); prose environments such as abstract,
        # itemize, or quote stay editable, with their numbers, citations, macros, and so on
        # still checked by the other classes. (check-protected.sh freezes every environment.)
        text = _strip_captions("\n".join(ln.rstrip() for ln in raw.splitlines()))
        out = re.findall(r"\\(?:begin|end)\{[^}]*\}", text)
        names = "|".join(re.escape(n) for n in _FROZEN_ENVS)
        out += [m.group(0) for m in re.finditer(r"\\begin\{(" + names + r")\}.*?\\end\{\1\}", text, re.S)]
        return out
    if cls == "macros":
        return _macros(flat)
    if cls == "emphasis":
        return _emphasis(flat)
    if cls == "quotes":
        # A straight double quote right after a digit is an inch mark (5"), not an opening quote.
        out = re.findall(r'(?<![0-9])"[^"]+"|``[^`]+\'\'', flat)
        out += re.findall(LDQ + "[^" + LDQ + RDQ + "]*" + RDQ, flat)
        out += re.findall(LSQ + "[^" + LSQ + RSQ + "]*" + RSQ, flat)
        # Straight single quotes: an opening ' not preceded by a letter or digit and a
        # closing ' not followed by one, so apostrophes ("don't", "authors'") do not pair.
        # An apostrophe between letters ("author's", "don't") stays inside the quote.
        out += re.findall(r"(?<![A-Za-z0-9'])'(?=\S)(?:[^'\n]|(?<=[A-Za-z])'(?=[A-Za-z])){1,200}?(?<=\S)'"
                          r"(?![A-Za-z0-9'])", flat)
        out += re.findall("\u00ab[^\u00ab\u00bb]*\u00bb|\u2039[^\u2039\u203a]*\u203a", flat)  # guillemets
        return out
    if cls == "comments":
        out = [ln for ln in raw.splitlines() if re.match(r"^\s*(%|>)", ln)]
        # Markdown table rows: the structure (separator rows whole, the pipes of other rows)
        # is protected; cell prose stays editable, its numbers and citations still checked.
        out += [ln.strip() if re.fullmatch(r"[\s|:\-]+", ln) else re.sub(r"[^|]", "", ln)
                for ln in _table_rows(raw)]
        # Trailing LaTeX comments: an unescaped % after text, with or without a space, but
        # not after a number, so a percentage ("5 %", "5%") is not mistaken for a comment.
        out += re.findall(r"(?<=[^0-9\\\s])\s*(%.*)$", raw, re.M)
        # ATX heading markers: up to 3 spaces of indent, then a space, a tab, or the line end.
        out += [h + " " for h in re.findall(r"^ {0,3}(#{1,6})(?:[ \t]|$)", raw, re.M)]
        # Setext heading underlines ("=====", "-----"), kept as their character only.
        out += [m[0] for m in re.findall(r"^ {0,3}(=+|-+)[ \t]*$", raw, re.M)]
        # Markdown hard breaks: two or more trailing spaces, or a trailing backslash, before
        # another line of the same paragraph.
        out += ["  " if m[0] == " " else "\\" for m in re.findall(r"( {2,}|\\)\n(?=[ \t]*\S)", raw)]
        # Thematic breaks ("***", "___", "* * *"), kept as their character only.
        out += re.findall(r"^ {0,3}([*_])(?:[ \t]*\1){2,}[ \t]*$", raw, re.M)
        out += _list_markers(raw)
        return out
    if cls == "code":
        # Fenced blocks (~~~ or ```) first, each whole block as one token so reordering
        # lines or blocks is caught; inline `...` spans are looked for only outside them,
        # so the backticks of two fences never pair up across prose.
        out, fence, block, prose = [], None, [], []
        for ln in raw.splitlines():
            m = re.match(r"\s*(~{3,}|`{3,})", ln)
            if fence is None and m:
                fence, block = m.group(1), [ln]
            elif fence is not None:
                block.append(ln)
                # CommonMark: closed only by a bare fence of the same character that is at
                # least as long, so a ``` block inside a ```` block stays inside it.
                c = re.match(r"\s*(~{3,}|`{3,})\s*$", ln)
                if c and c.group(1)[0] == fence[0] and len(c.group(1)) >= len(fence):
                    out.append("\n".join(block))
                    fence = None
            else:
                prose.append(ln)
        if fence is not None:
            out.append("\n".join(block))  # unclosed fence: the rest is code
        # All fenced blocks form one token in document order, so swapping two whole
        # blocks is caught (each class is compared as a multiset).
        out = ["\n\n".join(out)] if out else []
        # Inline spans may use any run of backticks (``a ` b``); the closing run matches it.
        return out + [m.group(0) for m in
                      re.finditer(r"(?<!`)(`+)(?!`)(.+?)(?<!`)\1(?!`)", "\n".join(prose), re.S)]
    if cls == "numbers":
        out = []
        for m in _NUMBER_RE.finditer(flat):
            tok = m.group(0)
            if m.group("uword"):
                head, *rest = m.group("uword").lower().split(" ")
                tok = (tok[:m.start("uword") - m.start() - 1] + " " + " ".join([head.rstrip("s")] + rest)
                       + tok[m.end("uword") - m.start():])
            # Words ("Less than", "Percent", "Million") are compared case-blind; unit symbols
            # keep their case, so mM is not mm and MHz is not mHz.
            tok = re.sub(r"[A-Za-z]{3,}", lambda w: w.group(0) if re.fullmatch(_UNIT_ONE, w.group(0))
                         else w.group(0).lower(), tok).replace("\u00b5", "\u03bc")
            tok = re.sub(r"(?<=[0-9]) %", "%", tok)  # "5 %" and "5%" are the same value
            out.append(tok)
        return out
    if cls == "numberwords":
        out, prev_end, prev_unit = [], None, False
        for m in _NUMWORD_RE.finditer(flat):
            tok = m.group(0).lower()
            if m.group("unit"):  # plural and singular units agree, as for digit numbers
                head, *rest = m.group("unit").lower().split(" ")
                tok = tok[:m.start("unit") - m.start()] + " ".join([head.rstrip("s")] + rest)
            # Adjacent number words are one compound number, in order ("one hundred and five"),
            # so 105 written as 501 is caught; "and" joins only after hundred, thousand, ...
            # Spelled-out ranges, ratios, and decimals ("five to ten", "one in five", "two out
            # of three", "one point five") are ordered tokens too, as digit ones are.
            gap = flat[prev_end:m.start()].lower() if prev_end is not None else None
            if out and (gap in (" to ", " in ", " out of ", " point ") or not prev_unit and (gap == " " or (
                    gap == " and " and re.search(r"(?:hundred|thousand|million|billion)$", out[-1])))):
                out[-1] += gap + tok
            else:
                out.append(tok)
            prev_end, prev_unit = m.end(), bool(m.group("unit"))
        return out
    raise ValueError(cls)


def _prep(text):
    text = re.sub(r"^\[[PR][0-9]+(\.[0-9]+)?\] ?", "", text, flags=re.M)
    flat = re.sub(r"\s+", " ", text).strip()
    return text, flat


def check(original, revised):
    """Compare protected content. Returns {'passed': bool, 'diffs': {class: {...}}}."""
    o_raw, o_flat = _prep(original)
    r_raw, r_flat = _prep(revised)
    diffs = {}
    for cls in CLASSES:
        a = Counter(tokens(cls, o_raw, o_flat))
        b = Counter(tokens(cls, r_raw, r_flat))
        removed = sorted((a - b).elements())
        added = sorted((b - a).elements())
        if removed or added:
            diffs[cls] = {"removed": removed, "added": added}
    # Citation order: the same citations in a different order inside one group.
    og, rg = Counter(_citation_groups(o_flat)), Counter(_citation_groups(r_flat))
    removed, added = [], []
    for g in (og - rg).elements():
        for h in (rg - og).elements():
            if g != h and frozenset(g) == frozenset(h):
                removed.append("; ".join(g))
                added.append("; ".join(h))
                break
    if removed:
        diffs["citation_order"] = {"removed": removed, "added": added}
    return {"passed": not diffs, "diffs": diffs}


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(2)
    with open(sys.argv[1]) as f:
        original = f.read()
    with open(sys.argv[2]) as f:
        revised = f.read()
    result = check(original, revised)
    if result["passed"]:
        print("PASS: no protected content changed.")
        return
    print("FLAG: protected content differs.")
    for cls, d in result["diffs"].items():
        print(f"  [{cls}] removed={d['removed']} added={d['added']}")
    sys.exit(1)


if __name__ == "__main__":
    main()
