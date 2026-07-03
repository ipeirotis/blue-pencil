#!/usr/bin/env bash
# Example-format conformance (review item B-M8, plus the Batch 2 output
# contract). The files in examples/ are the skill's de facto spec, so CI
# locks them to the strict output format in SKILL.md; before this check,
# format drift in the examples went unnoticed (review item B-D10 happened).
#
# For every examples/*.md that carries a '## Skill output' section:
#   1. The four exact headings appear once each, in order.
#   2. 'Change rationale' opens with a 'Word count:' line in the required
#      shape, unless the run is feedback-only ('No rewrite requested.').
#   3. Every 'Author questions' bullet ends with a question mark ('None.'
#      is the only alternative).
#   4. The 'Revised text' fenced block contains no banned tell from
#      references/ai-tells-to-avoid.md in any paragraph the pass edited.
#      A paragraph returned verbatim from the input is exempt: that is
#      the deliberate-verbatim case (unflagged paragraphs at 'response
#      to reviewers' keep their tells), detected by comparing flattened
#      paragraphs instead of trusting a hand-kept whitelist.
#   5. Extraction-line consistency: a first-draft example whose Diagnosis
#      names a teaching gap from the exposition catalogue must carry the
#      three extraction lines (this failed on worked-example.md before
#      review item B-D10a). A first-draft Diagnosis must also open with
#      'Voice tics:' and 'Reader map:', and a final-polish or
#      response-to-reviewers Diagnosis must carry neither those headers
#      nor any extraction line (the SKILL.md Diagnosis table).
#   6. A mandatory 'Added bridges:' line immediately follows the
#      'Revised text' fenced block, and no [P1]-style editor label sits
#      inside the block (review item B-D10d).
#   7. Any 'Reader map:' line follows the SKILL.md template:
#      starts with ...; must learn ...; should leave with ...
# Used by CI and `make test`.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail=0

err() {
  echo "ERROR: $1" >&2
  fail=1
}

# Section extractors. Sections are delimited by the strict headings; the
# 'Author questions' section ends at the next h2 (every example follows the
# output with commentary) or at end of file.
diagnosis_of()  { awk '/^### 1\. Diagnosis$/{f=1;next} /^### 2\. Revised text$/{f=0} f' "$1"; }
revised_of()    { awk '/^### 2\. Revised text$/{f=1;next} /^### 3\. Change rationale$/{f=0} f' "$1"; }
rationale_of()  { awk '/^### 3\. Change rationale$/{f=1;next} /^### 4\. Author questions$/{f=0} f' "$1"; }
questions_of()  { awk '/^### 4\. Author questions$/{f=1;next} f && /^## /{exit} f' "$1"; }

# The fenced block inside the 'Revised text' section, and what follows it.
revised_block_of() { revised_of "$1" | awk '/^```/{fence++;next} fence==1{print} fence>=2{exit}'; }
after_block_of()   { revised_of "$1" | awk '/^```/{fence++;next} fence>=2{print}'; }

# The input block: the last fenced block before '## Skill output'. Used to
# detect paragraphs the pass returned verbatim.
input_block_of() {
  awk '
    /^## Skill output/ { exit }
    /^```/ { inb = !inb; if (inb) { buf = "" } else { last = buf }; next }
    inb { buf = buf $0 "\n" }
    END { printf "%s", last }
  ' "$1"
}

# Normalize for paragraph comparison: drop [P1]-style editor labels, then
# flatten each blank-line-separated paragraph to one whitespace-collapsed
# line (example prose is hard-wrapped).
strip_labels() { sed -E 's/\[[PR][0-9]+(\.[0-9]+)?\]//g'; }
flat_paras() {
  awk 'BEGIN{RS=""} {gsub(/\n/," "); gsub(/[[:space:]]+/," "); sub(/^ +/,""); sub(/ +$/,""); print}'
}

# Banned tells scanned inside 'Revised text' blocks. Single words are
# matched as whole words, phrases as case-insensitive substrings; both
# lists are drawn from references/ai-tells-to-avoid.md and cover every
# entry that is mechanically decidable. Deliberately excluded are the
# catalogue's judgment calls, words banned only in a generic or decorative
# sense that grep cannot tell from the legitimate technical use ("robust"
# vs "robust to X", statistical "significant", "key", "navigate a
# website"): those belong to the read-cold pass, not CI.
TELL_WORDS=(
  furthermore moreover crucially importantly notably ultimately
  delve delves delved delving
  leverage leverages leveraged leveraging
  utilize utilizes utilized utilizing
  novel holistic multifaceted nuanced seamless streamlined
)
TELL_PHRASES=(
  "it is important to note"
  "it's worth noting"
  "it should be mentioned"
  "having said that"
  "that said,"
  "it is well known that"
  "a myriad of"
  "a plethora of"
  "a wide array of"
  "a host of"
  "a wealth of"
  "rich tapestry"
  "tapestry of"
  "mosaic of"
  "the landscape of"
  "the realm of"
  "the sphere of"
  "paradigm shift"
  "game-changer"
  "sea change"
  "watershed moment"
  "in today's"
  "in an era of"
  "now more than ever"
  "continues to evolve"
  "imagine a world"
  "picture this:"
  "consider the following scenario"
  "deep dive"
  "we embark"
  "our journey"
  "speak for themselves"
  "tells a story"
  "reveal their secrets"
  "but here is the catch"
  "here is the twist"
  "navigate the"
  "plays a key role"
  "plays a central role"
  "plays a crucial role"
  "plays a vital role"
  "plays a pivotal role"
  "underscores the importance of"
  "highlights the importance of"
  "emphasizes the importance of"
  "demonstrates the importance of"
  "underscores the need for"
  "highlights the need for"
)

# Teaching-gap vocabulary from the references/exposition.md catalogue; any
# of these in a first-draft Diagnosis triggers the three extraction lines.
GAP_TERMS=(
  "definition debt"
  "machinery before motive"
  "compressed inference"
  "expert-only contrast"
  "abstract stack"
  "buried lede"
  "payoff inversion"
  "missing payoff"
  "rather than a payoff"
  "ends on procedure"
  "concept overload"
  "unanchored abstraction"
  "teaching gap"
)

WC_RE='^Word count: [0-9,~]+ to [0-9,~]+ \([+-][0-9]+%\)\.'

H1='### 1. Diagnosis'
H2='### 2. Revised text'
H3='### 3. Change rationale'
H4='### 4. Author questions'

checked=0
while IFS= read -r f; do
  grep -q '^## Skill output' "$f" || continue
  checked=$((checked + 1))

  # 1. Four exact headings, once each, in order.
  positions=""
  ok=1
  for h in "$H1" "$H2" "$H3" "$H4"; do
    n="$(awk -v h="$h" '$0==h{print NR}' "$f" | head -2)"
    if [ -z "$n" ] || [ "$(printf '%s\n' "$n" | wc -l)" -ne 1 ]; then
      err "$f: heading '$h' must appear exactly once."
      ok=0
    else
      positions="$positions $n"
    fi
  done
  if [ "$ok" -eq 1 ]; then
    sorted="$(printf '%s\n' "$positions" | tr ' ' '\n' | sed '/^$/d' | sort -n | tr '\n' ' ')"
    unsorted="$(printf '%s\n' "$positions" | tr ' ' '\n' | sed '/^$/d' | tr '\n' ' ')"
    if [ "$sorted" != "$unsorted" ]; then
      err "$f: the four output headings are out of order."
    fi
  fi

  revised_section="$(revised_of "$f")"
  feedback_only=0
  if printf '%s\n' "$revised_section" | grep -qF 'No rewrite requested.'; then
    feedback_only=1
  fi

  # 2. Word-count line, and it must OPEN the rationale (SKILL.md: "Open
  #    with `Word count: ...`"), not sit buried after prose.
  if [ "$feedback_only" -eq 0 ]; then
    first_rationale="$(rationale_of "$f" | sed '/^[[:space:]]*$/d' | head -1)"
    if ! printf '%s\n' "$first_rationale" | grep -qE "$WC_RE"; then
      err "$f: 'Change rationale' must open with a 'Word count: <before> to <after> (<signed percent>).' line (got: ${first_rationale:-nothing})."
    fi
  fi

  # 3. Author-questions bullets end with '?'.
  questions="$(questions_of "$f")"
  bad_bullets="$(printf '%s\n' "$questions" | awk '
    function flush() {
      if (b != "") {
        gsub(/[[:space:]]+$/, "", b)
        if (b !~ /\?$/) print b
        b = ""
      }
    }
    /^- /                        { flush(); b = $0; next }
    /^[[:space:]]+[^[:space:]]/  { if (b != "") b = b " " $0; next }
                                 { flush() }
    END                          { flush() }
  ')"
  if [ -n "$bad_bullets" ]; then
    err "$f: 'Author questions' bullet does not end with '?': $(printf '%s' "$bad_bullets" | head -1)"
  fi
  if ! printf '%s\n' "$questions" | grep -qE '^(- |None\.)'; then
    err "$f: 'Author questions' must carry bullets or 'None.'"
  fi

  # 4. Banned tells inside the 'Revised text' fenced block, scanned per
  #    paragraph. A paragraph that also appears verbatim in the input block
  #    was returned, not written, so its tells are exempt; every edited
  #    paragraph must be clean. Paragraphs are flattened first because the
  #    prose is hard-wrapped.
  block="$(revised_block_of "$f")"
  if [ -z "$block" ] && [ "$feedback_only" -eq 0 ]; then
    err "$f: no fenced block found under 'Revised text'."
  fi
  input_paras="$(input_block_of "$f" | strip_labels | flat_paras)"
  while IFS= read -r para; do
    [ -n "$para" ] || continue
    if printf '%s\n' "$input_paras" | grep -qxF "$para"; then continue; fi
    for w in "${TELL_WORDS[@]}"; do
      if printf '%s\n' "$para" | grep -qiwE "$w"; then
        err "$f: banned tell '$w' in an edited paragraph of the Revised text block."
      fi
    done
    for p in "${TELL_PHRASES[@]}"; do
      if printf '%s\n' "$para" | grep -qiF "$p"; then
        err "$f: banned tell '$p' in an edited paragraph of the Revised text block."
      fi
    done
  done < <(printf '%s\n' "$block" | strip_labels | flat_paras)

  # 6. 'Added bridges:' immediately after the block; no editor labels inside.
  if [ -n "$block" ]; then
    # The whole (hard-wrapped) Added bridges paragraph, flattened: it must
    # read exactly 'None.' or open with a quote and keep its quotation
    # marks balanced, so a truncated or unterminated bridge quote fails.
    ab_para="$(after_block_of "$f" | awk 'BEGIN{RS=""} NR==1{gsub(/\n/," "); gsub(/[[:space:]]+/," "); print; exit}')"
    case "$ab_para" in
      "Added bridges: None.") : ;;
      "Added bridges: \""*)
        qcount="$(printf '%s' "$ab_para" | tr -cd '"' | wc -c)"
        if [ "$qcount" -lt 2 ] || [ $((qcount % 2)) -ne 0 ]; then
          err "$f: the Added bridges line has an incomplete or unbalanced quotation."
        fi
        ;;
      *) err "$f: the Revised text block must be followed by 'Added bridges:' quoting each added bridge or 'None.' (got: ${ab_para:-nothing})." ;;
    esac
    if hit="$(printf '%s\n' "$block" | grep -nE '\[(P|R)[0-9]' | head -1)"; then
      err "$f: editor label inside the Revised text block (no commentary in the block): $hit"
    fi
  fi

  # 5. Diagnosis headers by stage (the SKILL.md Diagnosis table), plus
  #    extraction-line consistency (first draft + named teaching gap). The
  #    gap scan runs on a flattened copy so hard-wrapped phrases still match.
  stage="$(grep -m1 -E '^revision_stage:' "$f" | sed -E 's/^revision_stage:[[:space:]]*//')"
  case "$stage" in
    "first draft"|"final polish"|"response to reviewers") : ;;
    *) err "$f: revision_stage is missing or not a legal stage (got: ${stage:-nothing}); the stage-specific Diagnosis checks cannot run." ;;
  esac
  diagnosis="$(diagnosis_of "$f")"
  if [ "$stage" = "first draft" ]; then
    for line in 'Voice tics:' 'Reader map:'; do
      if ! printf '%s\n' "$diagnosis" | grep -qF "$line"; then
        err "$f: a first-draft Diagnosis must open with a '$line' line."
      fi
    done
    # The headers must OPEN the block: 'Voice tics:' is the first content
    # line and 'Reader map:' precedes the numbered list.
    first_diag="$(printf '%s\n' "$diagnosis" | sed '/^[[:space:]]*$/d' | head -1)"
    case "$first_diag" in
      "Voice tics:"*) : ;;
      *) err "$f: a first-draft Diagnosis must open with 'Voice tics:' (got: ${first_diag:-nothing})." ;;
    esac
    rm_line="$(printf '%s\n' "$diagnosis" | grep -n '^Reader map:' | head -1 | cut -d: -f1)"
    item_line="$(printf '%s\n' "$diagnosis" | grep -nE '^1\. ' | head -1 | cut -d: -f1)"
    if [ -n "$rm_line" ] && [ -n "$item_line" ] && [ "$rm_line" -gt "$item_line" ]; then
      err "$f: 'Reader map:' must precede the numbered Diagnosis list."
    fi
    diagnosis_flat="$(printf '%s\n' "$diagnosis" | tr '\n' ' ' | tr -s '[:space:]' ' ')"
    gap_found=0
    for g in "${GAP_TERMS[@]}"; do
      if printf '%s\n' "$diagnosis_flat" | grep -qiF "$g"; then gap_found=1; break; fi
    done
    if [ "$gap_found" -eq 1 ]; then
      for line in 'Jargon to unpack' 'Buried lede:' 'Concrete anchor:'; do
        if ! printf '%s\n' "$diagnosis" | grep -qF "$line"; then
          err "$f: Diagnosis names a teaching gap at first draft but lacks the '$line' extraction line."
        fi
      done
    fi
  elif [ "$stage" = "final polish" ] || [ "$stage" = "response to reviewers" ]; then
    for line in 'Voice tics:' 'Reader map:' 'Jargon to unpack' 'Buried lede:' 'Concrete anchor:'; do
      if printf '%s\n' "$diagnosis" | grep -qF "$line"; then
        err "$f: a '$stage' Diagnosis must not carry a '$line' line."
      fi
    done
  fi

  # 7. Reader map template.
  if grep -q '^Reader map:' "$f"; then
    reader_map="$(awk '/^Reader map:/{f=1} f && /^[[:space:]]*$/{exit} f{printf "%s ", $0}' "$f")"
    if ! printf '%s\n' "$reader_map" | grep -qE '^Reader map: starts with .*; must learn .*; should leave with .*'; then
      err "$f: 'Reader map:' line drifts from the template 'starts with ...; must learn ...; should leave with ...'."
    fi
  fi
done < <(git ls-files 'examples/*.md')

if [ "$checked" -eq 0 ]; then
  err "no example files with a '## Skill output' section were found."
fi

if [ "$fail" -ne 0 ]; then
  echo "Example conformance failed." >&2
  exit 1
fi
echo "Example conformance OK ($checked examples)."
