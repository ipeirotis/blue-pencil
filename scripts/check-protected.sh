#!/usr/bin/env bash
# Deterministic protected-content check over the examples (review item A-D6).
# The skill's preflight ("No protected content changed") is self-attestation
# by the model, the known-weak link; this script is the mechanical version,
# run in CI so the quality anchors are verified on every change.
#
# For every examples/*.md that carries a '## Skill output' section, extract
# the input block (the last fenced block before '## Skill output') and the
# revised block (the first fenced block after '### 2. Revised text'), then
# diff the multisets of:
#   - citation keys        \cite variants including optional arguments
#                          (\citep[see][p. 4]{smith2020}), and every pandoc
#                          @key, bare or bracketed ([see @smith2020],
#                          [-@smith2020])
#   - author-year runs     plain-prose citations ("Forman et al. 2008",
#                          "Smith (2020)", "(Smith, 2020)"), matched as
#                          capitalized-word runs ending in a year so an
#                          author swap is caught, not just a year swap
#   - cross-reference keys \ref/\eqref/\autoref/\cref/\Cref/\label{...}
#   - prose callouts       "Table 4", "Appendix C", "column 3", ... matched
#                          case-insensitively so a callout-type swap is
#                          caught, not just a number swap
#   - math spans           $...$ and $$...$$ (kept distinct, so dropping a
#                          display delimiter is caught), \(...\), \[...\],
#                          and whole \begin{...}...\end{...} spans
#                          including their contents, so a formula edit
#                          cannot hide in a non-dollar span or inside an
#                          environment; \caption{...} arguments are blanked
#                          before the environment diff because caption text
#                          is editable prose under constraint 5 (its
#                          numbers, citations, and quotes stay covered by
#                          the other classes)
#   - macros               every remaining \command with its arguments,
#                          including one-character commands (\&, \%, \,),
#                          so a custom-macro argument swap (\methodName{...})
#                          or a dropped markup command is caught; macros
#                          whose argument is editable prose under the
#                          constraints (\caption, \emph, \textbf, \textit,
#                          \footnote, sectioning) are diffed by name only,
#                          honoring the caption carve-out in constraint 5
#   - quoted text          "...", TeX ``...'', and curly double-quote
#                          spans, since constraint 7 keeps direct quotes
#                          verbatim
#   - comment lines        lines starting with %, protected markup under
#                          constraint 5 (extracted before flattening)
#   - numbers              every digit token with its sign, thousands
#                          separators, range ("5-9%"), percent, and any
#                          adjacent unit word from a fixed lexicon
#                          ("6 points", "1.2 million"), so a sign flip, a
#                          range rewrite, or a points-to-percent unit swap
#                          is caught, not just a digit change (an arbitrary
#                          noun after a number stays prose: binding it
#                          would flag legitimate edits near numbers)
# [P1]-style paragraph labels are stripped first: they are editor
# bookkeeping, not manuscript content. Blocks are flattened to one line
# before extraction because example prose is hard-wrapped and a token can
# straddle a line break ("Chevalier and Mayzlin\n2006").
#
# Exceptions: a legitimate, flagged change may alter a protected token. List
# it in ALLOW below as '<file> <token>' and that token is ignored on both
# sides for that file; everything else must match exactly. Empty by design
# today: no example performs a protected-content change.
# Used by CI and `make test`.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

ALLOW="
"

fail=0

input_block_of() {
  awk '
    /^## Skill output/ { exit }
    /^```/ { inb = !inb; if (inb) { buf = "" } else { last = buf }; next }
    inb { buf = buf $0 "\n" }
    END { printf "%s", last }
  ' "$1"
}

revised_block_of() {
  awk '
    /^### 2\. Revised text$/ { f = 1 }
    f && /^```/ { inb = !inb; if (!inb) exit; next }
    f && inb { print }
  ' "$1"
}

strip_labels() {
  sed -E 's/\[[PR][0-9]+(\.[0-9]+)?\]//g'
}

# Print one token per line for the requested class; grep exits 1 on zero
# matches, which is a valid empty result, hence the '|| true'.
tokens_of() {
  class="$1"
  # Capture stdin once: a branch may run several extractors, and the first
  # would otherwise consume the stream the second needs.
  text="$(cat)"
  # shellcheck disable=SC2016  # the quote patterns are regex, not expansions
  case "$class" in
    citations)  printf '%s\n' "$text" | grep -oE '\\[Cc]ite[a-zA-Z]*\*?(\[[^]]*\])*\{[^}]*\}|@[A-Za-z0-9_:-]+' || true ;;
    authoryear) printf '%s\n' "$text" | grep -oE "([A-Z][A-Za-z'.&-]+|and|et|al\.?)( ([A-Z][A-Za-z'.&-]+|and|et|al\.?))*,? \(?[12][0-9]{3}\)?" || true ;;
    crossrefs)  printf '%s\n' "$text" | grep -oE '\\(ref|eqref|autoref|cref|Cref|label)\{[^}]*\}' || true ;;
    callouts)   printf '%s\n' "$text" | grep -oiE '(table|figure|fig\.|section|appendix|column|panel|equation|eq\.) ([0-9]+(\.[0-9]+)?[a-z]?|[a-z])\b' | tr '[:upper:]' '[:lower:]' || true ;;
    math)
      printf '%s\n' "$text" | grep -oE '\$\$[^$]+\$\$|\$[^$]+\$' || true
      # \(...\) and \[...\] spans by delimiter search, so ordinary ) or ]
      # inside a formula (f(x), \mathbb{E}[Y]) does not truncate the span.
      printf '%s\n' "$text" | awk '{
        s = $0
        while ((i = index(s, "\\(")) > 0) {
          s = substr(s, i)
          j = index(s, "\\)")
          if (j > 0) { print substr(s, 1, j + 1); s = substr(s, j + 2) } else { print s; break }
        }
      }'
      printf '%s\n' "$text" | awk '{
        s = $0
        while ((i = index(s, "\\[")) > 0) {
          s = substr(s, i)
          j = index(s, "\\]")
          if (j > 0) { print substr(s, 1, j + 1); s = substr(s, j + 2) } else { print s; break }
        }
      }'
      # Whole environment spans, contents included: split at each \begin{
      # and take through the first following \end{...}. Nested or unpaired
      # environments split coarsely but deterministically on both sides.
      # Caption arguments are blanked first: caption text is editable prose
      # (constraint 5 carve-out), so only the rest of the environment is
      # frozen.
      printf '%s\n' "$text" | sed -E 's/\\caption\{[^}]*\}/\\caption{}/g' | awk '{
        s = $0
        while ((i = index(s, "\\begin{")) > 0) {
          s = substr(s, i)
          if (match(s, /\\end\{[^}]*\}/)) {
            print substr(s, 1, RSTART + RLENGTH - 1)
            s = substr(s, RSTART + RLENGTH)
          } else { print s; break }
        }
      }'
      ;;
    macros)
      # Every \command with its bracket and brace arguments; commands whose
      # argument is editable prose under the constraints keep only their
      # name (the caption carve-out: caption text is prose, the macro
      # itself must survive).
      printf '%s\n' "$text" | grep -oE '\\[A-Za-z]+\*?(\[[^]]*\])*(\{[^}]*\})*|\\[^A-Za-z0-9[:space:]]' \
        | sed -E 's/^\\(caption|emph|textbf|textit|footnote|section|subsection|subsubsection|paragraph)(\*?)(\[[^]]*\]|\{[^}]*\})*$/\\\1\2/' || true
      ;;
    quotes)
      printf '%s\n' "$text" | grep -oE '"[^"]+"|``[^`]+'\'\''' || true
      # Curly double quotes, built from bytes so this script stays ASCII.
      ldq="$(printf '\xe2\x80\x9c')"
      rdq="$(printf '\xe2\x80\x9d')"
      printf '%s\n' "$text" | grep -oE "${ldq}[^${ldq}${rdq}]*${rdq}" || true
      ;;
    comments)   printf '%s\n' "$text" | grep -E '^[[:space:]]*%' || true ;;
    numbers)    printf '%s\n' "$text" | grep -oE '[+-]?[0-9]+(,[0-9]{3})*(\.[0-9]+)?(-[0-9]+(,[0-9]{3})*(\.[0-9]+)?)?%?( (percentage points?|percentage|percent|points?|pp|bps|million|billion|thousand|fold))?' || true ;;
  esac
}

allowed_for() {
  printf '%s\n' "$ALLOW" | awk -v f="$1" '$1 == f { $1 = ""; sub(/^ /, ""); print }'
}

checked=0
while IFS= read -r f; do
  grep -q '^## Skill output' "$f" || continue
  checked=$((checked + 1))

  input_raw="$(input_block_of "$f" | strip_labels)"
  output_raw="$(revised_block_of "$f" | strip_labels)"
  input="$(printf '%s\n' "$input_raw" | tr '\n' ' ' | tr -s '[:space:]' ' ')"
  output="$(printf '%s\n' "$output_raw" | tr '\n' ' ' | tr -s '[:space:]' ' ')"
  if [ -z "$input" ] || [ -z "$output" ]; then
    # Feedback-only examples return no rewrite; nothing to diff.
    if ! grep -qF 'No rewrite requested.' "$f"; then
      echo "ERROR: $f: could not extract an input and a revised block." >&2
      fail=1
    fi
    continue
  fi

  allow="$(allowed_for "$f")"

  for class in citations authoryear crossrefs callouts math macros quotes comments numbers; do
    # Comment lines are a line-level construct, so they diff on the raw
    # (unflattened) blocks; every other class reads the flattened text.
    src_in="$input"; src_out="$output"
    if [ "$class" = "comments" ]; then src_in="$input_raw"; src_out="$output_raw"; fi
    in_tokens="$(printf '%s\n' "$src_in" | tokens_of "$class" | sort)"
    out_tokens="$(printf '%s\n' "$src_out" | tokens_of "$class" | sort)"
    if [ -n "$allow" ]; then
      in_tokens="$(printf '%s\n' "$in_tokens" | grep -vxF -f <(printf '%s\n' "$allow") || true)"
      out_tokens="$(printf '%s\n' "$out_tokens" | grep -vxF -f <(printf '%s\n' "$allow") || true)"
    fi
    if [ "$in_tokens" != "$out_tokens" ]; then
      echo "ERROR: $f: protected content changed ($class):" >&2
      diff <(printf '%s\n' "$in_tokens") <(printf '%s\n' "$out_tokens") | sed 's/^/  /' >&2 || true
      fail=1
    fi
  done
done < <(git ls-files 'examples/*.md')

if [ "$checked" -eq 0 ]; then
  echo "ERROR: no example files with a '## Skill output' section were found." >&2
  fail=1
fi

if [ "$fail" -ne 0 ]; then
  echo "Protected-content check failed." >&2
  exit 1
fi
echo "Protected content OK ($checked examples)."
