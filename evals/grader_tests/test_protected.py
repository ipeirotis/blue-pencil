"""Offline self-test of the code grader (no model calls).

Checks two things for every labeled variant in cases.json:
  - the code grader flags it exactly when we expect it to (it should catch
    changed numbers and citations, and is expected to MISS swapped numbers and
    pure wording damage; those are for the meaning grader),
  - no harmless paraphrase is flagged.
Run:  python3 -m unittest evals/grader_tests/test_protected.py   (from repo root)
"""

import json
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))
from protected import check  # noqa: E402

DATA = json.loads((HERE / "cases.json").read_text())


class ProtectedGraderTest(unittest.TestCase):
    def test_labeled_variants(self):
        for v in DATA["variants"]:
            with self.subTest(v["id"]):
                result = check(DATA["bases"][v["base"]], v["revised"])
                flagged = not result["passed"]
                self.assertEqual(flagged, v["code_grader_should_flag"],
                                 f"{v['id']}: flagged={flagged} diffs={result['diffs']}")

    def test_no_harmless_variant_is_flagged(self):
        for v in DATA["variants"]:
            if v["verdict"] == "harmless":
                with self.subTest(v["id"]):
                    self.assertTrue(check(DATA["bases"][v["base"]], v["revised"])["passed"])

    def test_identity(self):
        for base in DATA["bases"].values():
            self.assertTrue(check(base, base)["passed"])

    def test_repo_examples_pass(self):
        """The skill's own worked examples must not be flagged (parity with check-protected.sh)."""
        sys.path.insert(0, str(HERE.parent))
        import re
        from build_cases import input_block
        for p in sorted((HERE.parents[1] / "examples").glob("*.md")):
            t = p.read_text()
            if "## Skill output" not in t:
                continue
            inp = input_block(t.splitlines())
            m = re.search(r"### 2\. Revised text\s*\n+```[^\n]*\n(.*?)\n```",
                          t[t.index("## Skill output"):], re.S)
            if inp and m:
                with self.subTest(p.name):
                    self.assertTrue(check(inp, m.group(1))["passed"], check(inp, m.group(1)))


if __name__ == "__main__":
    unittest.main()
