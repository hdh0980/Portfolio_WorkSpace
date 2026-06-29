# 연산증폭기 (Op-Amp)

## 학습 목표
- 이상 op-amp의 가정(무한 이득, 무한 입력 임피던스, 0 출력 임피던스)을 적용한 회로를 해석할 수 있다.
- 반전·비반전·덧셈기·차동·계측 증폭기의 이득 공식을 유도할 수 있다.
- 적분기·미분기의 주파수 응답을 이해하고 실제 한계를 파악한다.
- 슬루율(Slew Rate)의 의미와 대역폭 제한을 계산할 수 있다.
- 전류감지 회로(INA/CSA)와의 실무 연결을 이해한다.

---

## 1. 이상 Op-Amp 특성

| 파라미터 | 이상값 | 실제 TL071 예시 |
|---|---|---|
| 개루프 이득 $A_{OL}$ | $\infty$ | 200,000 (106 dB) |
| 입력 임피던스 $R_{in}$ | $\infty$ | 10 MΩ |
| 출력 임피던스 $R_{out}$ | 0 | 40 Ω |
| 대역폭 | $\infty$ | GBW = 3 MHz |
| 오프셋 전압 $V_{OS}$ | 0 | 3 mV typ |
| 슬루율 SR | $\infty$ | 13 V/μs |

**이상 op-amp 2대 원칙 (부귀환 가정):**
1. 가상 단락(Virtual Short): $v_+ = v_-$
2. 가상 개방(Virtual Open): $i_+ = i_- = 0$

---

## 2. 반전 증폭기

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 2.5.

$$A_v = \frac{v_o}{v_i} = -\frac{R_f}{R_1}$$

입력 저항: $R_{in} = R_1$
출력 저항: $\approx 0$ (이상)

---

## 3. 비반전 증폭기

$$A_v = 1 + \frac{R_f}{R_1}$$

입력 저항: $\approx \infty$
$R_f = 0$, $R_1 = \infty$ 이면 전압 팔로워(unity gain buffer).

---

## 4. 덧셈기 (Summing Amplifier, 반전형)

$$v_o = -\left(\frac{R_f}{R_1}v_1 + \frac{R_f}{R_2}v_2 + \frac{R_f}{R_3}v_3\right)$$

$R_1 = R_2 = R_3 = R_f$이면 $v_o = -(v_1 + v_2 + v_3)$

---

## 5. 차동 증폭기

$$v_o = \frac{R_f}{R_1}(v_+ - v_-)$$

(모든 저항이 같은 비율 $R_f/R_1$을 유지할 때)

**공통모드 제거비 (CMRR):**

$$\text{CMRR} = 20\log_{10}\left|\frac{A_{diff}}{A_{cm}}\right| \quad (\text{dB})$$

저항 매칭 오차가 CMRR을 제한하는 주요 요인 → 정밀 저항 또는 IC 계측증폭기(INA) 사용.

---

## 6. 계측 증폭기 (Instrumentation Amplifier)

3-op-amp INA 구조:

**1단 이득:**

$$A_1 = 1 + \frac{2R}{R_G}$$

**2단 차동:**

$$v_o = A_1(v_+ - v_-)$$

**총 이득:**

$$G = \left(1+\frac{2R}{R_G}\right)\frac{R_4}{R_3}$$

$R_G$ 하나의 저항으로 이득 조절 → 입력 임피던스가 매우 높음 → 션트 저항 전류감지에 최적.

> **EV OBC 전류감지:** 상전류 측정 션트 $R_{shunt} = 1\ \text{m}\Omega$, $I_{peak} = 50\ \text{A}$ → 전압 $50\ \text{mV}$를 INA128(G=100)으로 증폭 → 5V → ADC 풀스케일. CMRR 80 dB 이상 필요($V_{CM} = \pm400\ \text{V}$ 스위칭 노이즈 환경).

---

## 7. 적분기와 미분기

### 7-1. 이상 적분기

$$v_o(t) = -\frac{1}{R_1 C}\int v_i(t)\,dt$$

주파수 영역:

$$A_v(j\omega) = -\frac{1}{j\omega R_1 C}$$

→ $f = 0$ (DC)에서 이득 무한대 → 실제: $C$에 병렬로 $R_f$를 추가해 DC 이득 제한($-R_f/R_1$).

### 7-2. 이상 미분기

$$v_o(t) = -RC\frac{dv_i}{dt}$$

주파수 영역:

$$A_v(j\omega) = -j\omega RC$$

→ 고주파 노이즈 증폭 문제 → $R$ 직렬로 작은 $R_1$을 추가해 고주파 이득 제한.

---

## 8. 슬루율 (Slew Rate)

$$SR = \frac{dv_o}{dt}\bigg|_{max} = \frac{I_{tail}}{C_c}$$

최대 왜곡 없는 주파수:

$$f_{max} = \frac{SR}{2\pi V_{peak}}$$

예: SR = 10 V/μs, $V_{peak} = 5\ \text{V}$:

$$f_{max} = \frac{10\times10^6}{2\pi\times5} \approx 318\ \text{kHz}$$

이 이상 주파수에서 정현파는 삼각파로 왜곡.

---

## 9. 계산 예제

**문제:** 반전 증폭기, $R_1 = 10\ \text{k}\Omega$, $R_f = 100\ \text{k}\Omega$.
입력: $v_i = 0.1\sin(2\pi \times 1\text{kHz} \cdot t)\ \text{V}$, op-amp SR = 0.5 V/μs, GBW = 1 MHz.

**Step 1:** 이득

$$A_v = -\frac{100\text{k}}{10\text{k}} = -10 \Rightarrow v_o = -1.0\sin(\omega t)\ \text{V}$$

**Step 2:** 폐루프 대역폭 확인

$$f_{-3dB} = \frac{\text{GBW}}{|A_v|} = \frac{1\times10^6}{10} = 100\ \text{kHz} \gg 1\ \text{kHz} \quad\checkmark$$

**Step 3:** 슬루율 확인

$$\frac{dv_o}{dt}\bigg|_{peak} = 2\pi f \cdot V_{peak} = 2\pi\times1000\times1.0 \approx 6.28\ \text{V/ms} = 0.00628\ \text{V/μs}$$

$0.00628 \ll 0.5\ \text{V/μs}$ → 슬루율 제한 없음. ✓

---

## 10. 실무 연결과 주의점

- **OBC 상전류 감지 체인:** 션트(SiC MOSFET 소스 경로) → 격리 앰프(ACPL-C87x 또는 AMC1300) → MCU ADC. 격리 앰프 내부가 계측증폭기 구조이며 CMRR과 대역폭이 핵심 스펙.
- **보호 회로 비교기:** 과전류 감지에 LM339 등 open-collector 비교기 사용 → 응답 시간과 히스테리시스(잡음 저항성) 설정이 nuisance trip 방지의 핵심.
- **오프셋 및 드리프트:** INA의 $V_{OS}$ = 25 μV, TCO = 0.1 μV/°C → EV 온도 범위 -40~150°C = 190°C 변화 → 드리프트 = 19 μV. 션트 50 mV 기준으로 0.038% 오차.
- **적분기 사용 시:** 피드백 캐패시터 충전이 과거 오차를 누적하므로 리셋 스위치 또는 초기화 로직 필요 (특히 피드포워드 보상 적분기).

---

## 11. 자가 점검

1. 가상 단락(Virtual Short)이 성립하기 위한 전제 조건은?
2. 반전 증폭기와 비반전 증폭기의 입력 임피던스 차이가 발생하는 이유는?
3. 슬루율 제한이 발생하는 물리적 원인은?
4. INA를 일반 차동증폭기 대신 사용하는 이유는?

<details><summary>정답</summary>

1. 부귀환(negative feedback)이 존재하고, 개루프 이득 $A_{OL}$이 충분히 커서 출력이 포화되지 않는 조건. $A_{OL} \to \infty$이면 $\varepsilon = v_o/A_{OL} \to 0$ → $v_+ \approx v_-$.
2. 반전: 입력 신호가 $R_1$을 통해 가상 접지(virtual ground)인 $v_-$로 연결 → $R_{in} = R_1$ (유한). 비반전: 입력이 직접 $v_+$ 단자(op-amp 입력)로 인가 → $R_{in} \approx \infty$ (이상 op-amp 가정).
3. 내부 보상 캐패시터 $C_c$(밀러 보상)를 충전하는 데 사용할 수 있는 전류 $I_{tail}$(테일 전류원)의 최대값이 한정 → $dv_o/dt|_{max} = I_{tail}/C_c$.
4. INA는 1단 버퍼로 각 입력의 임피던스를 매우 높게 유지하면서 이득을 조정 → 소스 임피던스의 영향 최소화. 일반 차동증폭기는 $R_1$이 입력 임피던스를 제한하고 저항 매칭에 CMRR이 민감하게 의존.

</details>

---

## 참고자료

- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — Op-amp 회로 설계 실습
- [MIT OCW 6.301 Solid State Circuits](https://ocw.mit.edu/courses/6-301-solid-state-circuits-fall-2010/) — 실제 op-amp 내부 구조
- [OpenStax University Physics](https://openstax.org/subjects/science) — 전기 회로 기초
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.2 — Op-amp 이상·비이상 특성 전체
- [Texas Instruments OPA365 데이터시트](https://www.ti.com/product/OPA365) — 실제 스펙 해석 연습
- [Texas Instruments INA826 계측증폭기 데이터시트](https://www.ti.com/product/INA826) — 전류감지 응용
