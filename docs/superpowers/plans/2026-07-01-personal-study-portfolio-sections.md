# Personal Study Portfolio Sections Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 전기전자 핵심기초 단원 문서를 개인이 다시 읽기 좋은 학습 포트폴리오 구조로 바꾼다.

**Architecture:** 각 단원 말미의 `실무 연결과 주의점`과 삭제된 `자가 점검` 자리를 하나의 `학습·검증 기록`으로 통합한다. 기록은 문서 본문에 이미 존재하는 내용만 근거로 `핵심 정리`, `확인 근거`, `다음 탐구`를 단원별로 작성하며, 상위 안내 문서도 같은 용어로 맞춘다.

**Tech Stack:** Markdown, Git, PowerShell, ripgrep

---

### Task 1: 변경 전 검증 기준 고정

**Files:**
- Read: `studies/전공학습/01_전기전자_핵심기초/**/*.md`

- [ ] **Step 1: 기존 표현 수를 기록한다**

Run:

```powershell
rg -l -g '*.md' '실무 연결과 주의점' 'studies/전공학습/01_전기전자_핵심기초' | Measure-Object
rg -l -g '*.md' '자가 점검|자가점검' 'studies/전공학습/01_전기전자_핵심기초' | Measure-Object
rg -l -g '*.md' '^## 학습·검증 기록$' 'studies/전공학습/01_전기전자_핵심기초' | Measure-Object
```

Expected: 각각 `45`, `0`, `0`. 직류회로 해석 문서는 기존 실무 섹션 대신 MATLAB 검증 섹션을 갖고 있으므로 첫 수치가 단원 수 46보다 하나 적다.

- [ ] **Step 2: 작업 트리 기준점을 확인한다**

Run: `git status --short`

Expected: 기존 48개 Markdown 수정과 설계·계획 문서만 표시되며, 기존 수정은 복원하거나 폐기하지 않는다.

### Task 2: 회로이론 기록 개편

**Files:**
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/01_회로변수와_기본법칙/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/02_직류회로_해석/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/03_회로망_정리/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/04_1차_2차_과도응답/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/05_정현파_교류와_페이저/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/06_교류전력과_3상회로/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/07_공진과_주파수응답/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/08_라플라스_회로해석/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/01_회로이론/09_결합회로와_2포트망/README.md`

- [ ] **Step 1: 9개 단원에 학습·검증 기록을 작성한다**

각 단원에서 기존 실무 섹션을 제거하고 아래 형식을 한 번만 넣는다. 직류회로 해석은 `MATLAB 검증과 재생성` 뒤에 같은 형식을 추가한다.

```markdown
## 학습·검증 기록

- **핵심 정리:** 본문의 해석 원리와 적용 조건을 한 문장으로 요약한다.
- **확인 근거:** 본문의 계산 예제 또는 MATLAB 결과가 확인한 값을 명시한다.
- **다음 탐구:** 현재 모델에서 빠진 비이상성 또는 확장 해석 한 가지를 명시한다.
```

단원별 초점은 `전력수지`, `노달·메시 해의 일치`, `테브난·노턴 등가`, `초기조건과 감쇠`, `RMS·위상`, `3상 복소전력`, `공진 Q`, `극점·영점`, `결합계수·ABCD 행렬` 순서로 한다.

- [ ] **Step 2: 과목 안내 문구를 바꾼다**

`학습 목표 → 핵심 개념 → 수식·적용 조건 → 계산 예제 → 실무 연결 → 참고자료`를 `학습 목표 → 핵심 개념 → 수식·적용 조건 → 계산·검증 → 학습 기록 → 참고자료`로 바꾸고, `실무 주의점` 표현을 `후속 탐구`로 바꾼다.

- [ ] **Step 3: 회로이론 범위를 확인한다**

Run:

```powershell
rg -l -g 'README.md' '^## 학습·검증 기록$' 'studies/전공학습/01_전기전자_핵심기초/01_회로이론' | Measure-Object
```

Expected: `9`.

### Task 3: 전자기학 기록 개편

**Files:**
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/01_벡터해석과_좌표계/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/02_정전계/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/03_전위와_정전용량/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/04_도체_유전체와_경계조건/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/05_정상전류와_전도/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/06_정자계/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/07_자성체와_인덕턴스/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/08_시변전자계와_맥스웰방정식/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/02_전자기학/09_전자파와_전송선/README.md`

- [ ] **Step 1: 9개 단원에 학습·검증 기록을 작성한다**

공통 형식은 Task 2와 같고, 확인 근거는 각 문서의 계산 예제나 비교표만 사용한다. 단원별 초점은 `좌표 변환과 미분 연산자`, `가우스 법칙`, `전위·정전용량`, `경계조건`, `전류밀도·손실`, `비오-사바르·앙페르`, `자기회로·포화`, `맥스웰 방정식`, `반사계수·정합` 순서로 한다.

- [ ] **Step 2: 과목 안내를 학습 기록 중심으로 바꾼다**

단원 설명에 개인 재학습용 계산·검증 기록과 후속 탐구가 포함된다는 문장을 추가하되 수행하지 않은 FEM·실험을 증거로 쓰지 않는다.

- [ ] **Step 3: 전자기학 범위를 확인한다**

Run: `rg -l -g 'README.md' '^## 학습·검증 기록$' 'studies/전공학습/01_전기전자_핵심기초/02_전자기학' | Measure-Object`

Expected: `9`.

### Task 4: 전자회로 기록 개편

**Files:**
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/01_반도체와_PN접합/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/02_다이오드_회로/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/03_BJT_동작원리/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/04_MOSFET_동작원리/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/05_바이어스와_소신호모델/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/06_증폭기_기본구조/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/07_연산증폭기/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/08_주파수응답과_피드백/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/09_발진기/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/03_전자회로/10_출력단과_전원회로/README.md`

- [ ] **Step 1: 10개 단원에 학습·검증 기록을 작성한다**

단원별 초점은 `캐리어·접합`, `정류·클램핑`, `BJT 영역 판정`, `MOSFET 영역·게이트 전하`, `동작점·소신호`, `증폭기 이득·대역폭`, `연산증폭기 비이상성`, `루프이득·안정도`, `발진 조건`, `출력단 효율·열저항` 순서로 한다. 확인 근거는 본문 계산값을 다시 인용하고, 다음 탐구는 데이터시트나 SPICE에서 확인할 비이상성 한 가지로 제한한다.

- [ ] **Step 2: 과목 안내를 학습 기록 중심으로 바꾼다**

기존 응용 중심 소개를 유지하되 단원별 계산 근거와 다음 탐구를 찾아볼 수 있다는 안내로 정리한다.

- [ ] **Step 3: 전자회로 범위를 확인한다**

Run: `rg -l -g 'README.md' '^## 학습·검증 기록$' 'studies/전공학습/01_전기전자_핵심기초/03_전자회로' | Measure-Object`

Expected: `10`.

### Task 5: 논리회로 기록 개편

**Files:**
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/01_수체계와_디지털코드/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/02_부울대수와_논리게이트/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/03_논리식_간소화/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/04_조합논리회로/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/05_플립플롭/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/06_레지스터와_카운터/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/07_순차논리와_상태기계/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/08_메모리와_프로그램가능논리/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/04_논리회로/09_타이밍과_HDL기초/README.md`

- [ ] **Step 1: 9개 단원에 학습·검증 기록을 작성한다**

단원별 초점은 `진수·코드 변환`, `진리표·게이트 등가`, `K-map 최소화`, `조합회로 식`, `플립플롭 타이밍`, `카운터·분주`, `FSM 전이`, `메모리 특성`, `HDL·타이밍 여유` 순서로 한다. 확인 근거는 각 문서의 변환·진리표·계산 예제 결과를 사용한다.

- [ ] **Step 2: 과목 안내를 학습 기록 중심으로 바꾼다**

`임베디드·MCU와의 연결` 소개는 유지하되 문제집식 표현 대신 설계 규칙을 다시 찾는 개인 기록이라는 목적을 덧붙인다.

- [ ] **Step 3: 논리회로 범위를 확인한다**

Run: `rg -l -g 'README.md' '^## 학습·검증 기록$' 'studies/전공학습/01_전기전자_핵심기초/04_논리회로' | Measure-Object`

Expected: `9`.

### Task 6: 신호와 시스템 기록 개편

**Files:**
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/01_신호의_표현과_분류/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/02_시스템의_성질/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/03_LTI시스템과_컨볼루션/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/04_푸리에급수/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/05_푸리에변환/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/06_라플라스변환과_연속시스템/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/07_샘플링과_복원/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/08_이산신호와_Z변환/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템/09_주파수응답과_필터기초/README.md`

- [ ] **Step 1: 9개 단원에 학습·검증 기록을 작성한다**

단원별 초점은 `신호 분류`, `시스템 성질`, `컨볼루션`, `푸리에 계수`, `변환 성질`, `극점·ROC`, `샘플링·에일리어싱`, `Z변환·안정도`, `필터 응답` 순서로 한다. 확인 근거는 본문 계산 예제의 입력·출력이나 판정 결과를 명시한다.

- [ ] **Step 2: 과목 안내를 학습 기록 중심으로 바꾼다**

제어·파워일렉트로닉스 연결은 과목 맥락으로 남기되, 단원 문서의 공통 말미 구조를 `학습·검증 기록`으로 안내한다.

- [ ] **Step 3: 신호와 시스템 범위를 확인한다**

Run: `rg -l -g 'README.md' '^## 학습·검증 기록$' 'studies/전공학습/01_전기전자_핵심기초/05_신호와_시스템' | Measure-Object`

Expected: `9`.

### Task 7: 상위 색인과 전체 품질 검증

**Files:**
- Modify: `studies/전공학습/README.md`
- Modify: `studies/전공학습/01_전기전자_핵심기초/README.md`

- [ ] **Step 1: 상위 색인 표현을 맞춘다**

회로이론 설명의 `자가 점검`을 `학습·검증 기록`으로 바꾸고, 전기전자 핵심기초 폴더가 개인 재학습용 핵심 정리·검증 근거·후속 탐구를 모은다는 설명을 추가한다.

- [ ] **Step 2: 금지 표현과 필수 구조를 검사한다**

Run:

```powershell
rg -n -g '*.md' '실무 연결과 주의점|자가 점검|자가점검' 'studies/전공학습/01_전기전자_핵심기초'
rg -l -g 'README.md' '^## 학습·검증 기록$' 'studies/전공학습/01_전기전자_핵심기초' | Measure-Object
rg -l -g 'README.md' '\*\*핵심 정리:\*\*' 'studies/전공학습/01_전기전자_핵심기초' | Measure-Object
rg -l -g 'README.md' '\*\*확인 근거:\*\*' 'studies/전공학습/01_전기전자_핵심기초' | Measure-Object
rg -l -g 'README.md' '\*\*다음 탐구:\*\*' 'studies/전공학습/01_전기전자_핵심기초' | Measure-Object
```

Expected: 첫 명령은 결과 없음, 나머지는 각각 `46`.

- [ ] **Step 3: Markdown과 링크 상태를 검사한다**

Run:

```powershell
git diff --check
$files = rg -l -g 'README.md' '^## 학습·검증 기록$' 'studies/전공학습/01_전기전자_핵심기초'
if (($files | Measure-Object).Count -ne 46) { throw 'unit document count mismatch' }
```

Expected: 오류 없음.

- [ ] **Step 4: 변경 범위를 검토한다**

Run: `git diff --stat; git status --short`

Expected: 대상 Markdown과 설계·계획 문서만 변경 또는 추가되어 있고, 이미지·코드·제어시스템 문서는 변경되지 않는다.

- [ ] **Step 5: 구현 결과를 커밋한다**

```powershell
git add -- 'studies/전공학습/README.md' 'studies/전공학습/01_전기전자_핵심기초'
git commit -m 'docs: reshape study notes as personal portfolio records'
```

Expected: 구현 Markdown만 포함한 새 커밋이 생성된다. 원격 저장소에는 push하지 않는다.
