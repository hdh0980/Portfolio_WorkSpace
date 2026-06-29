# 다이오드 회로

## 학습 목표
- 이상 다이오드 → 단순 모델 → 완전 모델의 계층적 적용 기준을 이해한다.
- 반파·전파 정류 회로의 출력 직류 전압과 PIV를 계산할 수 있다.
- 클리퍼·클램퍼 동작 원리를 시간 영역 파형으로 추적할 수 있다.
- 제너 다이오드를 이용한 전압 조정 회로를 설계할 수 있다.
- SiC/GaN 쇼트키 다이오드의 특성과 OBC 적용 이점을 설명할 수 있다.

---

## 1. 다이오드 모델 계층

### 1-1. 이상 다이오드 모델

순방향이면 단락(Short), 역방향이면 개방(Open).

$$I_D = \begin{cases} \text{임의} & V_D = 0,\ \text{순방향 전류} \\ 0 & V_D < 0 \end{cases}$$

### 1-2. 일정 전압 강하 모델 (단순 모델)

순방향 바이어스 시 $V_D \approx 0.7\ \text{V}$ (Si), $0.3\ \text{V}$ (Ge), $\approx 0\ \text{V}$ (SBD).

### 1-3. 완전 모델 (지수 모델)

$$I_D = I_S\exp\!\left(\frac{V_D}{nV_T}\right)$$

직렬 저항 $r_d$ 포함 시: $V_{아노드} = V_D + I_D r_d$

| 모델 | 정확도 | 적합 상황 |
|---|---|---|
| 이상 | 낮음 | 1차 회로 분석, On/Off 판단 |
| 단순 (0.7V) | 중간 | 대부분의 손계산 |
| 완전 (지수) | 높음 | SPICE 시뮬레이션, 정밀 설계 |

---

## 2. 반파 정류 회로

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 3.22.

입력 $v_s = V_p \sin(\omega t)$ 일 때:

$$v_o = \begin{cases} v_s - 0.7 & v_s > 0.7\ \text{V} \\ 0 & v_s \leq 0.7\ \text{V} \end{cases}$$

평균(직류) 출력 전압:

$$V_{DC} = \frac{V_p - 0.7}{\pi} \approx \frac{V_p}{\pi}\ (\text{단순화})$$

**PIV (Peak Inverse Voltage):** 역방향 시 다이오드 양단 최대 전압

$$PIV = V_p$$

---

## 3. 전파 정류 회로

### 3-1. 브리지 정류 (4-다이오드)

$$V_{DC} = \frac{2(V_p - 2\times0.7)}{\pi} \approx \frac{2V_p}{\pi}$$

$$PIV = V_p$$

(두 다이오드 직렬이므로 $2\times0.7\ \text{V}$ 강하)

### 3-2. 센터탭 정류 (2-다이오드)

$$V_{DC} = \frac{2(V_p - 0.7)}{\pi}$$

$$PIV = 2V_p - 0.7 \approx 2V_p$$

> 브리지 대비 PIV 2배 필요 → 고전압 설계 시 소자 내압 마진 고려 필수.

---

## 4. 클리퍼 (Clipper)

전압 파형의 특정 레벨 이상/이하를 절단.

**양의 클리퍼 (클리핑 레벨 $+L$):**

$$v_o = \begin{cases} L & v_i > L \\ v_i & v_i \leq L \end{cases}$$

직렬 다이오드 + 기준 전압 $V_{ref}$로 구현. $L = V_{ref} + 0.7$.

---

## 5. 클램퍼 (Clamper)

DC 레벨 이동 회로 — 파형 형태는 유지하고 직류 성분을 변화시킴.

**음의 클램퍼 (파형 상단을 0V로 고정):**

캐패시터 $C$가 정(+) 반주기에 $V_p - 0.7$로 충전, 이후 파형 전체가 $-(V_p - 0.7)$ 이동.

$$v_{o,min} \approx -(2V_p - 0.7)$$

---

## 6. 제너 다이오드 전압 조정

제너 항복 전압 $V_Z$에서 안정화.

$$V_{out} = V_Z, \quad I_Z = \frac{V_{in} - V_Z}{R_S} - I_L$$

제너가 동작하려면 $I_Z > I_{Z,min}$ (보통 5~10 mA) 조건 필요.

제너 저항 $r_z$ 포함 시 실제 출력:

$$V_{out} = V_Z + r_z I_Z$$

**라인 레귤레이션:** $\Delta V_{out} / \Delta V_{in} = r_z / (r_z + R_S)$

---

## 7. SiC/GaN 쇼트키 다이오드 (전력전자 연결)

금속-반도체 접합(쇼트키 장벽)을 이용 → 다수 캐리어 소자.

| 특성 | Si PN 다이오드 | SiC SBD | GaN 다이오드 |
|---|---|---|---|
| 순방향 전압 $V_F$ | 0.7 V | 1.3~1.6 V | 1.5~2.0 V |
| 역방향 복구전하 $Q_{rr}$ | 수백 nC | ≈ 0 (용량성만) | ≈ 0 |
| 최대 접합 온도 | 150°C | 175~200°C | 150~175°C |
| 주요 응용 | 범용 | OBC PFC 부스트 정류 | 고주파 LLC |

> **OBC 설계 실무:** PFC 부스트 단의 환류 다이오드를 SiC SBD로 교체하면 $Q_{rr} \approx 0$ 덕분에 스위칭 손실이 50~70% 감소. 단, $V_F$ 자체는 Si보다 높으므로 도통손실 계산을 반드시 병행.

---

## 8. 계산 예제

**문제:** 브리지 정류 회로, $v_s = 170\sin(\omega t)\ \text{V}$ (실효값 120 Vrms), $R_L = 100\ \Omega$, Si 다이오드.

1. 출력 직류 전압:

$$V_{DC} = \frac{2(170 - 2\times0.7)}{\pi} = \frac{2\times168.6}{\pi} \approx \frac{337.2}{3.14} \approx 107.3\ \text{V}$$

2. PIV: $170\ \text{V}$ → 내압 여유 2배 = $340\ \text{V}$ 소자 선정.

3. 출력 리플 전압 ($C = 1000\ \mu\text{F}$, $f = 120\ \text{Hz}$):

$$V_r \approx \frac{V_{DC}}{f \cdot R_L \cdot C} = \frac{107.3}{120 \times 100 \times 10^{-3}} \approx 8.94\ \text{V}_{pp}$$

---

## 9. 실무 연결과 주의점

- **OBC AC-DC PFC 입력단:** EMC 필터 후 브리지 정류 → 부스트 PFC. SiC SBD 병렬 환류 채용 시 역회복 노이즈(ringing) 대폭 감소.
- **PIV 마진:** 서지 과전압(Surge) 및 반사 전압 고려 → 정격 PIV의 1.5~2배 내압 소자 선정.
- **고주파 정류:** LLC 공진 변환기의 동기 정류(SR)는 MOSFET을 다이오드로 활용 → 도통손실 최소화, 게이트드라이버 타이밍(dead-time) 관리 중요.
- **제너 안정화:** 제너 전압은 온도계수가 $V_Z < 5\ \text{V}$이면 음, $V_Z > 5\ \text{V}$이면 양 → 5.1V 제너가 온도 보상에 유리.

---

## 10. 자가 점검

1. 전파 브리지 정류와 센터탭 정류에서 PIV 요구값이 다른 이유는?
2. 클램퍼와 클리퍼의 근본적인 동작 차이는 무엇인가?
3. SiC SBD가 Si PN 다이오드 대비 스위칭 손실을 줄이는 물리적 이유는?

<details><summary>정답</summary>

1. 브리지: 두 다이오드가 역방향 전압을 공유 → 각 PIV = $V_p$. 센터탭: 오프 다이오드 양단에 변압기 전체 전압 + 출력 전압 인가 → PIV ≈ $2V_p$. 동일 변압기 사용 시 브리지의 PIV 요구값이 절반.
2. 클리퍼는 파형의 일부를 잘라냄(진폭 제한), 클램퍼는 파형 형태 유지하면서 직류 레벨을 이동시킴(캐패시터 기반).
3. SiC SBD는 다수 캐리어(전자)만으로 동작 → 역방향 전환 시 소수 캐리어 재결합 없음 → 역방향 복구전류($I_{rr}$)와 복구시간($t_{rr}$)이 거의 0 → 스위칭 손실 $\propto Q_{rr} \cdot V_{bus}$ 급격히 감소.

</details>

---

## 참고자료

- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 다이오드 회로 분석 실습
- [OpenStax University Physics Vol.3 Ch.9](https://openstax.org/books/university-physics-volume-3/pages/9-introduction) — 반도체 다이오드 기초
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.3 — 정류·클리퍼·클램퍼 체계적 유도
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., App.A — 다이오드 물리 배경
- [ON Semiconductor AN-6076: SiC Schottky Diode Application Note](https://www.onsemi.com/) — SiC SBD 실제 스위칭 파형 비교
