# 반도체와 PN접합

## 학습 목표
- 진성 반도체와 불순물 반도체(N형/P형)의 캐리어 농도를 계산할 수 있다.
- PN접합 형성 원리와 공핍층, 내장전위(built-in potential)를 설명할 수 있다.
- 순방향·역방향 바이어스 조건에서 I-V 특성을 Shockley 방정식으로 해석할 수 있다.
- 소수 캐리어 확산과 드리프트 전류의 역할을 구분할 수 있다.
- EV 파워모듈(SiC/GaN)에서 밴드갭이 항복전압·전도손실에 미치는 영향을 이해한다.

---

## 1. 진성 반도체와 캐리어 농도

진성(intrinsic) 반도체는 불순물이 없는 순수 Si(또는 Ge)로, 열에너지에 의해 전자-정공 쌍이 생성된다.

$$n_i = \sqrt{N_c N_v} \exp\!\left(-\frac{E_g}{2kT}\right)$$

- $n_i$: 진성 캐리어 농도 (Si 300K에서 약 $1.5 \times 10^{10}\ \text{cm}^{-3}$)
- $E_g$: 밴드갭 에너지 (Si = 1.12 eV, SiC = 3.26 eV, GaN = 3.4 eV)
- $k$: Boltzmann 상수 ($8.617 \times 10^{-5}\ \text{eV/K}$)

> **EV 실무 포인트:** SiC의 밴드갭($3.26\ \text{eV}$)이 Si(1.12 eV)의 약 3배이므로 진성 캐리어 농도가 극히 낮다 → 고온(150°C 이상)에서도 누설전류가 작아 OBC 스위칭 소자로 유리하다.

---

## 2. 불순물 반도체 (도핑)

### N형 (도너 불순물, e.g. 인 P)

$$n_0 \approx N_D, \quad p_0 = \frac{n_i^2}{N_D}$$

### P형 (억셉터 불순물, e.g. 붕소 B)

$$p_0 \approx N_A, \quad n_0 = \frac{n_i^2}{N_A}$$

- **질량 작용 법칙:** $n_0 p_0 = n_i^2$ (열평형 상태에서 항상 성립)

---

## 3. PN접합 형성과 공핍층

P형과 N형을 접합하면 농도 기울기에 의해 캐리어가 확산한다.

1. 정공이 N쪽으로, 전자가 P쪽으로 확산
2. 접합 근방에서 이온화된 고정 전하 노출 → **공핍층(depletion region)** 형성
3. 내장 전기장 $\mathcal{E}$가 확산을 억제 → 열평형 달성

$$V_{bi} = \frac{kT}{q}\ln\!\left(\frac{N_A N_D}{n_i^2}\right)$$

Si 예시: $N_A = 10^{17}\ \text{cm}^{-3}$, $N_D = 10^{16}\ \text{cm}^{-3}$, $T=300\text{K}$

$$V_{bi} = 0.026\ln\!\left(\frac{10^{17}\times 10^{16}}{(1.5\times10^{10})^2}\right) \approx 0.026 \times 30.8 \approx 0.80\ \text{V}$$

공핍층 폭:

$$W = x_p + x_n = \sqrt{\frac{2\varepsilon_s}{q}\left(\frac{1}{N_A}+\frac{1}{N_D}\right)V_{bi}}$$

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 3.14.

---

## 4. 순방향·역방향 바이어스 I-V 특성

**Shockley 다이오드 방정식:**

$$I_D = I_S\!\left[\exp\!\left(\frac{V_D}{nV_T}\right) - 1\right]$$

- $I_S$: 포화전류 ($10^{-12}\ \text{A}$ ~ $10^{-15}\ \text{A}$ 수준)
- $n$: 이상 계수(ideality factor), 일반적으로 $1 \leq n \leq 2$
- $V_T = kT/q \approx 26\ \text{mV}$ (300K)

| 바이어스 조건 | 결과 |
|---|---|
| 순방향 ($V_D > 0$) | 공핍층 감소, 확산전류 지수적 증가 |
| 역방향 ($V_D < 0$) | 공핍층 확대, 전류 $\approx -I_S$ |
| 역방향 항복 | 제너 또는 애벌런시 항복 |

---

## 5. 계산 예제

**문제:** Si PN접합에서 $I_S = 1\ \text{nA}$, $n=1$, $T=300\text{K}$. $V_D = 0.6\ \text{V}$ 일 때 다이오드 전류를 구하라.

$$I_D = 1\times10^{-9}\left[\exp\!\left(\frac{0.6}{0.026}\right) - 1\right]$$

$$= 1\times10^{-9}\left[e^{23.08} - 1\right]$$

$$\approx 1\times10^{-9} \times 1.07\times10^{10} \approx 10.7\ \text{mA}$$

> $V_D$를 $0.7\ \text{V}$로 올리면 $I_D \approx 290\ \text{mA}$로 약 27배 증가 — 전압 10mV 변화의 민감도를 확인할 수 있다.

---

## 학습·검증 기록

- **핵심 정리:** 열평형의 $n_0p_0=n_i^2$에서 출발해 도핑 농도가 내장전위와 공핍층 폭을 정하고, 바이어스가 그 장벽을 바꾸면서 확산·드리프트 전류의 균형을 이동시킨다고 정리했다.
- **확인 근거:** 제시된 $N_A=10^{17}$, $N_D=10^{16}\ \text{cm}^{-3}$와 $n_i=1.5\times10^{10}\ \text{cm}^{-3}$를 내장전위 식에 대입하면 $V_{bi}\approx0.76\ \text{V}$이며, 질량 작용 법칙과 Shockley 식은 도핑에 따른 소수 캐리어 농도와 순방향 전압에 대한 전류의 지수 의존성을 보여 준다.
- **다음 탐구:** 다이오드 SPICE 모델의 `IS`, `N`, `CJ0`, `M`, `BV`를 바꾸어 온도와 역바이어스에 따른 누설전류·접합용량·항복 특성이 이상식에서 얼마나 벗어나는지 확인할 것이다.

---

## 참고자료

- [MIT OCW 6.012 Microelectronic Devices and Circuits](https://ocw.mit.edu/courses/6-012-microelectronic-devices-and-circuits-fall-2005/) — PN접합 에너지 밴드, 공핍층 수치 유도
- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 다이오드 모델 실습 중심
- [OpenStax University Physics Vol.3 Ch.9](https://openstax.org/books/university-physics-volume-3/pages/9-introduction) — 반도체 물리 기초, 무료 열람
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.3 — PN접합 정량 유도의 표준 교재
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., Ch.2 — 소신호 모델로의 연결
