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

CLASSES = ["citations", "authoryear", "crossrefs", "callouts", "math", "environments",
           "macros", "quotes", "comments", "code", "numbers", "numberwords"]

_PROSE_MACROS = {"caption", "emph", "textbf", "textit", "footnote", "section",
                 "subsection", "subsubsection", "paragraph"}

_NAME = r"(?:[A-Z][A-Za-z'.&-]+|van|von|der|de|del|da|di|la|le|ter|ten|dos|and|et|al\.?|&)"
_DATE_LEAD = re.compile(
    r"^(In|On|At|By|For|From|Since|After|Before|During|Until|Between|Around|Over|Under|"
    r"The|A|An|As|Of|To|With|When|While|January|February|March|April|May|June|July|August|"
    r"September|October|November|December|Early|Late|Mid) ")

_NUM = r"(?:[0-9]+(?:,[0-9]{3})*(?:\.[0-9]+)?|\.[0-9]+)"
_NUMBER_RE = re.compile(
    r"(?:(?:less than|more than|greater than|fewer than|at least|at most|up to|approximately|"
    r"about|around|roughly|nearly|exceeding|below|above) )?"
    r"(?:(?:[<>]=?|" + ULE + "|" + UGE + r"))?[ ~]?(?:[+-]|" + UMIN + r")?"
    r"(?:\$|" + EUR + "|" + GBP + "|" + YEN + r")?" + _NUM + r"(?:-" + _NUM + r")?%?"
    r"(?:(?: |-)(?:percentage points?|percentage|percent|points?|pp|bps|million|billion|"
    r"thousand|fold|star|stars))?", re.I)
_NUMWORD_RE = re.compile(
    r"\b(?:(?:zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|"
    r"fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|"
    r"seventy|eighty|ninety|hundred|thousand|million|billion|twice|half|dozen)(?:-[a-z]+)?|"
    r"(?:first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth)-[a-z]+)\b", re.I)


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
            r"-?@[A-Za-z0-9_][A-Za-z0-9_:-]*(?:\.[A-Za-z0-9_:-]+)*", flat)
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
    if cls == "environments":
        text = _strip_captions(flat)
        return [m.group(0) for m in re.finditer(r"\\begin\{([^}]*)\}.*?\\end\{\1\}", text, re.S)]
    if cls == "macros":
        return _macros(flat)
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
        return [m.group(0).lower() for m in _NUMBER_RE.finditer(flat)]
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
