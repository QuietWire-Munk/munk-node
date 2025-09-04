#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SAMPLE="$ROOT/TEAM_REPOS.sample"
TARGET="$ROOT/pull_teams.sh"

if [ ! -f "$SAMPLE" ]; then
  echo "Sample file $SAMPLE not found"
  exit 1
fi
if [ ! -f "$TARGET" ]; then
  echo "Target script $TARGET not found"
  exit 1
fi

urls=()
while IFS= read -r line; do
  [[ "$line" =~ ^# ]] && continue
  [[ -z "$line" ]] && continue
  urls+=("\"$line\"")
done < "$SAMPLE"

if [ ${#urls[@]} -eq 0 ]; then
  echo "No URLs found in $SAMPLE"
  exit 1
fi

echo "Injecting ${#urls[@]} team repos into $TARGET"

# replace the TEAM_REPOS block
awk -v urls="${urls[*]}" '
  BEGIN { split(urls, arr, " "); }
  /^TEAM_REPOS=/ {
    print "TEAM_REPOS=("
    for (i in arr) print "  " arr[i]
    print ")"
    next
  }
  { print }
' "$TARGET" > "$TARGET.tmp"

mv "$TARGET.tmp" "$TARGET"
chmod +x "$TARGET"
