# UL 1741·UPS Portfolio Assets Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `assets/portfolio/`를 시험 설명 중심의 GitHub 페이지로 만들고, UL 1741 측정 파형은 판독할 수 없게 처리하면서 UPS 파형은 별도 섹션에서 설명한다.

**Architecture:** 기존 UL 1741 PNG 다섯 개의 파일명은 유지하되 원본은 저장소 밖에 백업하고, 파형 영역만 모자이크 처리한 공개용 이미지로 교체한다. `assets/portfolio/README.md`가 UL 1741 시험 케이스와 UPS 파형을 분리해 설명하고, 루트 README는 이 상세 문서로 연결한다.

**Tech Stack:** Markdown, Git, PowerShell, built-in image generation/edit tool

---

### Task 1: 기준 상태와 원본 보존

**Files:**
- Read: `assets/portfolio/ul1741_ess_power_control.png`
- Read: `assets/portfolio/ul1741_ramp_rate.png`
- Read: `assets/portfolio/ul1741_voltage_ride_through.png`
- Read: `assets/portfolio/ul1741_frequency_ride_through.png`
- Read: `assets/portfolio/ul1741_anti_islanding.png`
- Create outside repository: `D:\이력서\portfolio_waveform_originals_private\*.png`

- [ ] **Step 1: 공개 README 부재를 RED 기준으로 확인한다**

Run:

```powershell
if (Test-Path 'assets/portfolio/README.md') { throw 'README already exists' }
```

Expected: 명령이 정상 종료하고 파일이 아직 없음을 확인한다.

- [ ] **Step 2: 원격과 로컬 상태를 확인한다**

Run:

```powershell
git fetch origin
git rev-list --left-right --count origin/main...HEAD
git status --short --branch
```

Expected: 원격 ahead `0`, 로컬 ahead `4`, 작업 트리 clean.

- [ ] **Step 3: 공개 전 원본을 저장소 밖에 복사한다**

Run:

```powershell
$backup = 'D:\이력서\portfolio_waveform_originals_private'
New-Item -ItemType Directory -Force -Path $backup | Out-Null
Copy-Item -LiteralPath 'assets/portfolio/ul1741_ess_power_control.png' -Destination $backup
Copy-Item -LiteralPath 'assets/portfolio/ul1741_ramp_rate.png' -Destination $backup
Copy-Item -LiteralPath 'assets/portfolio/ul1741_voltage_ride_through.png' -Destination $backup
Copy-Item -LiteralPath 'assets/portfolio/ul1741_frequency_ride_through.png' -Destination $backup
Copy-Item -LiteralPath 'assets/portfolio/ul1741_anti_islanding.png' -Destination $backup
```

Expected: 원본 5개가 백업 경로에 있고 저장소 상태는 여전히 clean.

### Task 2: UL 1741 공개용 이미지 생성

**Files:**
- Modify: `assets/portfolio/ul1741_ess_power_control.png`
- Modify: `assets/portfolio/ul1741_ramp_rate.png`
- Modify: `assets/portfolio/ul1741_voltage_ride_through.png`
- Modify: `assets/portfolio/ul1741_frequency_ride_through.png`
- Modify: `assets/portfolio/ul1741_anti_islanding.png`

- [ ] **Step 1: ESS Power Control 파형을 비공개 처리한다**

Built-in image edit prompt:

```text
Use case: precise-object-edit
Asset type: public GitHub technical portfolio image
Primary request: Apply a very coarse, opaque rectangular mosaic to the complete oscilloscope waveform plot area, approximately x=170..1830 and y=375..865 in this 2000x1125 image.
Constraints: preserve the 2000x1125 canvas and every pixel outside the masked rectangle; keep the title, development-content bullets, and channel legend exactly readable; do not rewrite, translate, redraw, sharpen, or invent any text; the waveform, axes, annotations, amplitude, phase, timing, and measurements inside the rectangle must be impossible to read.
Avoid: new labels, changed typography, reconstructed traces, watermark.
```

Copy the accepted output over `assets/portfolio/ul1741_ess_power_control.png` only after visual inspection.

- [ ] **Step 2: Ramp Rate 측정 파형을 비공개 처리한다**

Edit the original with the same invariant prompt, changing the mosaic rectangle to approximately `x=870..1950, y=175..1115`. Preserve the left concept graph and four ramp-rate settings exactly.

- [ ] **Step 3: Voltage Ride-Through 측정 파형을 비공개 처리한다**

Edit with mosaic rectangle `x=870..1950, y=175..1100`. Preserve the left voltage-time region chart and six case descriptions exactly.

- [ ] **Step 4: Frequency Ride-Through 측정 파형을 비공개 처리한다**

Edit with mosaic rectangle `x=870..1950, y=180..1100`. Preserve the left frequency-time region chart and five case descriptions exactly.

- [ ] **Step 5: Anti-Islanding 측정 파형을 비공개 처리한다**

Edit with mosaic rectangle `x=45..1950, y=660..1095`. Preserve the title, RLC circuit, four-step sequence, and quoted criterion exactly.

- [ ] **Step 6: 공개용 이미지 불변 조건을 확인한다**

For each output, inspect with `view_image` and confirm:

- dimensions remain 2000x1125;
- all retained case text is readable and unchanged;
- all original waveform traces, axes, values, and time response are unreadable;
- no generated or altered text appears.

If any invariant fails, run one targeted image edit retry. If the second output still changes retained text, stop and report the built-in edit limitation instead of publishing it.

### Task 3: 상세 자산 README 작성

**Files:**
- Create: `assets/portfolio/README.md`

- [ ] **Step 1: UL 1741 개요와 공개 범위를 작성한다**

The opening must state:

```markdown
# 전력변환·계통연계 검증 포트폴리오

이 폴더는 UL 1741 SA 기반 ESS 계통연계 시험과 UPS 검증 사례를 시험 목적별로 정리합니다. UL 1741은 분산에너지자원에 사용하는 인버터·컨버터·제어기·계통연계 장비를 다루는 표준이며, SA는 계통 이상 상태에서의 전력 조정과 계통 지원 기능을 검증하기 위한 시험 방법을 보완했습니다.

> 공개 범위: UL 1741 측정 파형은 시험 조건과 케이스만 남기고 모자이크 처리했습니다. 아래 내용은 수행 범위와 해석 관점을 보여 주는 포트폴리오 요약이며, 공인 인증서나 전체 시험성적서가 아닙니다. 이미지의 수치와 시간은 해당 캡처의 설정·결과이며 최신 표준의 보편 요구값으로 일반화하지 않습니다.
```

- [ ] **Step 2: UL 1741 다섯 시험을 표로 요약한다**

Use a table with columns `시험`, `목적`, `주요 케이스`, `확인 관점` and these exact rows:

- ESS Power Control — charge/stand-by/discharge mode change and soft reference transition
- Ramp Rate — normal ramp 50/100% rated current per second and soft-start 10/20% per second as capture settings
- Voltage Ride-Through — HV2/HV1/NN/LV1/LV2/LV3 areas and trip/ride-through/recovery behavior
- Frequency Ride-Through — HF2/HF1/NN/LF1/LF2 areas and trip/ride-through/recovery behavior
- Anti-Islanding — grid-open event, island detection, and cease-to-energize response

- [ ] **Step 3: 각 UL 1741 이미지와 설명을 매칭한다**

For each test, add the sanitized image and four bullets: `시험 목적`, `시험 입력·상태`, `확인 항목`, `이미지 매칭`. Use image-relative links with the existing filenames. State measured results only when visible in retained case text; otherwise describe the intended check without pass/fail certification language.

- [ ] **Step 4: UPS를 별도 섹션으로 작성한다**

Create `## UPS 검증 파형` with three subsections and images:

- Parallel operation: output voltage/current steady state and current sharing; visible measurements `219.2 V RMS`, `10.07 A`, `5.31 A`, `4.81 A` without assigning undocumented module names.
- Load transient: step at 0 ms, voltage continuity and current-channel transition before/after the step.
- Hot swap: current-channel transfer around 0 ms and output continuity, without assigning undocumented channel identities.

- [ ] **Step 5: 공식 참고자료를 연결한다**

Add these links:

- `https://www.ul.com/services/distributed-energy-resource-testing`
- `https://www.ul.com/news/ul-launches-advanced-inverter-testing-and-certification-program`
- `https://resourcecenter.ieee.org/education/tutorials/pes_ed_tut04_1547_091318_sld`

### Task 4: 저장소 루트 README 재구성

**Files:**
- Modify: `README.md`

- [ ] **Step 1: 저장소 소개와 바로가기를 한국어로 정리한다**

Replace the current English introduction and raw asset list with a Korean introduction and these primary links:

```markdown
- [검증 자산: UL 1741 SA·UPS 시험 설명](./assets/portfolio/)
- [전공학습 전체 목차](./studies/전공학습/)
- [제어시스템 설계](./studies/전공학습/02_제어시스템_설계/)
```

- [ ] **Step 2: 실제 폴더 구조를 코드 블록으로 표시한다**

The tree must include:

```text
Portfolio_WorkSpace/
├─ assets/portfolio/                 # UL 1741 SA·UPS 검증 자산과 상세 설명
├─ studies/전공학습/
│  ├─ 01_전기전자_핵심기초/          # 5과목·46개 단원
│  ├─ 02_제어시스템_설계/            # 노트 7개·MATLAB 예제·비교 프로젝트
│  ├─ 03_모델링_시뮬레이션/          # 계획
│  ├─ 04_전력변환_회로/              # 계획
│  ├─ 05_모터구동_제어/              # 계획
│  ├─ 06_센서_신호처리/              # 계획
│  ├─ 07_전동화_시스템/              # 계획
│  ├─ 08_공학기초_수학/              # 계획
│  ├─ 09_기술동향_리서치/            # 계획
│  └─ 10_산업사례_리뷰/              # 계획
└─ docs/superpowers/                 # 작업 설계·구현 계획 기록
```

- [ ] **Step 3: 완료 콘텐츠와 계획 콘텐츠를 분리한다**

Add a completed-content table covering:

- UL 1741 SA: ESS power control, ramp rate, voltage/frequency ride-through, anti-islanding;
- UPS: parallel operation, load transient, hot swap;
- electrical/electronic foundations: 46 units across five subjects, each with learning/verification records;
- control-system design: seven notes, one first-order PI/IP MATLAB example, and one PI/IP/PID comparison project.

Add one short planned-areas paragraph listing 03 through 10 without claiming completed content.

- [ ] **Step 4: 오래되거나 중복된 문구를 제거한다**

Remove nonexistent `profile_hwang_Duckhwan.jpg` and `hils_test_environment.png`, all duplicate raw PNG filename lists, and the stale claim that subjects other than circuit theory are scaffolds. Keep privacy and stable-link maintenance principles in concise Korean.

### Task 5: 전체 검증

**Files:**
- Test: `assets/portfolio/README.md`
- Test: `README.md`
- Test: five sanitized UL 1741 PNGs

- [ ] **Step 1: Markdown 구조와 링크를 검사한다**

Run a PowerShell link check over both README files. Expected: 8 relative image links exist and three official HTTPS links are present.

- [ ] **Step 2: 공개 이미지와 백업 원본이 서로 다른지 검사한다**

Run:

```powershell
$backup='D:\이력서\portfolio_waveform_originals_private'
Get-ChildItem 'assets/portfolio/ul1741_*.png' | ForEach-Object {
  $old=Join-Path $backup $_.Name
  if((Get-FileHash $_.FullName).Hash -eq (Get-FileHash $old).Hash){ throw "not sanitized: $($_.Name)" }
}
```

Expected: five files all differ from backup.

- [ ] **Step 3: 변경 범위와 Markdown whitespace를 검사한다**

Run:

```powershell
git diff --check
git status --short
```

Expected: root README, asset README, and five UL 1741 PNGs only. Design and plan documents are already committed.

- [ ] **Step 4: GitHub 렌더링 형태를 검토한다**

Commit locally, push, then open `https://github.com/hdh0980/Portfolio_WorkSpace/tree/main/assets/portfolio` and confirm the README, headings, tables, images, and links render.

### Task 6: 커밋과 원격 반영

**Files:**
- Commit: `README.md`
- Commit: `assets/portfolio/README.md`
- Commit: five UL 1741 PNGs

- [ ] **Step 1: 구현 파일만 커밋한다**

```powershell
git add -- 'README.md' 'assets/portfolio/README.md' 'assets/portfolio/ul1741_*.png'
git diff --cached --check
git commit -m 'docs: explain UL 1741 and UPS verification assets'
```

- [ ] **Step 2: push 전 원격 상태를 재확인한다**

```powershell
git fetch origin
git rev-list --left-right --count origin/main...HEAD
```

Expected: remote ahead `0`. If remote ahead is nonzero, rebase and rerun all verification before push.

- [ ] **Step 3: main을 push한다**

```powershell
git push origin main
```

Expected: all pending local commits, including the previously completed study-note commits, are reflected on `origin/main`.

- [ ] **Step 4: remote SHA와 clean state를 확인한다**

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --porcelain
```

Expected: both SHAs match and status output is empty.
