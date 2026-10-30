#!/usr/bin/env bash
# 템플릿을 작업 폴더로 복사한다. 이미 있는 파일은 덮어쓰지 않는다.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-.}"

copy_if_absent() {
  local src="$1" dst="$2"
  if [ -e "$dst" ]; then
    echo "skip (exists): $dst"
  else
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "created: $dst"
  fi
}

copy_if_absent "$KIT_DIR/AGENTS.template.md" "$TARGET/AGENTS.md"
for f in interview agreement decisions verification handoff; do
  copy_if_absent "$KIT_DIR/docs/templates/$f.md" "$TARGET/docs/$f.md"
done

echo
echo "참고: $KIT_DIR/prompts/delegation.md , $KIT_DIR/checklists/submit.md"
echo "과제 안내에 지정된 파일명·양식이 있으면 그쪽을 우선하세요."
