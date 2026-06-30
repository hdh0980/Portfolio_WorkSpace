# LTI 시스템과 컨볼루션

## 학습 목표
- 임펄스응답 $h(t)$가 LTI 시스템을 완전히 기술함을 증명 과정으로 이해한다.
- 연속·이산 컨볼루션 적분/합을 직접 계산(그래픽·해석적)할 수 있다.
- 컨볼루션의 교환·결합·분배 법칙을 이용해 복합 시스템을 분석할 수 있다.
- 인과성과 BIBO 안정성을 $h(t)$ 성질로 판별할 수 있다.
- 컨볼루션과 주파수 영역 곱셈의 관계를 설명할 수 있다.

---

## 1. 임펄스응답 (Impulse Response)

LTI 시스템에 단위임펄스 $\delta(t)$를 입력했을 때의 출력을 **임펄스응답** $h(t)$라 한다.

$$\delta(t) \xrightarrow{\mathcal{H}} h(t)$$

임의 신호 $x(t)$를 임펄스의 선형결합으로 표현하면:

$$x(t) = \int_{-\infty}^{\infty} x(\tau)\,\delta(t-\tau)\,d\tau$$

LTI의 선형성 + 시불변성을 적용하면:

$$y(t) = \int_{-\infty}^{\infty} x(\tau)\,h(t-\tau)\,d\tau = x(t) * h(t)$$

즉 LTI 시스템의 출력은 입력과 임펄스응답의 **컨볼루션**이다.

---

## 2. 연속시간 컨볼루션 (CT Convolution)

$$y(t) = x(t) * h(t) = \int_{-\infty}^{\infty} x(\tau)\,h(t-\tau)\,d\tau$$

### 2.1 그래픽 계산 4단계

1. **반전(Flip):** $h(\tau) \to h(-\tau)$
2. **이동(Shift):** $h(-\tau) \to h(t-\tau)$ ($t$를 매개변수로 슬라이드)
3. **곱(Multiply):** $x(\tau) \cdot h(t-\tau)$
4. **적분(Integrate):** $\tau$에 대해 $(-\infty, \infty)$ 적분

### 2.2 주요 성질

| 성질 | 수식 |
|------|------|
| 교환 | $x * h = h * x$ |
| 결합 | $(x * h_1) * h_2 = x * (h_1 * h_2)$ |
| 분배 | $x * (h_1 + h_2) = x*h_1 + x*h_2$ |
| 임펄스 항등원 | $x(t) * \delta(t) = x(t)$ |
| 이동 | $x(t) * \delta(t-t_0) = x(t-t_0)$ |

---

## 3. 이산시간 컨볼루션 (DT Convolution)

$$y[n] = x[n] * h[n] = \sum_{k=-\infty}^{\infty} x[k]\,h[n-k]$$

임펄스 분해:

$$x[n] = \sum_{k=-\infty}^{\infty} x[k]\,\delta[n-k] \xrightarrow{\mathcal{H}} y[n] = \sum_{k=-\infty}^{\infty} x[k]\,h[n-k]$$

---

## 4. 인과성과 안정성 조건 (h 기반)

### 인과성

$$h(t) = 0, \quad t < 0 \quad \Leftrightarrow \quad \text{인과 LTI 시스템}$$

이산: $h[n] = 0, \; n < 0$

### BIBO 안정성

$$\int_{-\infty}^{\infty} |h(t)|\,dt < \infty \quad \Leftrightarrow \quad \text{BIBO 안정}$$

이산: $\sum_{n=-\infty}^{\infty}|h[n]| < \infty$

### 결합 시스템

$$\text{직렬(cascade)}: h(t) = h_1(t) * h_2(t)$$
$$\text{병렬(parallel)}: h(t) = h_1(t) + h_2(t)$$

---

## 5. 계산 예제

### 예제 1 — 해석적 CT 컨볼루션

$x(t) = e^{-2t}u(t)$, $h(t) = e^{-t}u(t)$ 일 때 $y(t) = x(t)*h(t)$.

두 신호 모두 $t \geq 0$에서만 0이 아니므로:

$$y(t) = \int_0^t e^{-2\tau}\,e^{-(t-\tau)}\,d\tau = e^{-t}\int_0^t e^{-\tau}\,d\tau = e^{-t}(1 - e^{-t}) = e^{-t} - e^{-2t}, \quad t \geq 0$$

$$\boxed{y(t) = (e^{-t} - e^{-2t})\,u(t)}$$

### 예제 2 — 이산 컨볼루션 (표 계산)

$x[n] = \{1, 2, 3\}$ (n=0,1,2), $h[n] = \{1, -1\}$ (n=0,1)

컨볼루션 결과 길이: $(3)+(2)-1=4$

$$y[n] = \{1\cdot1,\; 2\cdot1+1\cdot(-1),\; 3\cdot1+2\cdot(-1),\; 3\cdot(-1)\}$$
$$= \{1,\; 1,\; 1,\; -3\}, \quad n = 0,1,2,3$$

검산: $y[0]=1$, $y[1]=2-1=1$, $y[2]=3-2=1$, $y[3]=-3$ ✓

유한 길이 시퀀스의 컨볼루션 길이: $L_y = L_x + L_h - 1$

### 예제 3 — 안정성 판별

$h(t) = e^{-5t}u(t)$:

$$\int_0^\infty e^{-5t}\,dt = \frac{1}{5} < \infty \quad \Rightarrow \text{ BIBO 안정}$$

$h(t) = u(t)$ (적분기):

$$\int_0^\infty 1\,dt = \infty \quad \Rightarrow \text{ BIBO 불안정}$$

---

## 학습·검증 기록

- **핵심 정리:** LTI 시스템의 출력은 입력과 임펄스응답의 컨볼루션이며, 적분·합의 겹침 구간과 임펄스응답의 절대적분 가능 여부가 각각 출력 형태와 BIBO 안정성을 결정한다.
- **확인 근거:** $e^{-2t}u(t)*e^{-t}u(t)$의 적분 구간을 $0\leq\tau\leq t$로 잡아 $(e^{-t}-e^{-2t})u(t)$를 얻었고, $\{1,2,3\}*\{1,-1\}$의 이산 컨볼루션은 길이 4의 $\{1,1,1,-3\}$이 되었다.
- **다음 탐구:** 폭이 다른 두 직사각 펄스를 뒤집고 이동시키며 겹침 길이를 구해, 출력이 구간별 직선으로 바뀌는 연속시간 컨볼루션을 직접 유도할 것이다.

---

## 참고자료

- [MIT OCW 6.003 Lecture 3 — Convolution](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — 그래픽 컨볼루션, LTI 시스템 표현
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 2](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — 컨볼루션 전체 이론
- [MathWorks — `conv` and `filter` functions](https://www.mathworks.com/help/matlab/ref/conv.html) — MATLAB 이산 컨볼루션 구현
