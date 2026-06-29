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

## 9. 실무 연결과 주의점

- **EV OBC 전류 루프 PI 제어기**는 LTI 시스템으로 모델링된다. 선형 + 시불변 가정이 성립할 때만 전달함수 $H(s)$와 보드선도(Bode plot)가 유효하다. 포화(saturation) 같은 비선형 요소가 들어오면 LTI 분석이 깨진다.
- **안티-와인드업(anti-windup)** 회로는 적분기 포화 → 비선형 → 시스템 성질이 변함을 다루는 대표적 실무 이슈다.
- **인과성**은 DSP 펌웨어에서 미래 샘플을 볼 수 없다는 제약과 직결된다. 역방향 필터(non-causal)는 오프라인 후처리에서만 사용 가능하다.
- **BIBO 안정** 조건을 확인하려면 폐루프 전달함수 극점이 좌반면(s-domain) 또는 단위원 내부(z-domain)에 있어야 한다 (단원 06, 08과 연계).

---

## 10. 자가 점검

1. 시스템 $y(t) = x(t-3) + x(t+1)$은 선형인가? 인과적인가?
2. $y[n] = x[n] \cdot n$은 시불변인가? 이유를 판별 절차로 보여라.
3. BIBO 안정을 위해 이산 LTI 임펄스응답이 만족해야 할 조건을 쓰라.

<details><summary>정답</summary>

1. 선형 (중첩 성립). 비인과적 — $y(t)$가 미래 입력 $x(t+1)$을 포함한다.
2. 시변. $y_1[n] = x[n-n_0]\cdot n$, $y_2[n]=y[n-n_0]=x[n-n_0]\cdot(n-n_0)$. $y_1 \neq y_2$ (계수 $n$ vs $n-n_0$ 차이).
3. $\sum_{n=-\infty}^{\infty}|h[n]| < \infty$ (절대합 수렴).

</details>

---

## 참고자료

- [MIT OCW 6.003 Lecture 2 — System Properties](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — 선형성·시불변성·인과성 판별
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 1.6](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — 시스템 성질 정리
- [MathWorks — Linear System Identification](https://www.mathworks.com/help/ident/ug/what-are-linear-models.html) — MATLAB에서 LTI 가정 검증 방법
