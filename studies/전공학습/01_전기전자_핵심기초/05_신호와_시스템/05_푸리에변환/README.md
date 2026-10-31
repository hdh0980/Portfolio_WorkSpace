# 푸리에 변환

## 1. 연속 푸리에 변환 정의

### 1.1 정방향 (Analysis)

$$X(j\omega) = \mathcal{F}\{x(t)\} = \int_{-\infty}^{\infty} x(t)\,e^{-j\omega t}\,dt$$

### 1.2 역방향 (Synthesis)

$$x(t) = \mathcal{F}^{-1}\{X(j\omega)\} = \frac{1}{2\pi}\int_{-\infty}^{\infty} X(j\omega)\,e^{j\omega t}\,d\omega$$

> 주파수 $f$ 표기(Hz): $X(f) = \int x(t)e^{-j2\pi ft}dt$, $x(t)=\int X(f)e^{j2\pi ft}df$ (인수 $2\pi$ 없음)

### 1.3 수렴 조건 (Dirichlet 조건)

- $x(t)$가 절대적분 가능: $\int_{-\infty}^{\infty}|x(t)|dt < \infty$
- 유한 구간에서 극값 유한, 불연속점 유한
- (일반화: 주기 신호·임펄스 포함 위해 분포로 확장)

---

## 2. 주요 변환쌍

| 시간 신호 $x(t)$ | 스펙트럼 $X(j\omega)$ |
|-----------------|----------------------|
| $\delta(t)$ | $1$ |
| $1$ | $2\pi\,\delta(\omega)$ |
| $u(t)$ | $\frac{1}{j\omega}+\pi\delta(\omega)$ |
| $e^{-at}u(t)$, $a>0$ | $\frac{1}{a+j\omega}$ |
| $e^{-a|t|}$, $a>0$ | $\frac{2a}{a^2+\omega^2}$ |
| $\text{rect}(t/\tau)$ | $\tau\,\text{sinc}\!\left(\frac{\omega\tau}{2\pi}\right)$ |
| $\cos(\omega_0 t)$ | $\pi[\delta(\omega-\omega_0)+\delta(\omega+\omega_0)]$ |
| $\sin(\omega_0 t)$ | $\frac{\pi}{j}[\delta(\omega-\omega_0)-\delta(\omega+\omega_0)]$ |
| $e^{j\omega_0 t}$ | $2\pi\,\delta(\omega-\omega_0)$ |

---

## 3. 주요 성질

| 성질 | 시간 영역 | 주파수 영역 |
|------|---------|------------|
| 선형성 | $\alpha x_1+\beta x_2$ | $\alpha X_1+\beta X_2$ |
| 시간 이동 | $x(t-t_0)$ | $e^{-j\omega t_0}X(j\omega)$ |
| 주파수 이동 | $x(t)e^{j\omega_0 t}$ | $X(j(\omega-\omega_0))$ |
| 시간 스케일 | $x(at)$ | $\frac{1}{|a|}X\!\left(\frac{j\omega}{a}\right)$ |
| 컨볼루션 | $x(t)*h(t)$ | $X(j\omega)\cdot H(j\omega)$ |
| 곱셈 | $x(t)\cdot h(t)$ | $\frac{1}{2\pi}X(j\omega)*H(j\omega)$ |
| 시간 미분 | $\frac{d^n}{dt^n}x(t)$ | $(j\omega)^n X(j\omega)$ |
| 시간 적분 | $\int_{-\infty}^t x(\tau)d\tau$ | $\frac{X(j\omega)}{j\omega}+\pi X(0)\delta(\omega)$ |
| 쌍대성 | $X(jt)$ | $2\pi\,x(-\omega)$ |
| 켤레 대칭 | $x(t)$ 실수 | $X(-j\omega)=X^*(j\omega)$ |

---

## 4. Parseval 정리 (에너지 보존)

$$E = \int_{-\infty}^{\infty}|x(t)|^2\,dt = \frac{1}{2\pi}\int_{-\infty}^{\infty}|X(j\omega)|^2\,d\omega$$

**에너지 스펙트럼 밀도 (ESD):**

$$S_{xx}(\omega) = |X(j\omega)|^2 \quad [\text{J/(rad/s)}]$$

$S_{xx}(\omega)$는 주파수 성분별 에너지 분포를 나타낸다.

---

## 5. LTI 시스템에서의 푸리에 변환

컨볼루션 성질에 의해:

$$y(t) = x(t)*h(t) \xrightarrow{\mathcal{F}} Y(j\omega) = X(j\omega)\cdot H(j\omega)$$

따라서 **주파수응답** $H(j\omega)$:

$$H(j\omega) = \frac{Y(j\omega)}{X(j\omega)} = \mathcal{F}\{h(t)\}$$

크기응답: $|H(j\omega)|$ → 이득(gain)
위상응답: $\angle H(j\omega)$ → 위상 지연

---

## 6. 계산 예제

### 예제 1 — 단방향 지수 신호

$x(t) = e^{-3t}u(t)$의 푸리에 변환:

$$X(j\omega) = \int_0^{\infty} e^{-3t}e^{-j\omega t}dt = \int_0^{\infty} e^{-(3+j\omega)t}dt = \frac{1}{3+j\omega}$$

$$|X(j\omega)| = \frac{1}{\sqrt{9+\omega^2}}, \quad \angle X = -\arctan\!\left(\frac{\omega}{3}\right)$$

**ESD:**

$$S_{xx}(\omega) = \frac{1}{9+\omega^2}$$

**에너지 검증 (Parseval):**

$$E = \int_0^\infty e^{-6t}dt = \frac{1}{6}$$

$$\frac{1}{2\pi}\int_{-\infty}^\infty \frac{d\omega}{9+\omega^2} = \frac{1}{2\pi}\cdot\frac{\pi}{3} = \frac{1}{6}$$

### 예제 2 — 시간 이동 성질 적용

$y(t) = e^{-3(t-2)}u(t-2)$ 의 스펙트럼:

$$Y(j\omega) = e^{-j2\omega}\cdot\frac{1}{3+j\omega}$$

위상만 $-2\omega$ 추가 (크기응답 불변).

### 예제 3 — rect 함수와 sinc

$x(t) = \text{rect}(t/4)$ (폭 4의 게이트 함수):

$$X(j\omega) = 4\,\text{sinc}\!\left(\frac{2\omega}{\pi}\right) = \frac{4\sin(2\omega)}{2\omega} = \frac{2\sin(2\omega)}{\omega}$$

첫 번째 영점: $2\omega = \pi$ → $\omega = \pi/2$ (rad/s), 즉 $f = 1/4$ Hz로 펄스 폭(4 s)의 역수다.

---

## 메모

$e^{-3t}u(t)\leftrightarrow 1/(3+j\omega)$에서 Parseval 양변이 모두 $1/6$로 맞았다. 2초 지연하면 크기는 그대로고 $e^{-j2\omega}$만 곱해진다.
같은 신호를 시간 미분해서 직접 변환한 결과가 $j\omega X(j\omega)$와 같은지 비교해 볼 것.

---

## 참고자료

- [MIT OCW 6.003 Lecture 7–9 — Fourier Transform](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — 변환쌍, 성질, LTI 해석
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 4](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — 연속 푸리에 변환 이론
- [MathWorks — `fft` and Spectral Analysis](https://www.mathworks.com/help/matlab/ref/fft.html) — MATLAB FFT와 ESD 계산
