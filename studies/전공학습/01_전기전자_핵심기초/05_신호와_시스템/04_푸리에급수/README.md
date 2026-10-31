# 푸리에 급수

## 1. 직교함수계 (Orthogonal Function Set)

구간 $[t_0, t_0+T]$에서 두 함수 $\phi_k(t)$, $\phi_n(t)$가 직교:

$$\langle \phi_k, \phi_n \rangle = \int_{t_0}^{t_0+T} \phi_k(t)\,\phi_n^*(t)\,dt = \begin{cases} E_k, & k=n \\ 0, & k \neq n \end{cases}$$

복소지수 $\{e^{jk\omega_0 t}\}_{k \in \mathbb{Z}}$ ($\omega_0 = 2\pi/T$)는 완비 직교계를 이룬다. 이 계 위로 임의 주기 신호를 투영하는 것이 푸리에 급수이다.

---

## 2. 삼각 푸리에 급수 (Trigonometric Form)

주기 $T$의 신호 $x(t)$:

$$x(t) = a_0 + \sum_{n=1}^{\infty} \left[a_n \cos(n\omega_0 t) + b_n \sin(n\omega_0 t)\right]$$

계수 공식:

$$a_0 = \frac{1}{T}\int_{T} x(t)\,dt$$

$$a_n = \frac{2}{T}\int_{T} x(t)\cos(n\omega_0 t)\,dt$$

$$b_n = \frac{2}{T}\int_{T} x(t)\sin(n\omega_0 t)\,dt$$

---

## 3. 복소 푸리에 급수 (Complex Exponential Form)

$$x(t) = \sum_{n=-\infty}^{\infty} c_n \, e^{jn\omega_0 t}$$

$$\boxed{c_n = \frac{1}{T}\int_{T} x(t)\,e^{-jn\omega_0 t}\,dt}$$

삼각 계수와의 관계:

$$c_n = \frac{a_n - jb_n}{2}, \quad c_{-n} = c_n^*, \quad a_0 = c_0$$

---

## 4. Parseval 정리

주기 신호의 평균 전력은 각 고조파 성분의 전력 합과 같다.

$$P = \frac{1}{T}\int_{T}|x(t)|^2\,dt = \sum_{n=-\infty}^{\infty}|c_n|^2$$

즉 신호 전력 = DC 전력 + 각 조화파 전력의 합.

---

## 5. 기본 파형의 스펙트럼

### 5.1 방형파 (Square Wave)

주기 $T$, 진폭 $A$, 듀티 $d = \tau/T$:

$$c_n = \frac{A\tau}{T}\text{sinc}(n d) = Ad\,\text{sinc}(nd), \quad \text{sinc}(x)=\frac{\sin(\pi x)}{\pi x}$$

특수 케이스 ($d=1/2$, 듀티 50%):

$$c_n = \begin{cases} A/2, & n=0 \\ \frac{A}{n\pi}\sin\!\left(\frac{n\pi}{2}\right), & n \neq 0 \end{cases}$$

홀수 $n$만 존재: $c_1 = A/\pi$, $c_3 = -A/(3\pi)$, ...

스펙트럼 포락선이 $1/(n\pi)$로 감쇠 → **1차 고조파가 지배적**.

### 5.2 삼각파 (Triangle Wave)

$c_n$이 $1/n^2$ 감쇠 → 방형파보다 고주파 성분이 빠르게 줄어 부드러운 스펙트럼.

$$c_n = \frac{2A}{n^2\pi^2}\sin^2\!\!\left(\frac{n\pi}{2}\right) \quad (n \neq 0)$$

---

## 6. 깁스 현상 (Gibbs Phenomenon)

불연속점 근방에서 유한 항 푸리에 급수가 약 **9% 오버슈트**를 보이는 현상.

$$\lim_{N \to \infty} \max\left|\sum_{n=-N}^{N} c_n e^{jn\omega_0 t} - x(t)\right|_{\text{discontinuity}} \approx 0.0895A$$

> 참고 도식: Oppenheim & Willsky, *Signals and Systems* 2판, Fig. 3.9.

오버슈트 크기는 $N$ 증가에 무관하게 약 9%로 수렴. 단, 불연속점 외부에서는 $N \to \infty$에서 정확히 수렴한다.

실무에서는 윈도우 함수(Hann, Hamming 등)로 깁스 현상을 완화한다.

---

## 7. 계산 예제

### 예제 — 방형파 푸리에 계수 직접 계산

$x(t)$: 주기 $T=2$, 진폭 $A=1$, $x(t)=1$ for $0 \leq t < 1$, $x(t)=0$ for $1 \leq t < 2$.

$\omega_0 = 2\pi/2 = \pi$, $d = 0.5$.

$$c_0 = \frac{1}{2}\int_0^1 1\,dt = \frac{1}{2}$$

$$c_n = \frac{1}{2}\int_0^1 e^{-jn\pi t}\,dt = \frac{1}{2}\cdot\frac{e^{-jn\pi t}}{-jn\pi}\Bigg|_0^1 = \frac{1-e^{-jn\pi}}{j2n\pi}$$

$n$ 짝수 ($n \neq 0$): $e^{-jn\pi}=1$ → $c_n = 0$

$n$ 홀수: $e^{-jn\pi}=-1$ → $c_n = \dfrac{2}{j2n\pi} = \dfrac{1}{jn\pi}$

결과:
$$c_1 = \frac{1}{j\pi} \approx \frac{-j}{\pi},\quad |c_1| = \frac{1}{\pi} \approx 0.318$$
$$c_3 = \frac{1}{j3\pi},\quad |c_3| \approx 0.106$$

**Parseval 검증:**

$$P_{\text{직접}} = \frac{1}{2}\int_0^1 1^2\,dt = \frac{1}{2}$$

$$P_{\text{급수}} = |c_0|^2 + 2\sum_{n \text{ odd}} |c_n|^2 = \frac{1}{4} + 2\left(\frac{1}{\pi^2} + \frac{1}{9\pi^2}+\cdots\right) = \frac{1}{4} + \frac{2}{\pi^2}\cdot\frac{\pi^2}{8} = \frac{1}{4}+\frac{1}{4} = \frac{1}{2}$$

---

## 메모

듀티 0.5 단극성 방형파($T=2$, $A=1$)는 $c_0=1/2$, 짝수차 0, 홀수차 $1/(jn\pi)$로 $|c_1|\approx0.318$, $|c_3|\approx0.106$이다. 계수 제곱합 $1/4+1/4$가 직접 적분한 평균전력 $1/2$와 같다.
듀티를 0.25로 바꿔 $c_n$을 다시 유도하고 몇 차 고조파에서 영점이 생기는지 찾아볼 것.

---

## 참고자료

- [MIT OCW 6.003 Lecture 4–5 — Fourier Series](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — 복소 푸리에 급수, 수렴
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 3](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — Parseval, 수렴, 깁스 현상
- [MathWorks — Fourier Series in Symbolic Math Toolbox](https://www.mathworks.com/help/symbolic/fourier-series.html) — MATLAB 심볼릭 푸리에 급수 계산
