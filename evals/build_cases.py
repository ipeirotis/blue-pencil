#!/usr/bin/env python3
"""Turn the repo's worked examples into pilot test cases.

Each case is the *input* half of an example (the author's rough passage), plus
its paper context and the request the author made. The skill's own output half
is deliberately not used. Only examples whose stage is `first draft` are taken,
because the pilot runs /paper:revise at the first-draft stage.

Hand-written cases (an origin other than "repo example" in cases.json) are kept
when the catalog is rebuilt.

NOTE: these passages were written to show the skill off, so they are good for
getting the pipeline working but not for judging how well the skill generalizes.
Real passages from published papers come next.
"""

import re
import sys
from pathlib import Path

from lib import EVALS, REPO, read_json, write_json


def input_block(lines):
    """Last fenced block before '## Skill output' that is not the context block."""
    # A block closes only on a fence at least as long as the one that opened it, so a
    # passage wrapped in four backticks may hold a three-backtick code block.
    blocks, buf, fence = [], [], None
    for line in lines:
        if line.startswith("## Skill output"):
            break
        m = re.match(r"`{3,}", line)
        if fence is None:
            if m:
                fence, buf = m.group(0), []
            continue
        if m and len(m.group(0)) >= len(fence) and not line[m.end():].strip():
            text = "\n".join(buf)
            if "revision_stage:" not in text:
                blocks.append(text)
            fence = None
            continue
        buf.append(line)
    return blocks[-1].strip() if blocks else ""


def context_block(text):
    m = re.search(r"<paper_context>.*?</paper_context>", text, re.S)
    return m.group(0) if m else ""


def request_text(lines):
    out, started = [], False
    for line in lines:
        if line.startswith("The request:"):
            started = True
            continue
        if started:
            if line.startswith(">"):
                out.append(line[1:].strip())
            elif out:
                break
    return " ".join(out)


def main():
    # A hand-written case (any origin other than a repo example) must never share an id with
    # an example: the loop below would overwrite its files. Check before writing anything.
    catalog = EVALS / "cases" / "cases.json"
    hand = {c["id"] for c in read_json(catalog)["cases"] if c.get("origin") != "repo example"} \
        if catalog.exists() else set()
    clash = sorted(hand & {p.stem for p in (REPO / "examples").glob("*.md")})
    if clash:
        sys.exit(f"example files share an id with hand-written cases: {', '.join(clash)}; rename one")
    cases = []
    for path in sorted((REPO / "examples").glob("*.md")):
        text = path.read_text()
        if "## Skill output" not in text:
            continue
        ctx = context_block(text)
        if "revision_stage: first draft" not in ctx:
            continue
        lines = text.splitlines()
        passage = input_block(lines)
        request = request_text(lines)
        if not (passage and request and ctx):
            print(f"skip {path.name}: could not extract all parts", file=sys.stderr)
            continue
        cid = path.stem
        d = EVALS / "cases" / cid
        d.mkdir(parents=True, exist_ok=True)
        (d / "input.txt").write_text(passage + "\n")
        (d / "context.txt").write_text(ctx + "\n")
        (d / "request.txt").write_text(request + "\n")
        cases.append({"id": cid, "source": f"examples/{path.name}",
                      "revision_stage": "first draft", "origin": "repo example"})
        print(f"case {cid}: {len(passage.split())} words")
    # Keep hand-written cases (any origin other than a repo example): they have no
    # example to rebuild from, and rewriting the catalog must not drop them.
    if catalog.exists():
        built = {c["id"] for c in cases}
        cases += [c for c in read_json(catalog)["cases"]
                  if c.get("origin") != "repo example" and c["id"] not in built]
    write_json(catalog, {"cases": cases})


if __name__ == "__main__":
    main()
