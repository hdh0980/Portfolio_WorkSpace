# 신호의 표현과 분류

## 학습 목표
- 연속시간(CT)과 이산시간(DT) 신호의 차이를 정의하고 수학적으로 표현할 수 있다.
- 주기·비주기 신호를 판별하고 주기를 계산할 수 있다.
- 에너지 신호와 전력 신호를 구분하고 값을 계산할 수 있다.
- 단위계단·단위임펄스·지수·정현파 기본 신호를 수식으로 쓰고 특성을 설명할 수 있다.
- 임의 신호를 우함수와 기함수 성분으로 분해할 수 있다.

---

## 1. 연속시간 vs. 이산시간 신호

| 구분 | 연속시간 (Continuous-Time) | 이산시간 (Discrete-Time) |
|------|--------------------------|------------------------|
| 변수 | $t \in \mathbb{R}$ | $n \in \mathbb{Z}$ |
| 표기 | $x(t)$ | $x[n]$ |
| 예시 | 아날로그 전류·전압 | ADC 샘플 후 디지털값 |

연속시간 신호는 모든 실수 시각에서 정의되고, 이산시간 신호는 정수 인덱스 $n$에서만 정의된다.

---

## 2. 주기 신호와 비주기 신호

### 2.1 연속시간 주기 신호

$$x(t) = x(t + T), \quad \forall t$$

기본 주기(fundamental period) $T_0$는 위 조건을 만족하는 가장 작은 양수 $T$이다.

### 2.2 이산시간 주기 신호

$$x[n] = x[n + N], \quad \forall n, \; N \in \mathbb{Z}^+$$

**주의:** 이산 정현파 $x[n] = \cos(\omega_0 n)$이 주기적이려면 $\frac{2\pi}{\omega_0}$가 **유리수**여야 한다.

### 2.3 예제 — 합성 신호의 주기

$$x(t) = \cos(2\pi \cdot 3t) + \cos(2\pi \cdot 5t)$$

- $T_1 = 1/3$, $T_2 = 1/5$
- 기본 주기: $T_0 = \text{lcm}(1/3,\, 1/5) = 1$ (s)

---

## 3. 에너지 신호와 전력 신호

### 에너지 (Energy)

$$E = \int_{-\infty}^{\infty} |x(t)|^2 \, dt \quad (\text{CT}), \qquad E = \sum_{n=-\infty}^{\infty} |x[n]|^2 \quad (\text{DT})$$

### 평균 전력 (Average Power)

$$P = \lim_{T \to \infty} \frac{1}{2T} \int_{-T}^{T} |x(t)|^2 \, dt$$

| 구분 | 조건 | 예시 |
|------|------|------|
| 에너지 신호 | $0 < E < \infty$, $P = 0$ | 지수 감쇠 $e^{-at}u(t)$ |
| 전력 신호 | $P > 0$, $E = \infty$ | 정현파, 단위계단 |
| 둘 다 아님 | $E = \infty$, $P = \infty$ | 선형 증가 $x(t)=t$ |

---

## 4. 기본 신호 (Elementary Signals)

### 4.1 단위계단 함수 (Unit Step)

$$u(t) = \begin{cases} 1, & t \geq 0 \\ 0, & t < 0 \end{cases}$$

이산시간: $u[n] = \begin{cases} 1, & n \geq 0 \\ 0, & n < 0 \end{cases}$

### 4.2 단위임펄스 함수 (Unit Impulse / Dirac Delta)

$$\int_{-\infty}^{\infty} \delta(t) \, dt = 1, \qquad \delta(t) = 0 \; (t \neq 0)$$

**체거름(sifting) 성질:**

$$\int_{-\infty}^{\infty} x(t)\,\delta(t - t_0) \, dt = x(t_0)$$

이산 임펄스: $\delta[n] = \begin{cases} 1, & n=0 \\ 0, & n \neq 0 \end{cases}$

관계: $u(t) = \int_{-\infty}^{t} \delta(\tau)\,d\tau$, $\delta(t) = \dfrac{du(t)}{dt}$

### 4.3 실지수 신호

$$x(t) = C e^{at}, \quad a, C \in \mathbb{R}$$

- $a < 0$: 감쇠 (EV OBC 전류 루프 과도응답)
- $a > 0$: 발산 (불안정)
- $a = 0$: 상수

### 4.4 복소지수와 정현파

$$x(t) = e^{j\omega_0 t} = \cos(\omega_0 t) + j\sin(\omega_0 t) \quad \text{(Euler)}$$

$$x(t) = A\cos(\omega_0 t + \phi)$$

- $\omega_0 = 2\pi f_0$: 각주파수 [rad/s]
- $T_0 = 2\pi/\omega_0$: 기본 주기

---

## 5. 우함수·기함수 분해 (Even/Odd Decomposition)

모든 신호는 유일하게 우함수($\mathcal{E}$)와 기함수($\mathcal{O}$)로 분해된다.

$$x(t) = \underbrace{\frac{x(t)+x(-t)}{2}}_{\mathcal{E}\{x(t)\}} + \underbrace{\frac{x(t)-x(-t)}{2}}_{\mathcal{O}\{x(t)\}}$$

**성질:**
- 우함수: $x_e(-t) = x_e(t)$ (y축 대칭)
- 기함수: $x_o(-t) = -x_o(t)$ (원점 대칭)
- 우×우 = 우, 기×기 = 우, 우×기 = 기

---

## 6. 계산 예제

### 예제 1 — 에너지 계산

신호 $x(t) = 3e^{-2t}u(t)$의 에너지를 구하라.

$$E = \int_0^{\infty} |3e^{-2t}|^2 \, dt = 9\int_0^{\infty} e^{-4t} \, dt = 9 \cdot \frac{1}{4} = \boxed{2.25 \text{ J}}$$

### 예제 2 — 우함수/기함수 분해

$x(t) = e^{-t}u(t)$를 분해하라.

- $x(-t) = e^{t}u(-t)$
- $x_e(t) = \frac{e^{-t}u(t) + e^{t}u(-t)}{2} = \frac{1}{2}e^{-|t|}$
- $x_o(t) = \frac{e^{-t}u(t) - e^{t}u(-t)}{2} = \frac{1}{2}e^{-|t|}\text{sgn}(t)$

### 예제 3 — 이산 주기 판별

$x[n] = \cos\!\left(\dfrac{3\pi}{7}n\right)$의 기본 주기를 구하라.

$$\omega_0 = \frac{3\pi}{7}, \quad \frac{2\pi}{\omega_0} = \frac{14}{3} \notin \mathbb{Z}$$

가장 작은 양수 정수 $N$: $N \cdot \dfrac{3\pi}{7} = 2\pi k$ → $N = 14, k = 3$. 기본 주기 $N_0 = 14$.

---

## 7. 실무 연결과 주의점

- **EV OBC 전류 센서 출력**은 연속시간 아날로그 신호 $i_L(t)$이다. ADC를 통해 이산시간 신호 $i_L[n]$으로 변환되며, 이 순간부터 샘플링 이론(단원 07)이 적용된다.
- **임펄스 체거름 성질**은 컨볼루션 계산(단원 03)의 핵심 도구이자, 임펄스응답 측정 원리이다.
- **에너지/전력 신호 구분**은 안정도 분석에서 직결된다. BIBO 안정 시스템의 출력은 유한 전력 입력에 대해 유한 전력을 가진다.
- 이산 정현파의 주기성 조건($2\pi/\omega_0 \in \mathbb{Q}$)을 놓치면 DSP 제어기의 주기 판단 오류가 발생한다.

---

## 8. 자가 점검

1. $x(t) = e^{-3t}u(t)$는 에너지 신호인가, 전력 신호인가? 에너지 값은?
2. $x[n] = \cos(0.5n)$은 주기 신호인가?
3. $x(t) = t \cdot u(t)$의 우함수 성분 $x_e(t)$를 구하라.

<details><summary>정답</summary>

1. 에너지 신호. $E = \int_0^\infty e^{-6t}dt = 1/6$ J.
2. 비주기. $2\pi/0.5 = 4\pi$는 무리수이므로 주기 신호가 아니다.
3. $x_e(t) = \frac{tu(t) + (-t)u(-t)}{2} = \frac{t\,u(t) - t\,u(-t)}{2} = \frac{|t|}{2}$

</details>

---

## 참고자료

- [MIT OCW 6.003 Lecture 1 — Signals and Systems](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — 연속·이산 신호 정의, 기본 신호
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 1](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — 표준 교재, 단원 전반
- [MathWorks — `heaviside` and `dirac` in MATLAB Symbolic Toolbox](https://www.mathworks.com/help/symbolic/heaviside.html) — 단위계단·임펄스 MATLAB 심볼릭 계산
