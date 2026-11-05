# 연산증폭기 (Op-Amp)

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

→ 고주파 노이즈 증폭 문제 → 입력 $C$에 직렬로 작은 $R_1$을 추가해 고주파 이득 제한.

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

$$f_{-3dB} = \frac{\text{GBW}}{|A_v|} = \frac{1\times10^6}{10} = 100\ \text{kHz} \gg 1\ \text{kHz}$$

**Step 3:** 슬루율 확인

$$\frac{dv_o}{dt}\bigg|_{peak} = 2\pi f \cdot V_{peak} = 2\pi\times1000\times1.0 \approx 6.28\ \text{V/ms} = 0.00628\ \text{V/μs}$$

$0.00628 \ll 0.5\ \text{V/μs}$ → 슬루율 제한 없음.

---

## 메모

이득 −10 반전 증폭기에 0.1 V를 넣으면 출력 진폭은 1.0 V이고, 1 kHz에서 필요한 슬루율 0.00628 V/μs는 0.5 V/μs보다 훨씬 작다. 폐루프 대역폭도 100 kHz라 여유가 있다.
OPA365 데이터시트에서 입력 공통모드 범위, 출력 스윙, 입력 바이어스 전류, 용량성 부하 안정도를 읽고 이상식이 통하는 입출력 범위를 정리해 둘 것.

---

## 참고자료

- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — Op-amp 회로 설계 실습
- [MIT OCW 6.301 Solid State Circuits](https://ocw.mit.edu/courses/6-301-solid-state-circuits-fall-2010/) — 실제 op-amp 내부 구조
- [OpenStax University Physics](https://openstax.org/subjects/science) — 전기 회로 기초
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.2 — Op-amp 이상·비이상 특성 전체
- [Texas Instruments OPA365 데이터시트](https://www.ti.com/product/OPA365) — 실제 스펙 해석 연습
- [Texas Instruments INA826 계측증폭기 데이터시트](https://www.ti.com/product/INA826) — 전류감지 응용
