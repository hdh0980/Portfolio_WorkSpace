# 시스템의 성질

## 학습 목표
- 선형성, 시불변성, 인과성, BIBO 안정성, 기억성, 가역성 각각의 정의를 수식으로 쓸 수 있다.
- 주어진 시스템이 각 성질을 만족하는지 반례 또는 증명으로 판별할 수 있다.
- LTI(Linear Time-Invariant) 시스템의 조건을 이해하고 그 중요성을 설명할 수 있다.
- 실제 제어 시스템(EV OBC 전류 루프)에서 각 성질이 갖는 의미를 연결할 수 있다.
- 성질 판별 절차를 체계적으로 적용할 수 있다.

---

## 1. 선형성 (Linearity)

시스템 $\mathcal{H}$가 선형이면 **중첩 원리(superposition)**가 성립한다.

$$\mathcal{H}\{\alpha x_1(t) + \beta x_2(t)\} = \alpha \mathcal{H}\{x_1(t)\} + \beta \mathcal{H}\{x_2(t)\}$$

두 조건으로 분리된다.

| 조건 | 수식 |
|------|------|
| 균질성 (Homogeneity) | $\mathcal{H}\{\alpha x\} = \alpha \mathcal{H}\{x\}$ |
| 가산성 (Additivity) | $\mathcal{H}\{x_1 + x_2\} = \mathcal{H}\{x_1\} + \mathcal{H}\{x_2\}$ |

**비선형 판별법:** $y = x^2$이면 $\mathcal{H}\{2x\} = 4x^2 \neq 2x^2 = 2\mathcal{H}\{x\}$ → 비선형.

---

## 2. 시불변성 (Time-Invariance)

입력을 시간 이동하면 출력도 동일하게 이동한다.

$$x(t) \to y(t) \implies x(t - t_0) \to y(t - t_0), \quad \forall t_0$$

**판별 절차:**

1. $y_1(t) = \mathcal{H}\{x(t-t_0)\}$ 계산
2. $y_2(t) = y(t-t_0)$ 계산 ($y(t)$에서 $t \to t-t_0$)
3. $y_1 = y_2$이면 시불변, 아니면 시변(time-varying)

**예:** $y(t) = x(t)\cos(\omega_c t)$ — 시변 (변조기).

---

## 3. 인과성 (Causality)

출력이 **현재 및 과거** 입력에만 의존한다.

$$y(t) \text{ depends only on } x(\tau), \; \tau \leq t$$

- 비인과(non-causal): $y(t) = x(t+1)$ (미래 입력 사용)
- 이산 인과: $y[n]$이 $x[n], x[n-1], \ldots$에만 의존

실시간 제어 시스템은 반드시 인과적이어야 한다.

---

## 4. BIBO 안정성 (Bounded Input, Bounded Output Stability)

유계(bounded) 입력에 유계 출력이 나오면 BIBO 안정.

$$|x(t)| \leq M_x < \infty \implies |y(t)| \leq M_y < \infty$$

LTI 시스템에서 BIBO 안정 ↔ 임펄스응답이 절대적분 유한:

$$\int_{-\infty}^{\infty} |h(t)| \, dt < \infty$$

이산 LTI: $\sum_{n=-\infty}^{\infty} |h[n]| < \infty$

---

## 5. 기억성 (Memory)

| 구분 | 정의 | 예 |
|------|------|----|
| 무기억(Memoryless) | $y(t)$가 오직 $x(t)$에만 의존 | $y(t) = 2x(t)$ |
| 기억(Memory) | $y(t)$가 과거/미래 $x$에도 의존 | $y(t) = \int_{-\infty}^{t}x(\tau)d\tau$ |

모든 인과 기억 시스템은 과거 정보를 저장한다 (커패시터, 적분기, 지연).

---

## 6. 가역성 (Invertibility)

서로 다른 입력이 서로 다른 출력을 만들 때 가역.

$$x_1 \neq x_2 \implies \mathcal{H}\{x_1\} \neq \mathcal{H}\{x_2\}$$

역시스템 $\mathcal{H}^{-1}$가 존재하면 $\mathcal{H}^{-1}\{\mathcal{H}\{x\}\} = x$.

예:
- $y = 2x$ → 가역 ($x = y/2$)
- $y = x^2$ → 비가역 ($x=+3$과 $x=-3$이 같은 출력)

---

## 7. LTI 시스템의 의의

**선형(L) + 시불변(TI)** 두 조건을 동시에 만족하는 시스템.

LTI 시스템의 핵심 특성:
- 임펄스응답 $h(t)$ 하나로 완전히 기술됨
- 출력 = 입력 * 임펄스응답 (컨볼루션, 단원 03)
- 주파수 영역 분석 (푸리에/라플라스/Z변환)이 유효함

$$y(t) = x(t) * h(t) = \int_{-\infty}^{\infty} x(\tau) h(t-\tau) \, d\tau$$

---

## 8. 계산 예제

### 예제 1 — 선형·시불변 판별

$\mathcal{H}\{x[n]\} = x[2n]$ (시간 압축 시스템)

**선형성 확인:**
$$\mathcal{H}\{\alpha x_1[n] + \beta x_2[n]\} = \alpha x_1[2n] + \beta x_2[2n] = \alpha y_1[n] + \beta y_2[n] \checkmark$$

**시불변성 확인:**
- $y_1[n] = \mathcal{H}\{x[n-n_0]\} = x[2n - n_0]$
- $y_2[n] = y[n - n_0] = x[2(n-n_0)] = x[2n - 2n_0]$
- $y_1 \neq y_2$ (단 $n_0 \neq 0$) → **시변(TV)** ✗

### 예제 2 — BIBO 안정성 판별

$h(t) = e^{-3t}u(t)$인 LTI 시스템:

$$\int_{-\infty}^{\infty}|h(t)|dt = \int_0^{\infty} e^{-3t}dt = \frac{1}{3} < \infty \quad \Rightarrow \text{ BIBO 안정}$$

$h(t) = e^{3t}u(t)$이면:

$$\int_0^{\infty} e^{3t}dt = \infty \quad \Rightarrow \text{ BIBO 불안정}$$

---

## 학습·검증 기록

- **핵심 정리:** 시스템은 선형성·시불변성·인과성·메모리 유무·BIBO 안정성을 서로 독립된 정의로 검사해야 하며, 일부 성질만 만족해도 LTI라고 부를 수는 없다.
- **확인 근거:** $\mathcal{H}\{x[n]\}=x[2n]$은 중첩 원리를 만족하지만 입력 이동과 출력 이동의 결과가 각각 $x[2n-n_0]$, $x[2n-2n_0]$로 달라 시변 시스템이고, $h(t)=e^{-3t}u(t)$는 절대적분이 $1/3$이므로 BIBO 안정이다.
- **다음 탐구:** $y[n]=x[n]+a\,x[n-1]$을 대상으로 선형성·시불변성·인과성·메모리·BIBO 안정성을 정의에서 하나씩 판정할 것이다.

---

## 참고자료

- [MIT OCW 6.003 Lecture 2 — System Properties](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — 선형성·시불변성·인과성 판별
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 1.6](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — 시스템 성질 정리
- [MathWorks — Linear System Identification](https://www.mathworks.com/help/ident/ug/what-are-linear-models.html) — MATLAB에서 LTI 가정 검증 방법
