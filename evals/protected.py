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

CLASSES = ["citations", "authoryear", "crossrefs", "callouts", "math", "symbols", "environments",
           "macros", "emphasis", "quotes", "comments", "code", "numbers", "numberwords"]

_PROSE_MACROS = {"caption", "emph", "textbf", "textit", "footnote", "section",
                 "subsection", "subsubsection", "paragraph"}

_NAME = r"(?:[A-Z][A-Za-z'.&-]+|van|von|der|de|del|da|di|la|le|ter|ten|dos|and|et|al\.?|&)"
_DATE_LEAD = re.compile(
    r"^(In|On|At|By|For|From|Since|After|Before|During|Until|Between|Around|Over|Under|"
    r"The|A|An|As|Of|To|With|When|While|January|February|March|April|May|June|July|August|"
    r"September|October|November|December|Early|Late|Mid) ")

_NUM = r"(?:[0-9]+(?:,[0-9]{3})*(?:\.[0-9]+)?|\.[0-9]+)"
# Scientific units, matched case-sensitively (mM is not mm) and only as whole words, so
# "10 mg" to "10 kg" or "20 \u00b0C" to "20 \u00b0F" is caught. Spelled-out units are matched
# too, with the hyphen and plural normalized so "10 grams" and "a 10-gram dose" agree.
_MICRO = "(?:µ|μ)"
_UNIT_SYM = (r"(?-i:(?:[kmn]|" + _MICRO + r")?(?:g|l|L|m|M|mol|s|V|W|J|Hz|Pa)|mL|cm|kcal|cal|"
             r"min|h|hr|hrs|K|kDa|Da|bp|kb|Mb|[KMGT]B|° ?[CF]|°)(?![A-Za-z0-9])")
_UNIT_WORD = (r"(?:(?:micro|milli|centi|kilo|nano)?(?:grams?|litres?|liters?|meters?|metres?|"
              r"moles?|seconds?|minutes?|hours?|volts?|watts?|joules?)|degrees?(?: (?:celsius|fahrenheit))?|"
              r"kelvin|hertz|calories?)\b")
_NUMBER_RE = re.compile(
    r"(?:(?:less than|more than|greater than|fewer than|at least|at most|up to|approximately|"
    r"about|around|roughly|nearly|exceeding|below|above) )?"
    # The space after a comparator belongs to the token; a space before the number does not,
    # so a number that moves to the start of a sentence is the same token.
    r"(?:(?:[<>]=?|" + ULE + "|" + UGE + r")[ ~]?|~)?(?:[+-]|" + UMIN + r")?"
    r"(?:\$|" + EUR + "|" + GBP + "|" + YEN + r")?" + _NUM + r"(?:-" + _NUM + r")?%?"
    r"(?:(?: |-)(?:percentage points?|percentage|percent|points?|pp|bps|million|billion|"
    r"thousand|fold|star|stars)|(?: |-)(?P<uword>" + _UNIT_WORD + r")|(?: |-)?(?P<unit>" + _UNIT_SYM + r"))?",
    re.I)
_NUMWORD_RE = re.compile(
    r"\b(?:(?:zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|"
    r"fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|"
    r"seventy|eighty|ninety|hundred|thousand|million|billion|twice|half|dozen)(?:-[a-z]+)?|"
    r"(?:first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth)-[a-z]+)\b", re.I)


# Mathematical symbols written as Unicode in prose, outside any math delimiters: Greek
# letters, operators, arrows, letterlike symbols (\u211d), sub/superscripts, primes, and
# math alphanumerics. Each character is one token, so "\u03b2" to "\u03b3" is caught.
_SYMBOL_RE = re.compile(
    "[\u0370-\u03ff\u00b1\u00d7\u00f7\u00b2\u00b3\u00b9\u2032-\u2037\u2070-\u209f"
    "\u2100-\u214f\u2190-\u21ff\u2200-\u22ff\u27c0-\u27ef\u2980-\u2aff"
    "\U0001d400-\U0001d7ff]")

# Markdown emphasis. The delimiters are protected markup; the text inside is editable
# prose, so only the delimiters are compared (as \emph and \textbf are, by name only).
# Spans that cannot hold emphasis (math, code, macro arguments, link targets) are blanked
# first, and a delimiter touching a word character ("0.05**", snake_case) is not emphasis.
_NO_EMPHASIS = re.compile(r"`[^`]+`|\$\$[^$]+\$\$|\$[^$]+\$|\\\(.*?\\\)|\\\[.*?\\\]|"
                          r"\\[A-Za-z]+\*?(?:\[[^\]]*\])*\{[^}]*\}|\]\([^)]*\)")
_STRONG_RE = re.compile(r"(?<![*_\w\\])(\*\*|__)(?=[^\s*_])(.+?)(?<=[^\s*_\\])\1(?![*_\w])")
_EM_RE = re.compile(r"(?<![*_\w\\])([*_])(?=[^\s*_])(.+?)(?<=[^\s*_\\])\1(?![*_\w])")

# Numeric citation groups, "[12]" or "[12, 13]" or "[3-5]". The whole bracket is one
# token, so reordering the numbers inside a group is caught.
_NUMCITE_RE = re.compile(r"\[ ?[0-9]+(?: ?[,;\u2013-] ?[0-9]+)* ?\]")


def _emphasis(flat):
    text = _NO_EMPHASIS.sub(" ", flat)
    out = []
    for pat in (_STRONG_RE, _EM_RE):
        out += [m.group(1) for m in pat.finditer(text)]
        text = pat.sub(lambda m: m.group(2), text)
    return out


_AY_PAT = re.compile(_NAME + r"(?:,? " + _NAME + r")*,? \(?[12][0-9]{3}[a-z]?\)?")


def _citation_groups(flat):
    """Ordered author-year groups inside one parenthetical, e.g. (A 2006; B 2008).

    Only groups of two or more citations are returned. A whole group may move to
    another sentence, but the order inside it must not change.
    """
    groups = []
    for span in re.findall(r"\(([^()]*[12][0-9]{3}[^()]*)\)", flat):
        toks = [t.replace("(", "").replace(")", "").strip(", ")
                for t in _AY_PAT.findall(span) if not _DATE_LEAD.match(t)]
        if len(toks) >= 2:
            groups.append(tuple(toks))
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
        if name in _PROSE_MACROS:
            out.append(tok)
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
            re.sub(r" ", "", t).replace("\u2013", "-") for t in _NUMCITE_RE.findall(flat)]
    if cls == "authoryear":
        pat = (_NAME + r"(?:,? " + _NAME + r")*,? \(?[12][0-9]{3}[a-z]?\)?")
        # Parentheses and trailing commas are stripped so that reordering a citation group,
        # "(A 2006; B 2008)" to "(B 2008; A 2006)", is not mistaken for a changed citation.
        found = [t for t in re.findall(pat, flat) if not _DATE_LEAD.match(t)]
        return [t.replace("(", "").replace(")", "").strip(", ") for t in found]
    if cls == "crossrefs":
        return re.findall(
            r"\\(?:ref|eqref|autoref|cref|Cref|label) ?\{[^}]*\}|\]\((?:[^()]|\([^()]*\))*\)|"
            r"\]\[[^\]]*\]|\[[^\]]+\]: [^ ]+", flat)
    if cls == "callouts":
        pat = (r"(?:table|figure|fig\.|section|appendix|appendices|column|panel|equation|eq\.)s?"
               r"[ ~]\(?(?:[0-9]+(?:\.[0-9]+)?[a-z]?|[a-z][0-9]*)\b"
               # Later items in a list ("Tables 1, 2 and 3") may not start with 0, so a
               # decimal such as the coefficient 0.15 is not swallowed as a table number.
               # (check-protected.sh lacks this guard; its examples never trigger it.)
               r"(?:,?[ ~](?:and[ ~]|to[ ~])?(?:[1-9][0-9]*(?:\.[0-9]+)?[a-z]?|[a-z][0-9]*)\b)*")
        return [t.lower() for t in re.findall(pat, flat, re.I)]
    if cls == "math":
        out = [t for t in re.findall(r"\$\$[^$]+\$\$|\$[^$]+\$", flat)
               if not re.match(r"^\$[0-9][0-9,.]* (million|billion|trillion|thousand|hundred|k|bn|mn)( .*)?\$$", t)]
        out += re.findall(r"\\\(.*?\\\)", flat)
        out += re.findall(r"\\\[.*?\\\]", flat)
        return out
    if cls == "symbols":
        return _SYMBOL_RE.findall(flat.replace("\u00b5", "\u03bc"))  # micro sign == Greek mu
    if cls == "environments":
        # Read from the raw text, not the flattened one: line breaks inside an environment
        # (lstlisting, verbatim, tabular) are protected, so joining two lines is a change.
        text = _strip_captions("\n".join(ln.rstrip() for ln in raw.splitlines()))
        return [m.group(0) for m in re.finditer(r"\\begin\{([^}]*)\}.*?\\end\{\1\}", text, re.S)]
    if cls == "macros":
        return _macros(flat)
    if cls == "emphasis":
        return _emphasis(flat)
    if cls == "quotes":
        out = re.findall(r'"[^"]+"|``[^`]+\'\'', flat)
        out += re.findall(LDQ + "[^" + LDQ + RDQ + "]*" + RDQ, flat)
        out += re.findall(LSQ + "[^" + LSQ + RSQ + "]*" + RSQ, flat)
        return out
    if cls == "comments":
        out = [ln for ln in raw.splitlines() if re.match(r"^\s*(%|> )|^\|", ln)]
        out += re.findall(r"^#{1,6} ", raw, re.M)
        return out
    if cls == "code":
        out, inb = [], False
        for ln in raw.splitlines():
            if ln.startswith("~~~"):
                inb = not inb
                out.append(ln)
            elif inb:
                out.append(ln)
        return out + re.findall(r"`[^`]+`", raw)
    if cls == "numbers":
        out = []
        for m in _NUMBER_RE.finditer(flat):
            tok = m.group(0)
            if m.group("unit"):
                cut = m.start("unit") - m.start()
                tok = tok[:cut].lower() + tok[cut:].replace("\u00b5", "\u03bc")
            elif m.group("uword"):
                head, *rest = m.group("uword").lower().split(" ")
                tok = tok[:m.start("uword") - m.start() - 1].lower() + " " + " ".join([head.rstrip("s")] + rest)
            else:
                tok = tok.lower()
            out.append(tok)
        return out
    if cls == "numberwords":
        return [m.group(0).lower() for m in _NUMWORD_RE.finditer(flat)]
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
