# 주파수응답과 피드백

## 학습 목표
- 단극 시스템의 주파수응답과 보드 선도를 손으로 그릴 수 있다.
- 밀러 효과가 증폭기 대역폭을 제한하는 원리를 수식으로 이해한다.
- 부귀환의 4가지 종류(직렬-병렬, 병렬-직렬 등)를 판별할 수 있다.
- 이득여유(GM)와 위상여유(PM)로 피드백 시스템의 안정도를 판별할 수 있다.
- 부귀환이 이득·대역폭·입출력 임피던스에 미치는 영향을 정량적으로 설명할 수 있다.

---

## 1. 단극 주파수응답

증폭기의 가장 단순한 주파수응답:

$$A(j\omega) = \frac{A_0}{1 + j\omega/\omega_p}$$

- $A_0$: 저주파(DC) 이득
- $\omega_p = 1/(R_{eq}C_{eq})$: 극점(pole) 주파수

**크기(Bode):**

$$|A(j\omega)| \approx \begin{cases} A_0 & \omega \ll \omega_p \\ A_0/\sqrt{2} & \omega = \omega_p \quad(-3\text{ dB 주파수}) \\ A_0 \cdot \omega_p/\omega & \omega \gg \omega_p \quad(-20\text{ dB/dec}) \end{cases}$$

**위상:**

$$\angle A(j\omega) = -\arctan\!\left(\frac{\omega}{\omega_p}\right)$$

$\omega = \omega_p$에서 $-45°$, $\omega = 10\omega_p$에서 $\approx -84°$

---

## 2. 보드 선도 (Bode Plot)

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 10.5.

**두 극점 시스템:**

$$A(j\omega) = \frac{A_0}{(1+j\omega/\omega_{p1})(1+j\omega/\omega_{p2})}$$

총 위상 지연: $-\arctan(\omega/\omega_{p1}) - \arctan(\omega/\omega_{p2})$

**이득-대역폭 곱 (GBW):**

$$GBW = A_0 \cdot f_{p1} = \text{상수}$$

부귀환으로 이득을 줄이면 대역폭이 정확히 비례해 증가.

---

## 3. 밀러 효과

CS 증폭기에서 $C_{gd}$가 입력단 유효 커패시턴스에 미치는 영향:

$$C_{in,Miller} = C_{gs} + C_{gd}(1 - A_v)$$

$A_v = -10$이면:

$$C_{in,Miller} = C_{gs} + 11\,C_{gd}$$

$C_{gd}$가 11배 증폭되어 입력에 붙음 → 입력 극점이 낮은 주파수로 이동 → 대역폭 제한.

**억제 방법:**
- 캐스코드 구조 → $|A_v| \approx 1$로 낮춤
- 공통게이트(CG) 단 → 밀러 효과 없음

---

## 4. 피드백 4종류

| 종류 | 샘플링(출력) | 비교(입력) | 이득 | $R_{in}$ | $R_{out}$ |
|---|---|---|---|---|---|
| 직렬-병렬 (Voltage-Voltage) | 전압 | 직렬 | $A_{vf} = A_v/(1+A_v\beta)$ | 증가 | 감소 |
| 병렬-직렬 (Current-Current) | 전류 | 병렬 | $A_{if} = A_i/(1+A_i\beta)$ | 감소 | 증가 |
| 직렬-직렬 (Transconductance) | 전류 | 직렬 | $G_{mf} = G_m/(1+G_m\beta)$ | 증가 | 증가 |
| 병렬-병렬 (Transresistance) | 전압 | 병렬 | $R_{mf} = R_m/(1+R_m\beta)$ | 감소 | 감소 |

**루프이득:** $T = A\beta$ → $(1+T)$이 모든 특성의 개선 인자.

---

## 5. 피드백의 이득·대역폭·임피던스 영향

부귀환 적용 시 (직렬-병렬 예):

**이득 감소:**

$$A_{vf} = \frac{A_v}{1 + A_v\beta}$$

**대역폭 확장:**

$$f_{3dB,f} = f_{3dB}(1 + A_v\beta)$$

**이득×대역폭 보존:**

$$A_{vf}\cdot f_{3dB,f} = A_v\cdot f_{3dB} = GBW$$

**출력 임피던스 감소:**

$$R_{out,f} = \frac{R_{out}}{1 + A_v\beta}$$

---

## 6. 안정도 — 위상여유와 이득여유

폐루프 시스템은 루프이득 $A(j\omega)\beta$가 $-1$($180°$ 위상 지연에서 크기 1)을 만족하면 발진(불안정).

**위상여유 (Phase Margin, PM):**

$$PM = 180° + \angle A(j\omega_c)\beta \quad (\omega_c: |A\beta|=1 \text{ 주파수})$$

**이득여유 (Gain Margin, GM):**

$$GM = -20\log_{10}|A(j\omega_{180})\beta| \quad (\omega_{180}: \angle A\beta = -180° \text{ 주파수})$$

일반적인 안정 기준:
- PM > 45° (60° 권장)
- GM > 10 dB

> 참고 도식: Razavi, *Design of Analog CMOS Integrated Circuits* 2판, Fig. 9.12.

---

## 7. 계산 예제

**문제:** 두 극점 피드백 시스템.
$A_0 = 1000$, $f_{p1} = 1\ \text{kHz}$, $f_{p2} = 10\ \text{MHz}$, $\beta = 0.1$

**Step 1:** 루프이득 DC값

$$T_0 = A_0\beta = 1000\times0.1 = 100$$

**Step 2:** 폐루프 DC 이득

$$A_{0,f} = \frac{1000}{1+100} = \frac{1000}{101} \approx 9.9$$

**Step 3:** 폐루프 대역폭

$$f_{-3dB,f} = f_{p1}(1+T_0) = 1\text{kHz}\times101 \approx 101\ \text{kHz}$$

**Step 4:** 위상여유 확인 (단위이득 주파수 근사)

단위이득 주파수 $f_c$에서 $|A(jf_c)\beta| = 1$:

$$f_c \approx A_0\beta\cdot f_{p1} = 100\times1\text{kHz} = 100\ \text{kHz}$$

$f_c = 100\ \text{kHz}$에서 $f_{p2} = 10\ \text{MHz}$에 의한 위상 지연:

$$\phi_{p2} = -\arctan\!\left(\frac{100\text{kHz}}{10\text{MHz}}\right) = -\arctan(0.01) \approx -0.57°$$

1극 위상: $-\arctan(100\text{kHz}/1\text{kHz}) \approx -89.4°$

총 위상: $-89.4° - 0.57° \approx -90°$

$$PM = 180° - 90° = 90° \gg 45° \quad \text{충분히 안정}$$

---

## 학습·검증 기록

- **핵심 정리:** 폐루프 이득과 대역폭 변화는 루프이득 $T=A\beta$의 크기로 설명하고, 안정도는 $|T|=1$인 교차 주파수에서 누적 위상을 읽어 PM·GM으로 판정해야 한다.
- **확인 근거:** $A_0=1000$, $\beta=0.1$인 두 극점 예제에서 $T_0=100$, 폐루프 이득 $9.9$, 대역폭 약 $101\ \text{kHz}$를 얻었고, $100\ \text{kHz}$ 교차점의 두 극점 위상을 합쳐 PM 약 $90°$로 계산했다.
- **다음 탐구:** SPICE 루프 모델에 출력 커패시터 ESR 영점, 배선 ESL, 증폭기 지연을 하나씩 추가해 교차 주파수와 PM이 이상적인 두 극점 계산에서 어떻게 이동하는지 확인할 것이다.

---

## 참고자료

- [MIT OCW 6.302 Feedback Systems](https://ocw.mit.edu/courses/6-302-feedback-systems-spring-2007/) — 피드백·안정도 심화
- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 주파수응답 기초
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.10~11 — 주파수응답·피드백 전체
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., Ch.9~12 — 보드 선도·안정도 CMOS 심화
- [Texas Instruments Application Note SLVA302: Stability Analysis of Voltage-Mode Buck Regulator](https://www.ti.com/) — 전력 컨버터 루프 설계 실전
