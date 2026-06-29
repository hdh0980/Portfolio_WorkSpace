# 증폭기 기본구조

## 학습 목표
- 공통소스(CS), 공통드레인(CD, 소스팔로워), 공통게이트(CG) 세 가지 기본 구조의 특성을 비교할 수 있다.
- 각 구조의 전압이득, 입력임피던스, 출력임피던스를 소신호 모델로 계산할 수 있다.
- 다단 증폭기의 전체 이득과 대역폭 관계를 이해한다.
- 전력이득(dB)과 증폭기 효율을 정의하고 계산할 수 있다.
- 이득-대역폭 트레이드오프와 EV 전류감지 회로의 연결을 이해한다.

---

## 1. 세 가지 기본 MOSFET 증폭기 구조 비교

| 구조 | 입력 | 출력 | 전압이득 | 입력 $Z$ | 출력 $Z$ | 특징 |
|---|---|---|---|---|---|---|
| CS (공통소스) | Gate | Drain | $-g_m(R_D\|r_o)$ | $\infty$ (DC) | $R_D\|r_o$ | 반전 이득, 가장 범용 |
| CD (소스팔로워) | Gate | Source | $\approx +1$ | $\infty$ | $1/g_m \| r_o$ | 버퍼, 저출력 임피던스 |
| CG (공통게이트) | Source | Drain | $+g_m(R_D\|r_o)$ | $1/g_m$ | $R_D\|r_o$ | 비반전, 저입력 임피던스, 고주파 유리 |

---

## 2. 공통소스 (CS) 증폭기

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 7.15.

$$A_v = -g_m(R_D \| r_o)$$

소신호 입력 저항(게이트 편향 저항 포함):

$$R_{in} = R_{G1} \| R_{G2}$$

출력 저항:

$$R_{out} = R_D \| r_o$$

**전류감지 응용:** CS 구조는 입력 임피던스가 매우 높아 센서 신호 수신에 적합. 단, 위상 반전($180°$) 주의.

---

## 3. 공통드레인 (CD, 소스팔로워) 증폭기

$$A_v = \frac{g_m(R_S \| r_o)}{1 + g_m(R_S \| r_o)} \approx 1 \quad (g_m R_S \gg 1 \text{ 시})$$

출력 저항:

$$R_{out} = R_S \| r_o \| \frac{1}{g_m} \approx \frac{1}{g_m} \quad (r_o \gg 1/g_m)$$

전압이득 ≈ 1이지만 낮은 출력 임피던스로 임피던스 변환에 활용.

---

## 4. 공통게이트 (CG) 증폭기

$$A_v = +g_m(R_D \| r_o)$$

입력 저항:

$$R_{in} = \frac{1}{g_m} \| R_S \approx \frac{1}{g_m}$$

출력 저항:

$$R_{out} = R_D \| r_o(1 + g_m r_s)$$

$r_o$ 효과까지 포함하면 출력 저항이 매우 커질 수 있음 → 캐스코드 증폭기의 상단 소자로 사용.

---

## 5. 캐스코드(Cascode) 증폭기

CS + CG를 직렬 연결 → 높은 출력 임피던스, 밀러 효과 억제.

$$R_{out,cascode} \approx g_{m2}r_{o2}r_{o1}$$

이득:

$$A_v = -g_{m1}(R_{out,cascode} \| R_L)$$

전력전자 게이트드라이버 IC에서 출력단 직렬 연결과 유사한 개념.

---

## 6. 다단 증폭기

총 전압이득:

$$A_v = A_{v1} \cdot A_{v2} \cdot \ldots \cdot A_{vn}$$

dB 이득:

$$A_v(\text{dB}) = 20\log_{10}|A_v|$$

직렬 연결 시 각 단의 출력 임피던스($R_{out,n}$)와 다음 단의 입력 임피던스($R_{in,n+1}$) 간 부하 효과로 실제 이득 감소:

$$A_{v,actual} = A_{v,open-loop} \cdot \frac{R_{in,n+1}}{R_{in,n+1} + R_{out,n}}$$

---

## 7. 전력이득과 효율

**전력이득:**

$$A_P = A_v \cdot A_i = A_v^2 \cdot \frac{R_{in}}{R_L}$$

$$A_P(\text{dB}) = 10\log_{10} A_P$$

**증폭기 효율 (전력 효율):**

$$\eta = \frac{P_L}{P_{DC}} \times 100\%$$

| 급(Class) | 도통각 | 이론 최대 효율 |
|---|---|---|
| A | 360° | 25~50% |
| B | 180° | 78.5% |
| AB | >180° | 50~78.5% |
| D | 스위칭 | >90% |

---

## 8. 계산 예제

**문제:** 2단 CS 증폭기. 각 단: $g_m = 5\ \text{mA/V}$, $r_o = 40\ \text{k}\Omega$, $R_D = 10\ \text{k}\Omega$
부하 $R_L = 10\ \text{k}\Omega$, 단간 결합 캐패시터로 DC 분리.

**Step 1:** 1단 이득 (2단 입력 임피던스 = $R_{G2}$ 무시, $\infty$ 가정)

$$A_{v1} = -g_m(R_D \| r_o) = -5\times10^{-3}(10\text{k}\|40\text{k})$$

$$= -5\times10^{-3} \times 8\ \text{k}\Omega = -40$$

**Step 2:** 2단 이득 ($R_L$ 포함)

$$A_{v2} = -g_m(R_D \| r_o \| R_L) = -5\times10^{-3}(10\text{k}\|40\text{k}\|10\text{k})$$

$$10\text{k}\|40\text{k} = 8\ \text{k}\Omega,\quad 8\text{k}\|10\text{k} = 4.44\ \text{k}\Omega$$

$$A_{v2} = -5\times10^{-3}\times4.44\text{k} = -22.2$$

**Step 3:** 총 이득

$$A_v = A_{v1}\cdot A_{v2} = (-40)\times(-22.2) = 888 \approx 59\ \text{dB}$$

---

## 9. 실무 연결과 주의점

- **OBC 전류감지 증폭기(CSA) 체인:** 션트 $10\ \text{m}\Omega$ 양단 전압(최대 $50\ \text{mV}$)을 1단 CS(이득 $\times$10) → 2단 버퍼(CD)로 구성 → ADC 입력에 공급. 공통모드 전압($V_{bus}/2$) 허용을 위해 차동 입력 구조 필수.
- **이득-대역폭 곱(GBW):** 단극 시스템에서 $A_v \cdot f_{3dB} = f_T$(상수). 이득을 높이면 대역폭 줄어듦 → 고속 전류 제어 루프에서는 이득보다 대역폭 우선.
- **밀러 효과 억제:** CS 구조에서 $C_{gd}$의 밀러 용량 $C_M = (1-A_v)C_{gd}$가 입력 커패시턴스를 크게 증가 → 캐스코드나 CG 단 추가로 해결.
- **전원 노이즈 민감도:** 다단 증폭기에서 전원 노이즈(PSRR)는 각 단의 부하 저항을 통해 신호에 혼입 → 바이패스 캐패시터 및 LDO 레귤레이터로 격리.

---

## 10. 자가 점검

1. CS, CD, CG 증폭기 중 입력 임피던스가 가장 낮은 것과 그 이유는?
2. 소스팔로워(CD)의 전압이득이 1 미만인 이유를 식으로 설명하라.
3. 두 CS 증폭기를 직렬 연결하면 위상이 어떻게 되는가?
4. 전력 효율이 D급에서 이론적으로 100%에 가까운 이유는?

<details><summary>정답</summary>

1. CG(공통게이트). 소스 단자가 입력이므로 입력 저항 $R_{in} \approx 1/g_m$ (수백 $\Omega$ 수준). CS/CD는 게이트 입력으로 DC 전류 없음 → 입력 저항 무한대.
2. $A_v = g_m R_S / (1 + g_m R_S)$. 분자 $g_m R_S$가 분모보다 항상 작으므로 이득 < 1. 소스의 소신호 전압은 게이트 소신호 전압에서 $g_m v_{gs}$에 의한 강하분을 빼서 형성.
3. 1단 CS: $-180°$ 위상 반전. 2단 CS: 다시 $-180°$ → 총 $-360°$ = $0°$ (비반전). 두 반전이 상쇄.
4. D급은 출력 트랜지스터가 완전 ON(도통) 또는 완전 OFF(차단)로만 동작 → 이상적으로 소자 양단 전압과 전류가 동시에 존재하지 않음 → 소자 소모 전력 = $V_{sat} \cdot I_{on} \approx 0$. 실제는 스위칭 손실과 $R_{DS(on)}$ 도통손실로 90~95% 달성.

</details>

---

## 참고자료

- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — CS/CD/CG 증폭기 분석
- [MIT OCW 6.301 Solid State Circuits](https://ocw.mit.edu/courses/6-301-solid-state-circuits-fall-2010/) — 다단·캐스코드 심화
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.7 — 기본 증폭기 세 구조 전체
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., Ch.3 — CS/CD/CG 소신호 해석
- [OpenStax University Physics](https://openstax.org/subjects/science) — 전력·에너지 기초
