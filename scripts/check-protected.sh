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
#                          and Markdown link references [text](target),
#                          so a retargeted link with unchanged visible
#                          text is caught
#   - prose callouts       "Table 4", "Appendix C", "column 3", ... matched
#                          case-insensitively so a callout-type swap is
#                          caught, not just a number swap
#   - math spans           $...$ and $$...$$ (kept distinct, so dropping a
#                          display delimiter is caught), \(...\) and
#                          \[...\], so a formula edit cannot hide in a
#                          non-dollar span
#   - environments         whole \begin{...}...\end{...} spans including
#                          their contents, diffed with line-break markers
#                          because SKILL.md says to preserve line breaks
#                          inside formatting-sensitive environments
#                          (tabular, lstlisting); \caption arguments,
#                          including optional-argument and nested-brace
#                          forms, are blanked first because caption text is
#                          editable prose under constraint 5 (its numbers,
#                          citations, and quotes stay covered by the other
#                          classes)
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
#   - code                 ~~~ fence lines and inline `...` code spans,
#                          protected markup under constraint 5 (extracted
#                          before flattening; an inline span hard-wrapped
#                          across lines is not seen, a known limit)
#   - numbers              every digit token with its sign, thousands
#                          separators, range ("5-9%"), percent, and any
#                          adjacent unit word from a fixed lexicon
#                          ("6 points", "1.2 million"), so a sign flip, a
#                          range rewrite, or a points-to-percent unit swap
#                          is caught, not just a digit change (an arbitrary
#                          noun after a number stays prose: binding it
#                          would flag legitimate edits near numbers)
#   - number words         spelled-out cardinals with any hyphenated
#                          compound ("two-stage", "three groups"), so a
#                          worded quantity or method-arity change is
#                          caught; a legitimate rephrasing that drops a
#                          cardinal goes through the exceptions list
# [P1]-style paragraph labels are stripped first: they are editor
# bookkeeping, not manuscript content. Blocks are flattened to one line
# before extraction because example prose is hard-wrapped and a token can
# straddle a line break ("Chevalier and Mayzlin\n2006").
#
# Scope, stated once: this is a TRIPWIRE over a small, hand-maintained
# example set, not a LaTeX or pandoc parser. It exists to make the most
# likely silent mutations of protected content fail loudly in CI; the
# human review of the example diff remains the real guarantee, and every
# example change is reviewed. Known limits, by design:
# - Each class is compared as a MULTISET, so the check cannot see which
#   claim a preserved value is attached to (swapping two coefficients
#   between sentences passes). Binding tokens to their surrounding prose
#   would flag every legitimate edit near a protected token.
# - Straight single quotes are not a quote class (apostrophes make them
#   undecidable by grep).
# - Constructs outside the token grammars above (exotic markup, prose
#   paraphrases of quantities beyond the cardinal lexicon) are the
#   reviewer's job, not this script's; extend a class when a real
#   example starts using the construct rather than speculatively.
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
  # The scenario's <paper_context> block also sits before '## Skill
  # output'; it is never the manuscript input, so a file whose only
  # pre-output block is the context block has no input and fails the
  # emptiness guard instead of silently diffing metadata.
  awk '
    /^## Skill output/ { exit }
    /^```/ { inb = !inb; if (inb) { buf = "" } else { if (buf !~ /revision_stage:/) last = buf }; next }
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

# Editor labels sit at the start of a paragraph's first line, which is
# where the skill adds them; a [P1]-style marker in the middle of running
# manuscript text is the author's content and stays protected.
strip_labels() {
  sed -E 's/^\[[PR][0-9]+(\.[0-9]+)?\] ?//'
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
    citations)  printf '%s\n' "$text" | grep -oE '\\[Cc]ite[a-zA-Z]*\*? ?(\[[^]]*\] ?)*\{[^}]*\}|-?@[A-Za-z0-9_][A-Za-z0-9_:-]*(\.[A-Za-z0-9_:-]+)*' || true ;;
    authoryear) printf '%s\n' "$text" | grep -oE "([A-Z][A-Za-z'.&-]+|van|von|der|de|del|da|di|la|le|ter|ten|dos|and|et|al\.?|&)(,? ([A-Z][A-Za-z'.&-]+|van|von|der|de|del|da|di|la|le|ter|ten|dos|and|et|al\.?|&))*,? \(?[12][0-9]{3}\)?" || true ;;
    # Markdown links protect the DESTINATION only: link text is editable
    # prose (its callouts and numbers are covered by the other classes),
    # while a retargeted link with unchanged text still fails.
    crossrefs)  printf '%s\n' "$text" | grep -oE '\\(ref|eqref|autoref|cref|Cref|label) ?\{[^}]*\}|\]\([^)]*\)' || true ;;
    callouts)   printf '%s\n' "$text" | grep -oiE '(table|figure|fig\.|section|appendix|appendices|column|panel|equation|eq\.)s?[ ~]\(?([0-9]+(\.[0-9]+)?[a-z]?|[a-z][0-9]*)\b(,?[ ~](and[ ~]|to[ ~])?([0-9]+(\.[0-9]+)?[a-z]?|[a-z][0-9]*)\b)*' | tr '[:upper:]' '[:lower:]' || true ;;
    math)
      # A dollar span starting with "$<amount> " is prose currency, not
      # math ("$5 million and $3 million" would otherwise fuse into one
      # false span and freeze the prose between the amounts); the amounts
      # themselves stay protected by the numbers class.
      printf '%s\n' "$text" | grep -oE '\$\$[^$]+\$\$|\$[^$]+\$' | grep -vE '^\$[0-9][0-9,.]* ' || true
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
      ;;
    environments)
      # Whole environment spans, contents included, closed at the \end
      # whose name matches the \begin so a nested inner environment (a
      # tabular inside a table) does not truncate the outer span. Nested
      # same-name environments still close at the first matching end tag,
      # deterministically on both sides. Caption constructs, including
      # \caption*[Short]{Long {nested}} forms, are blanked to \caption{}
      # first: caption text is editable prose (constraint 5 carve-out), so
      # only the rest of the environment is frozen.
      printf '%s\n' "$text" | awk '{
        s = $0; out = ""
        while ((i = index(s, "\\caption")) > 0) {
          out = out substr(s, 1, i - 1) "\\caption{}"
          rest = substr(s, i + 8)
          if (substr(rest, 1, 1) == "*") rest = substr(rest, 2)
          while (substr(rest, 1, 1) == " ") rest = substr(rest, 2)
          if (substr(rest, 1, 1) == "[") { p = index(rest, "]"); if (p > 0) rest = substr(rest, p + 1) }
          while (substr(rest, 1, 1) == " ") rest = substr(rest, 2)
          if (substr(rest, 1, 1) == "{") {
            depth = 0; p = 0
            for (k = 1; k <= length(rest); k++) {
              ch = substr(rest, k, 1)
              if (ch == "{") depth++
              else if (ch == "}") { depth--; if (depth == 0) { p = k; break } }
            }
            if (p > 0) rest = substr(rest, p + 1)
          }
          s = rest
        }
        print out s
      }' | awk '{
        s = $0
        while ((i = index(s, "\\begin{")) > 0) {
          s = substr(s, i)
          if (match(s, /^\\begin\{[^}]*\}/)) {
            name = substr(s, 8, RLENGTH - 8)
            endtag = "\\end{" name "}"
            j = index(substr(s, RLENGTH + 1), endtag)
            if (j > 0) {
              tot = RLENGTH + j - 1 + length(endtag)
              print substr(s, 1, tot)
              s = substr(s, tot + 1)
            } else { print s; break }
          } else { print s; break }
        }
      }'
      ;;
    macros)
      # Every \command with its bracket and brace arguments, brace-counted
      # so a nested group ({baseline {nested} tail}) is captured whole.
      # Commands whose argument is editable prose under the constraints
      # emit only their name and scanning continues INSIDE the argument,
      # so a protected macro nested in a caption, footnote, or emphasis
      # span still gets its own token (the caption carve-out frees the
      # prose, never the markup inside it).
      printf '%s\n' "$text" | awk '
        BEGIN {
          split("caption emph textbf textit footnote section subsection subsubsection paragraph", a, " ")
          for (i in a) prose[a[i]] = 1
        }
        {
          s = $0
          while (match(s, /\\[A-Za-z]+\*?/)) {
            tok = substr(s, RSTART, RLENGTH)
            rest = substr(s, RSTART + RLENGTH)
            name = tok; sub(/^\\/, "", name); sub(/\*$/, "", name)
            if (name in prose) { print tok; s = rest; continue }
            while (1) {
              c = substr(rest, 1, 1)
              # LaTeX allows whitespace between a command and its argument.
              if (c == " ") {
                peek = substr(rest, 2, 1)
                if (peek == "[" || peek == "{") { rest = substr(rest, 2); continue }
              }
              if (c == "[") {
                p = index(rest, "]")
                if (p == 0) break
                tok = tok substr(rest, 1, p); rest = substr(rest, p + 1)
              } else if (c == "{") {
                depth = 0; p = 0
                for (k = 1; k <= length(rest); k++) {
                  ch = substr(rest, k, 1)
                  if (ch == "{") depth++
                  else if (ch == "}") { depth--; if (depth == 0) { p = k; break } }
                }
                if (p == 0) break
                tok = tok substr(rest, 1, p); rest = substr(rest, p + 1)
              } else break
            }
            print tok
            s = rest
          }
        }'
      printf '%s\n' "$text" | grep -oE '\\[^A-Za-z0-9[:space:]]' || true
      ;;
    quotes)
      printf '%s\n' "$text" | grep -oE '"[^"]+"|``[^`]+'\'\''' || true
      # Curly double and single quotes, built from bytes so this script
      # stays ASCII. Straight single quotes are deliberately NOT a quote
      # class: an apostrophe (Sant'Anna, the draft's) is the same byte,
      # so straight-single spans are undecidable by grep; a manuscript
      # using them relies on the human diff review.
      ldq="$(printf '\xe2\x80\x9c')"
      rdq="$(printf '\xe2\x80\x9d')"
      lsq="$(printf '\xe2\x80\x98')"
      rsq="$(printf '\xe2\x80\x99')"
      printf '%s\n' "$text" | grep -oE "${ldq}[^${ldq}${rdq}]*${rdq}" || true
      printf '%s\n' "$text" | grep -oE "${lsq}[^${lsq}${rsq}]*${rsq}" || true
      ;;
    comments)   printf '%s\n' "$text" | grep -E '^[[:space:]]*%' || true ;;
    code)
      # ~~~ fence delimiter lines and every line inside the fence.
      printf '%s\n' "$text" | awk '/^~~~/{inb=!inb; print; next} inb{print}'
      printf '%s\n' "$text" | grep -oE '`[^`]+`' || true
      ;;
    numbers)    printf '%s\n' "$text" | grep -oE '([<>]=?[ ~]?)?[+-]?([0-9]+(,[0-9]{3})*(\.[0-9]+)?|\.[0-9]+)(-([0-9]+(,[0-9]{3})*(\.[0-9]+)?|\.[0-9]+))?%?(( |-)(percentage points?|percentage|percent|points?|pp|bps|million|billion|thousand|fold|star|stars))?' || true ;;
    # Ordinals join only as hyphenated compounds (first-stage): standalone
    # ordinals are prose structure the real examples legitimately add
    # ("a second lever" appears in a rewrite whose input lacks it).
    numberwords) printf '%s\n' "$text" | grep -oiwE '(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|seventy|eighty|ninety|hundred|thousand|million|billion|twice|half|dozen)(-[a-z]+)?|(first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth)-[a-z]+' | tr '[:upper:]' '[:lower:]' || true ;;
  esac
}

allowed_for() {
  printf '%s\n' "$ALLOW" | awk -v f="$1" '$1 == f { $1 = ""; sub(/^ /, ""); print }'
}

checked=0
while IFS= read -r f; do
  # Every tracked example is a complete run; a missing section must fail,
  # not silently exempt the file from the protected-content diff.
  if ! grep -q '^## Skill output' "$f"; then
    echo "ERROR: $f: missing the '## Skill output' section." >&2
    fail=1
    continue
  fi
  checked=$((checked + 1))

  input_raw="$(input_block_of "$f" | strip_labels)"
  output_raw="$(revised_block_of "$f" | strip_labels)"
  # Emptiness is tested on the raw blocks: the flattened copies below are
  # never empty (an empty block flattens to a single space).
  if [ -z "$input_raw" ] || [ -z "$output_raw" ]; then
    # Feedback-only examples return no rewrite; nothing to diff. A file
    # whose triage declares a direct rewrite cannot claim that exemption
    # by carrying the phrase, so a deleted rewrite still fails.
    if ! grep -qF 'No rewrite requested.' "$f" || grep -qiF "direct rewrite" "$f"; then
      echo "ERROR: $f: could not extract an input and a revised block." >&2
      fail=1
    fi
    continue
  fi

  input="$(printf '%s\n' "$input_raw" | tr '\n' ' ' | tr -s '[:space:]' ' ')"
  output="$(printf '%s\n' "$output_raw" | tr '\n' ' ' | tr -s '[:space:]' ' ')"
  # One line with visible line-break markers, for classes where SKILL.md
  # says source formatting matters (line breaks inside tabular/lstlisting
  # environments): a re-wrapped environment body must change its token.
  input_marked="$(printf '%s\n' "$input_raw" | awk '{printf "%s\\n", $0}')"
  output_marked="$(printf '%s\n' "$output_raw" | awk '{printf "%s\\n", $0}')"

  allow="$(allowed_for "$f")"

  for class in citations authoryear crossrefs callouts math environments macros quotes comments code numbers numberwords; do
    # Comment lines and code fences are line-level constructs, so they
    # diff on the raw (unflattened) blocks; environments keep line-break
    # markers because their source formatting is protected; every other
    # class reads the flattened text.
    src_in="$input"; src_out="$output"
    case "$class" in
      comments|code)     src_in="$input_raw"; src_out="$output_raw" ;;
      # Math content is opaque and markup-preserved, so line breaks inside
      # a span are part of the token, same as environments.
      environments|math) src_in="$input_marked"; src_out="$output_marked" ;;
    esac
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
