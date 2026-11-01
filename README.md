# cofa-kit

AI 코딩 에이전트(Codex)와 실무형 과제를 수행할 때 쓰는 **작업 방식 키트**입니다.
과제 코드나 정답은 들어 있지 않고, 일하는 순서·문서 양식·위임 프롬프트 패턴만 담았습니다.

## 들어 있는 것

| 경로 | 용도 |
|---|---|
| `AGENTS.template.md` | 작업 폴더 루트에 `AGENTS.md`로 복사해 쓰는 에이전트 지침 골격 |
| `docs/templates/interview.md` | 실무자 인터뷰 질문 순서와 기록 양식 |
| `docs/templates/agreement.md` | 구현 전 합의문 양식 |
| `docs/templates/decisions.md` | 설계 결정(이유·버린 대안·감수한 제약), 까다로운 케이스, 가정 |
| `docs/templates/ai-judgment-log.md` | AI 제안 수용·수정·폐기와 근거·계기 |
| `docs/templates/architecture.md` | 구성 요소 책임, 요청 흐름, 특이 케이스 동작, 취약점 |
| `docs/templates/verification.md` | 성공 기준·규칙 준수(별도 검사기)·기준선 비교·미검증 위험 |
| `docs/templates/handoff.md` | 인수인계(실행법·범위 현황·한계·다음 할 일) |
| `prompts/delegation.md` | 작은 단위 위임·검증·교차 리뷰 프롬프트 패턴 |
| `checklists/submit.md` | 제출 직전 체크리스트 |
| `checklists/questions.md` | 후속 질문 유형과 답변 틀 |
| `scripts/bootstrap.sh` | 위 템플릿을 작업 폴더에 복사 (기존 파일은 덮어쓰지 않음) |
| `skills/cofa-workflow` | 과제 전체 진행 순서 스킬 |
| `skills/verify-and-review` | 성공 기준 검증·결함 찾기 스킬 |
| `skills/handoff-doc` | 저장소 안 인수인계 문서 작성 스킬 |
| `skills/qa-brief` | 기록·코드 근거로 후속 질문 브리프(`docs/qa-brief.md`) 작성 스킬 |
| `scripts/install-skills.sh` | 스킬을 `$HOME/.agents/skills`에 설치 (`--with-community`: mattpocock/skills의 tdd, diagnosing-bugs 추가) |

## 사용법

```bash
git clone https://github.com/Jeonsubb/cofa-kit.git /tmp/cofa-kit
bash /tmp/cofa-kit/scripts/bootstrap.sh .
bash /tmp/cofa-kit/scripts/install-skills.sh --with-community
# Codex 재시작 후 /skills 로 확인, $cofa-workflow 처럼 호출
```

외부 스킬: [mattpocock/skills](https://github.com/mattpocock/skills) (MIT License)를 설치 시점에 공개 저장소에서 가져옵니다.

과제 안내에 필수 파일명·양식이 있으면 **과제 안내가 항상 우선**입니다.
이 키트의 양식은 필요한 부분만 골라 쓰고, 맞지 않으면 버립니다.

## 원칙

1. 해법보다 문제를 먼저 확인한다.
2. 구현 전에 성공 기준을 숫자로 합의한다.
3. 판정·계산은 고정 코드로, AI는 해석·초안을 맡는다.
4. 작은 단위로 위임하고, 결과는 직접 읽고 테스트로 확인한 뒤 커밋한다.
5. 판단과 근거를 남겨, 다른 사람이 이어받을 수 있게 한다.
