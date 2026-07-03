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

# Section extractors, scoped to the region from '## Skill output' onward
# so a lookalike heading inside the manuscript input cannot hijack them.
# Sections are delimited by the strict headings; the 'Author questions'
# section ends at the next h2 (every example follows the output with
# commentary) or at end of file.
diagnosis_of()  { awk '/^## Skill output/{o=1} o && /^### 1\. Diagnosis$/{f=1;next} /^### 2\. Revised text$/{f=0} f' "$1"; }
revised_of()    { awk '/^## Skill output/{o=1} o && /^### 2\. Revised text$/{f=1;next} /^### 3\. Change rationale$/{f=0} f' "$1"; }
rationale_of()  { awk '/^## Skill output/{o=1} o && /^### 3\. Change rationale$/{f=1;next} /^### 4\. Author questions$/{f=0} f' "$1"; }
questions_of()  { awk '/^## Skill output/{o=1} o && /^### 4\. Author questions$/{f=1;next} f && /^## /{exit} f' "$1"; }

# The fenced block inside the 'Revised text' section, and what follows it.
revised_block_of() { revised_of "$1" | awk '/^```/{fence++;next} fence==1{print} fence>=2{exit}'; }
after_block_of()   { revised_of "$1" | awk '/^```/{fence++;next} fence>=2{print}'; }

# The user's request: the blockquote following 'The request:'. Used to
# detect clarity requests, which trigger the extraction lines at first
# draft regardless of the Diagnosis wording.
request_of() {
  awk '/^The request:/{f=1;next} f && /^> /{print substr($0,3)} f && !/^>/ && !/^[[:space:]]*$/{exit}' "$1"
}

# The input block: the last fenced block before '## Skill output' that is
# not the scenario's <paper_context> block. Used to detect paragraphs the
# pass returned verbatim.
input_block_of() {
  awk '
    /^## Skill output/ { exit }
    /^```/ { inb = !inb; if (inb) { buf = "" } else { if (buf !~ /revision_stage:/) last = buf }; next }
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
# website"), and position-dependent frames ("In this paper, we propose"
# is banned only after the contribution paragraph): those belong to the
# read-cold pass, not CI.
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
  "we show that"
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
  "navigate the literature"
  "navigate the landscape"
  "navigate the complexities"
  "navigate uncertainty"
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
  "question before machinery"
  "intuition before formalism"
  "role before name"
  "payoff after effort"
  "concrete anchor after abstraction"
  "one new object at a time"
)

# The contract's counts are approximate: the ~ marker is required
# (SKILL.md Change rationale: "Word count: ~<before> to ~<after> ...").
WC_RE='^Word count: ~[0-9][0-9,]* to ~[0-9][0-9,]* \([+-][0-9]+%\)\.'

H1='### 1. Diagnosis'
H2='### 2. Revised text'
H3='### 3. Change rationale'
H4='### 4. Author questions'

checked=0
while IFS= read -r f; do
  # Every tracked example is a complete run; a missing section must fail,
  # not silently exempt the file from every check below.
  if ! grep -q '^## Skill output' "$f"; then
    err "$f: missing the '## Skill output' section."
    continue
  fi
  checked=$((checked + 1))

  # 1. Four exact headings, once each, in order, scoped to the skill
  #    output (a Markdown manuscript in the input block may legitimately
  #    carry lookalike headings).
  output_region="$(awk '/^## Skill output/{f=1} f' "$f")"
  positions=""
  ok=1
  for h in "$H1" "$H2" "$H3" "$H4"; do
    n="$(printf '%s\n' "$output_region" | awk -v h="$h" '$0==h{print NR}' | head -2)"
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
    # A file whose triage declares a direct rewrite cannot claim the
    # feedback-only exemption: a deleted rewrite must fail, not skip the
    # block checks.
    if grep -qiF "direct rewrite" "$f"; then
      err "$f: the Revised text says 'No rewrite requested.' but the triage declares a direct rewrite."
    else
      feedback_only=1
    fi
  fi

  # The stage gates several checks below (computed here, validated once).
  stage="$(grep -m1 -E '^revision_stage:' "$f" | sed -E 's/^revision_stage:[[:space:]]*//')"

  # 2. Word-count line, and it must OPEN the rationale (SKILL.md: "Open
  #    with `Word count: ...`"), not sit buried after prose.
  if [ "$feedback_only" -eq 0 ]; then
    first_rationale="$(rationale_of "$f" | sed '/^[[:space:]]*$/d' | head -1)"
    if ! printf '%s\n' "$first_rationale" | grep -qE "$WC_RE"; then
      err "$f: 'Change rationale' must open with a 'Word count: ~<before> to ~<after> (<signed percent>).' line (got: ${first_rationale:-nothing})."
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
  if printf '%s\n' "$questions" | grep -qE '^None\.' && printf '%s\n' "$questions" | grep -qE '^- '; then
    err "$f: 'Author questions' mixes 'None.' with question bullets; it must be one or the other."
  fi
  stray="$(printf '%s\n' "$questions" | grep -vE '^(- |[[:space:]]+[^[:space:]]|None\.$|[[:space:]]*$)' | head -1 || true)"
  if [ -n "$stray" ]; then
    err "$f: 'Author questions' carries non-bullet prose: $stray"
  fi

  # 4. Banned tells inside the 'Revised text' fenced block, scanned per
  #    paragraph. Only at 'response to reviewers' is a paragraph returned
  #    verbatim from the input exempt (the stage forbids editing unflagged
  #    paragraphs, tells and all); at every other stage the restraint
  #    rules say a passage only comes back verbatim when it is clean, so
  #    verbatim paragraphs are scanned too. Paragraphs are flattened first
  #    because the prose is hard-wrapped.
  block="$(revised_block_of "$f")"
  if [ -z "$block" ] && [ "$feedback_only" -eq 0 ]; then
    err "$f: no fenced block found under 'Revised text'."
  fi
  # A feedback-only run keeps the block structure: the fenced block exists
  # and reads 'No rewrite requested.'.
  if [ "$feedback_only" -eq 1 ]; then
    if [ -z "$block" ] || ! printf '%s\n' "$block" | grep -qF 'No rewrite requested.'; then
      err "$f: a feedback-only example must keep the fenced Revised text block reading 'No rewrite requested.'"
    fi
  fi
  input_paras="$(input_block_of "$f" | strip_labels | flat_paras)"
  ldq="$(printf '\xe2\x80\x9c')"
  rdq="$(printf '\xe2\x80\x9d')"
  while IFS= read -r para; do
    [ -n "$para" ] || continue
    if [ "$stage" = "response to reviewers" ] && printf '%s\n' "$input_paras" | grep -qxF -- "$para"; then continue; fi
    # Direct quotes stay verbatim under constraint 7, tells and all, so
    # quoted spans are excised before the scan.
    para="$(printf '%s\n' "$para" | sed -E "s/\"[^\"]*\"//g; s/${ldq}[^${ldq}${rdq}]*${rdq}//g")"
    for w in "${TELL_WORDS[@]}"; do
      if printf '%s\n' "$para" | grep -qiwE "$w"; then
        err "$f: banned tell '$w' in the Revised text block (only response-to-reviewers verbatim returns are exempt)."
      fi
    done
    for p in "${TELL_PHRASES[@]}"; do
      if printf '%s\n' "$para" | grep -qiF "$p"; then
        err "$f: banned tell '$p' in the Revised text block (only response-to-reviewers verbatim returns are exempt)."
      fi
    done
  done < <(printf '%s\n' "$block" | strip_labels | flat_paras)

  # 6. 'Added bridges:' immediately after the block; no editor labels
  #    inside; exactly one fenced block in the section (a second block
  #    would carry revised text the other checks never see).
  if [ -n "$block" ]; then
    fence_count="$(printf '%s\n' "$revised_section" | grep -c '^```' || true)"
    if [ "$fence_count" -ne 2 ]; then
      err "$f: the Revised text section must contain exactly one fenced block (found $((fence_count / 2)))."
    fi
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
        # Every quoted BRIDGE must appear in the rewrite, or the line
        # points the author at a nonexistent sentence. Bridges are full
        # sentences, so a quoted span ending in sentence punctuation is a
        # bridge; a span without it quotes the draft's wording as
        # commentary and is exempt.
        block_flat="$(printf '%s\n' "$block" | flat_paras | tr '\n' ' ')"
        while IFS= read -r span; do
          quote="${span#\"}"; quote="${quote%\"}"
          case "$quote" in
            *. | *\? | *!)
              if ! printf '%s\n' "$block_flat" | grep -qF -- "$quote"; then
                err "$f: an Added bridges quote does not appear in the Revised text block: \"$(printf '%s' "$quote" | head -c 60)...\""
              fi
              ;;
          esac
        done < <(printf '%s\n' "$ab_para" | grep -oE '"[^"]*"' || true)
        # The bridge contract pairs every quoted bridge with an Author
        # questions item confirming it; matching bridge to question is
        # semantic, but a quoted bridge with NO questions at all is a
        # mechanical violation.
        if ! printf '%s\n' "$questions" | grep -q '^- '; then
          err "$f: Added bridges quotes a bridge but Author questions has no item to confirm it."
        fi
        ;;
      *) err "$f: the Revised text block must be followed by 'Added bridges:' quoting each added bridge or 'None.' (got: ${ab_para:-nothing})." ;;
    esac
    # Editor labels sit at the start of a paragraph, which is where the
    # skill adds them; a [P1]-style token inside running manuscript text
    # (a proposition or participant reference) is the author's content
    # and is allowed.
    if printf '%s\n' "$block" | awk 'BEGIN{RS=""} /^\[[PR][0-9]/{found=1} END{exit found ? 0 : 1}'; then
      err "$f: editor label opening a paragraph of the Revised text block (no commentary in the block)."
    fi
  fi

  # 5. Diagnosis headers by stage (the SKILL.md Diagnosis table), plus
  #    extraction-line consistency (first draft + named teaching gap). The
  #    gap scan runs on a flattened copy so hard-wrapped phrases still match.
  case "$stage" in
    "first draft"|"final polish"|"response to reviewers") : ;;
    *) err "$f: revision_stage is missing or not a legal stage (got: ${stage:-nothing}); the stage-specific Diagnosis checks cannot run." ;;
  esac
  diagnosis="$(diagnosis_of "$f")"
  # Every Diagnosis ends in a numbered list of concrete problems; header
  # and extraction lines alone do not satisfy the contract, and every item
  # opens with a bracketed paragraph or reviewer reference.
  if ! printf '%s\n' "$diagnosis" | grep -qE '^1\. '; then
    err "$f: the Diagnosis has no numbered item list."
  fi
  unanchored="$(printf '%s\n' "$diagnosis" | grep -E '^[0-9]+\. ' | grep -vE '^[0-9]+\. \[[PR][0-9]' | head -1 || true)"
  if [ -n "$unanchored" ]; then
    err "$f: Diagnosis item does not open with a [P#] or [R#] reference: $unanchored"
  fi
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
    # A clarity request triggers the lines too (SKILL.md Diagnosis table),
    # whatever the Diagnosis prose happens to say.
    request_flat="$(request_of "$f" | tr '\n' ' ' | tr -s '[:space:]' ' ')"
    if printf '%s\n' "$request_flat" | grep -qiE 'clear|clarity|readab|educational|easier to understand|non-specialist'; then
      gap_found=1
    fi
    if [ "$gap_found" -eq 1 ]; then
      # Labeled per-paragraph forms ('Buried lede [P3]:') satisfy the
      # requirement; the contract says to repeat the set with labels when
      # several paragraphs carry distinct gaps. The lines open the block
      # with the headers, so each must precede the numbered list.
      item_line="$(printf '%s\n' "$diagnosis" | grep -nE '^1\. ' | head -1 | cut -d: -f1)"
      for line in 'Jargon to unpack' 'Buried lede' 'Concrete anchor'; do
        ex_line="$(printf '%s\n' "$diagnosis" | grep -nE "^$line( \[P[0-9]+\])?:" | head -1 | cut -d: -f1)"
        if [ -z "$ex_line" ]; then
          err "$f: Diagnosis names a teaching gap (or the request asks for clarity) at first draft but lacks the '$line' extraction line."
        elif [ -n "$item_line" ] && [ "$ex_line" -gt "$item_line" ]; then
          err "$f: the '$line' extraction line must precede the numbered Diagnosis list."
        fi
      done
    fi
  elif [ "$stage" = "final polish" ] || [ "$stage" = "response to reviewers" ]; then
    for line in 'Voice tics' 'Reader map' 'Jargon to unpack' 'Buried lede' 'Concrete anchor'; do
      if printf '%s\n' "$diagnosis" | grep -qE "^$line( \[P[0-9]+\])?:"; then
        err "$f: a '$stage' Diagnosis must not carry a '$line' line."
      fi
    done
  fi

  # 7. Reader map template, scoped to the Diagnosis block so a
  #    'Reader map:' line in the manuscript input or the commentary
  #    around the output cannot trip the check.
  if printf '%s\n' "$diagnosis" | grep -q '^Reader map:'; then
    reader_map="$(printf '%s\n' "$diagnosis" | awk '/^Reader map:/{f=1} f && /^[[:space:]]*$/{exit} f{printf "%s ", $0}')"
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
