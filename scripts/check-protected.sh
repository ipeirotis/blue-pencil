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
#   - citation keys        \cite*{...} and pandoc [@...]
#   - cross-reference keys \ref/\eqref/\autoref/\cref/\Cref/\label{...}
#   - math spans           $...$
#   - numbers              every digit token, including decimals
# [P1]-style paragraph labels are stripped first: they are editor
# bookkeeping, not manuscript content.
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
  case "$class" in
    citations) grep -oE '\\cite[a-zA-Z]*\*?\{[^}]*\}|\[@[^]]+\]' || true ;;
    crossrefs) grep -oE '\\(ref|eqref|autoref|cref|Cref|label)\{[^}]*\}' || true ;;
    math)      grep -oE '\$[^$]+\$' || true ;;
    numbers)   grep -oE '[0-9]+(\.[0-9]+)?' || true ;;
  esac
}

allowed_for() {
  printf '%s\n' "$ALLOW" | awk -v f="$1" '$1 == f { $1 = ""; sub(/^ /, ""); print }'
}

checked=0
while IFS= read -r f; do
  grep -q '^## Skill output' "$f" || continue
  checked=$((checked + 1))

  input="$(input_block_of "$f" | strip_labels)"
  output="$(revised_block_of "$f" | strip_labels)"
  if [ -z "$input" ] || [ -z "$output" ]; then
    # Feedback-only examples return no rewrite; nothing to diff.
    if ! grep -qF 'No rewrite requested.' "$f"; then
      echo "ERROR: $f: could not extract an input and a revised block." >&2
      fail=1
    fi
    continue
  fi

  allow="$(allowed_for "$f")"

  for class in citations crossrefs math numbers; do
    in_tokens="$(printf '%s\n' "$input" | tokens_of "$class" | sort)"
    out_tokens="$(printf '%s\n' "$output" | tokens_of "$class" | sort)"
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
