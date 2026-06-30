# 출력단과 전원회로

## 학습 목표
- A/B/AB/D급 증폭기의 도통각, 효율, 왜곡 특성을 비교·계산할 수 있다.
- 크로스오버 왜곡의 원인과 AB급 바이어스로의 해결책을 이해한다.
- 선형 레귤레이터(LDO)의 동작 원리와 드롭아웃 전압을 계산할 수 있다.
- 밴드갭 기준전압의 원리와 온도 보상 메커니즘을 설명할 수 있다.
- 과전류·과열 보호 회로를 EV OBC 전력단 설계와 연결할 수 있다.

---

## 1. 증폭기 급(Class) 비교

### 1-1. A급 증폭기

출력 트랜지스터가 신호 전 주기(360°) 동안 도통.

**최대 효율 (이상적):**

$$\eta_{A,max} = 25\%\quad (\text{저항 부하}),\quad 50\%\quad (\text{변압기 결합})$$

특징: 낮은 왜곡, 낮은 효율 → 소형 오디오, 바이어스 회로에 적합.

### 1-2. B급 증폭기

NPN과 PNP 쌍(push-pull)을 사용, 각각 반주기(180°)만 도통.

**최대 효율:**

$$\eta_{B,max} = \frac{\pi}{4} \approx 78.5\%$$

단점: 크로스오버 왜곡(crossover distortion) — $V_{BE}$ 문턱 근처에서 두 트랜지스터 모두 차단되는 구간 발생.

### 1-3. AB급 증폭기

두 트랜지스터 모두 180°보다 약간 더 도통 (소전류 바이어스).

$$\eta_{AB}: 50\% \sim 78.5\%$$

크로스오버 왜곡 해소, 실용적 오디오·게이트드라이버 출력단에 사용.

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 12.33.

### 1-4. D급 증폭기 (스위칭)

MOSFET이 완전 ON/OFF로 스위칭. PWM + LC 필터로 아날로그 출력 복원.

**이론 최대 효율:**

$$\eta_D \approx 90 \sim 98\%$$

EV 구동 인버터, 오디오 파워 앰프, 전자식 스피커 등에 채용.

---

## 2. 크로스오버 왜곡과 AB급 바이어스

**B급의 크로스오버 왜곡 원인:**

$v_i$가 $\pm 0.7\ \text{V}$ 구간을 통과할 때 NPN/PNP 모두 $V_{BE} < 0.7\ \text{V}$ → 모두 차단 → 출력 0.

**AB급 해결:**

다이오드 또는 VBE 멀티플라이어로 두 트랜지스터에 소전류 바이어스 인가:

$$V_{bias} = 2V_{BE} \approx 1.4\ \text{V}\quad (\text{NPN+PNP 직렬})$$

이 바이어스로 신호 없을 때도 소전류 $I_{Q}$ 흐름 → 크로스오버 구간 제거.

---

## 3. 선형 레귤레이터 (LDO)

**기본 구조:**

패스 소자(PMOS FET 또는 PNP) + 오차 증폭기 + 분압기.

$$V_{out} = V_{ref}\left(1 + \frac{R_1}{R_2}\right)$$

**드롭아웃 전압 (Dropout Voltage):**

$$V_{DO} = V_{in} - V_{out,min}$$

LDO의 $V_{DO}$는 수백 mV 수준, 일반 레귤레이터는 1~3 V.

**전력 소모:**

$$P_{LDO} = (V_{in} - V_{out}) \cdot I_{out}$$

→ 입출력 전압 차가 클수록 열 발생 증가 → 방열 설계 필수.

**부하 과도 응답:**

$$\Delta V_{out} \approx \frac{\Delta I_{out}}{f_{unit} \cdot C_{out}}$$

$f_{unit}$: LDO 루프 단위이득 주파수.

---

## 4. 밴드갭 기준전압

온도와 무관한 안정적인 기준전압 생성 원리.

$$V_{ref} = V_g - \frac{kT}{q}\ln\!\left(\frac{I_{C2}}{I_{C1}}\right) + \text{보정항}$$

Si 밴드갭 $V_g \approx 1.205\ \text{V}$ → 기준전압 $\approx 1.2\ \text{V}$ (BJT 기반)
CMOS 밴드갭: 동일 원리, 일반적으로 $V_{ref} \approx 1.25\ \text{V}$

**PTAT (Proportional To Absolute Temperature):** $\Delta V_{BE}$ 전압이 온도에 비례 — 저온 보정.
**CTAT (Complementary To Absolute Temperature):** $V_{BE}$가 온도에 반비례 — 고온 보정.
두 성분을 적절한 비율로 합산 → 1차 온도 보상.

---

## 5. 과전류 보호 회로

### 5-1. 션트 저항 방식

$$V_{sense} = I_{out} \cdot R_{sense}$$

비교기로 $V_{sense} > V_{ref}$ 감지 시 드라이버 차단.

응답 시간: 비교기 전파 지연 + 드라이버 차단 시간. 목표: $< 1\ \mu\text{s}$.

### 5-2. 전류 접힘 (Foldback Current Limiting)

$$I_{lim}(V_{out}) = I_{lim,0}\left(1 - \frac{V_{out}}{k\,V_{out,max}}\right)$$

단락 시 전류를 추가 감소 → 패스 소자 소모 전력 제한.

---

## 6. 열 보호 (Thermal Shutdown)

$$T_J = T_A + P_D \cdot \theta_{JA}$$

- $T_J$: 접합 온도
- $T_A$: 주위 온도
- $P_D$: 소자 소모 전력
- $\theta_{JA}$: 접합-주변 열저항 (°C/W)

온도 센서(다이오드 또는 BJT)로 $T_J > T_{shutdown}$(보통 150~175°C) 시 차단.

히스테리시스 포함: $T_{shutdown} - T_{restart} \approx 20\sim40\ \text{°C}$.

---

## 7. 계산 예제

**문제 1: AB급 효율**

$V_{CC} = \pm 15\ \text{V}$, $R_L = 8\ \Omega$, 출력 정현파 진폭 $V_{pk} = 12\ \text{V}$, $I_Q = 20\ \text{mA}$ (바이어스 전류).

출력 전력:

$$P_L = \frac{V_{pk}^2}{2R_L} = \frac{144}{16} = 9\ \text{W}$$

DC 전력 공급:

$$P_{DC} = 2V_{CC}\cdot\frac{V_{pk}}{\pi R_L} + 2V_{CC}\cdot I_Q = 30\times\frac{12}{\pi\times8} + 30\times0.02$$

$$= 30\times0.477 + 0.6 = 14.3 + 0.6 = 14.9\ \text{W}$$

효율:

$$\eta = \frac{9}{14.9}\times100\% \approx 60.4\%$$

**문제 2: LDO 열 계산**

$V_{in} = 5\ \text{V}$, $V_{out} = 3.3\ \text{V}$, $I_{out} = 500\ \text{mA}$, $\theta_{JA} = 50\ \text{°C/W}$, $T_A = 25\ \text{°C}$.

$$P_{LDO} = (5-3.3)\times0.5 = 0.85\ \text{W}$$

$$T_J = 25 + 0.85\times50 = 25 + 42.5 = 67.5\ \text{°C}$$

→ 정상 범위 (< 125°C). ✓

---

## 학습·검증 기록

- **핵심 정리:** 출력단은 도통각과 바이어스로 효율·크로스오버 왜곡을 절충하고, 전원 회로는 소모전력에서 접합온도까지 이어지는 열저항 경로를 함께 계산해야 한다.
- **확인 근거:** AB급 예제에서 출력 $9\ \text{W}$와 DC 입력 $14.9\ \text{W}$로 효율 $60.4\%$를 구했고, LDO 예제에서는 $P_D=0.85\ \text{W}$와 $\theta_{JA}=50\ \text{°C/W}$로 $T_J=67.5\ \text{°C}$를 계산했다.
- **다음 탐구:** 출력단 SPICE 모델의 $V_{BE}(T)$·유한 출력저항과 LDO의 전류 제한·thermal foldback 비이상성을 추가해 무신호 바이어스 전력과 과열 보호 개입점을 확인할 것이다.

---

## 참고자료

- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 출력단 설계 기초
- [MIT OCW 6.301 Solid State Circuits](https://ocw.mit.edu/courses/6-301-solid-state-circuits-fall-2010/) — 전원 회로·LDO 설계
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.12~13 — 출력단·전원 회로 전체
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., Ch.11 — 밴드갭·LDO CMOS 구현
- [Texas Instruments Application Note SLVA370: Understanding LDO Dropout Voltage](https://www.ti.com/) — LDO 설계 실전
- [Infineon AN2019-34: SiC MOSFET Short-Circuit Protection](https://www.infineon.com/) — OBC 과전류 보호 설계
