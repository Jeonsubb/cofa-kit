#!/usr/bin/env bash
# 키트의 스킬을 사용자 스킬 폴더($HOME/.agents/skills)에 설치한다.
# 작업 폴더(제출물)를 어지럽히지 않도록 저장소가 아닌 사용자 범위에 둔다.
# --with-community 옵션을 주면 공개 저장소 mattpocock/skills(MIT)의 tdd, diagnosing-bugs도 함께 설치한다.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DEST="${AGENT_SKILLS_DIR:-$HOME/.agents/skills}"
# 홈 아래 설정 폴더가 읽기 전용인 환경이면 작업 폴더의 .agents/skills로 대체한다.
if ! mkdir -p "$DEST" 2>/dev/null || ! touch "$DEST/.write-test" 2>/dev/null; then
  echo "warn: $DEST 에 쓸 수 없어 ./.agents/skills 에 설치합니다."
  DEST="$(pwd)/.agents/skills"
  mkdir -p "$DEST"
fi
rm -f "$DEST/.write-test"

install_dir() {
  local src="$1" name
  name="$(basename "$src")"
  if [ -e "$DEST/$name" ]; then
    echo "skip (exists): $DEST/$name"
  else
    cp -R "$src" "$DEST/$name"
    echo "installed: $DEST/$name"
  fi
}

for s in "$KIT_DIR"/skills/*/; do
  install_dir "${s%/}"
done

if [ "${1:-}" = "--with-community" ]; then
  TMP="$(mktemp -d)"
  if git clone -q --depth 1 https://github.com/mattpocock/skills "$TMP/mp"; then
    for s in engineering/tdd engineering/diagnosing-bugs; do
      [ -d "$TMP/mp/skills/$s" ] && install_dir "$TMP/mp/skills/$s"
    done
    cp "$TMP/mp/LICENSE" "$DEST/LICENSE.mattpocock-skills" 2>/dev/null || true
  else
    echo "warn: community skills clone failed; kit skills are still installed."
  fi
fi

echo
echo "Codex를 재시작한 뒤 /skills 로 목록을 확인하세요."
