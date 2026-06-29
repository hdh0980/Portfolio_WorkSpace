# 이산 신호와 Z변환

## 학습 목표
- 이산 기본 신호(임펄스·계단·지수·정현파)를 수식으로 표현할 수 있다.
- 이산 LTI 시스템을 컨볼루션합으로 기술하고 임펄스응답으로 특성화할 수 있다.
- Z변환의 정의, 수렴영역(ROC), 주요 변환쌍을 사용할 수 있다.
- 역Z변환(부분분수·멱급수)을 수행할 수 있다.
- 이산 전달함수 $H(z)$의 극점 위치와 단위원 관계로 BIBO 안정도를 판별할 수 있다.

---

## 1. 이산 기본 신호

### 1.1 단위 임펄스 (Unit Impulse)

$$\delta[n] = \begin{cases} 1, & n=0 \\ 0, & n \neq 0 \end{cases}$$

체거름 성질: $\sum_{k=-\infty}^{\infty} x[k]\,\delta[n-k] = x[n]$

### 1.2 단위 계단 (Unit Step)

$$u[n] = \begin{cases} 1, & n \geq 0 \\ 0, & n < 0 \end{cases} = \sum_{k=0}^{\infty}\delta[n-k]$$

### 1.3 실 지수 (Real Exponential)

$$x[n] = a^n u[n], \quad a \in \mathbb{R}$$

- $|a| < 1$: 감쇠 (안정 모드)
- $|a| > 1$: 발산 (불안정)
- $|a| = 1$: 일정 진폭

### 1.4 이산 정현파

$$x[n] = A\cos(\omega_0 n + \phi)$$

각주파수 $\omega_0$ [rad/sample], 주기 $N_0 = 2\pi/\omega_0$ (유리수일 때 주기 신호).

---

## 2. 이산 LTI 시스템과 컨볼루션

이산 LTI의 입출력:

$$y[n] = x[n] * h[n] = \sum_{k=-\infty}^{\infty} x[k]\,h[n-k]$$

인과성: $h[n]=0$ for $n<0$

BIBO 안정성: $\sum_{n=-\infty}^{\infty}|h[n]| < \infty$

---

## 3. Z변환 정의

$$X(z) = \mathcal{Z}\{x[n]\} = \sum_{n=-\infty}^{\infty} x[n]\,z^{-n}, \quad z \in \mathbb{C}$$

라플라스 변환과의 유비:

$$z = e^{sT_s} \quad (T_s = \text{샘플링 주기})$$

즉 $z$-평면 단위원 $|z|=1$ ↔ $s$-평면 허수축 $j\omega$.

---

## 4. 수렴 영역 (ROC)

| 신호 형태 | ROC |
|---------|-----|
| 인과 (우방향) $a^n u[n]$ | $|z| > |a|$ |
| 반인과 (좌방향) $-a^n u[-n-1]$ | $|z| < |a|$ |
| 유한 길이 | 전체 (영점 제외, $z=0$ 또는 $z=\infty$ 가능) |
| 양방향 | 환(annulus) $r_1 < |z| < r_2$ |

ROC와 인과성·안정성:

- 인과 LTI: ROC는 가장 큰 극점 반지름의 **바깥쪽**
- BIBO 안정: ROC가 단위원 $|z|=1$ 포함
- 인과 + 안정: 모든 극점 $|p_k| < 1$ (단위원 안)

---

## 5. 주요 Z변환쌍

| $x[n]$ | $X(z)$ | ROC |
|--------|---------|-----|
| $\delta[n]$ | $1$ | 전체 |
| $u[n]$ | $\frac{z}{z-1} = \frac{1}{1-z^{-1}}$ | $|z|>1$ |
| $a^n u[n]$ | $\frac{z}{z-a} = \frac{1}{1-az^{-1}}$ | $|z|>|a|$ |
| $na^n u[n]$ | $\frac{az^{-1}}{(1-az^{-1})^2}$ | $|z|>|a|$ |
| $\cos(\omega_0 n)u[n]$ | $\frac{z^2 - z\cos\omega_0}{z^2 - 2z\cos\omega_0 + 1}$ | $|z|>1$ |
| $\sin(\omega_0 n)u[n]$ | $\frac{z\sin\omega_0}{z^2 - 2z\cos\omega_0 + 1}$ | $|z|>1$ |
| $r^n\cos(\omega_0 n)u[n]$ | $\frac{z^2 - rz\cos\omega_0}{z^2 - 2rz\cos\omega_0 + r^2}$ | $|z|>r$ |

---

## 6. 주요 성질

| 성질 | 시간 영역 | Z 영역 |
|------|---------|-------|
| 선형성 | $\alpha x_1+\beta x_2$ | $\alpha X_1+\beta X_2$ |
| 시간 지연 | $x[n-k]$ | $z^{-k}X(z)$ |
| 시간 전진 | $x[n+k]$ | $z^k X(z)$ |
| Z영역 스케일 | $a^n x[n]$ | $X(z/a)$ |
| 컨볼루션 | $x[n]*h[n]$ | $X(z)H(z)$ |
| 초기값 | $x[0]$ | $\lim_{z\to\infty} X(z)$ |
| 최종값 | $\lim_{n\to\infty}x[n]$ | $\lim_{z\to 1}(z-1)X(z)$ |

---

## 7. 이산 전달함수 H(z)

$$H(z) = \frac{Y(z)}{X(z)} = \frac{b_0 + b_1 z^{-1} + \cdots + b_M z^{-M}}{1 + a_1 z^{-1} + \cdots + a_N z^{-N}}$$

차분 방정식(Difference Equation)과의 대응:

$$y[n] + a_1 y[n-1] + \cdots + a_N y[n-N] = b_0 x[n] + \cdots + b_M x[n-M]$$

### 안정도 판별 (인과 이산 LTI)

| 극점 위치 | 안정도 |
|---------|--------|
| 모두 $|p_k| < 1$ (단위원 내부) | BIBO 안정 |
| 단위원 위 단순 극점 | 한계 안정 |
| $|p_k| > 1$ | 불안정 |

---

## 8. 역Z변환

### 방법 1: 부분분수 분해

$$\frac{X(z)}{z} = \frac{N(z)}{z\cdot D(z)} = \frac{A_0}{z} + \sum_k \frac{A_k}{z - p_k}$$

$$\Rightarrow X(z) = A_0 + \sum_k \frac{A_k z}{z - p_k}$$

### 방법 2: 멱급수 (Power Series / Long Division)

$$X(z) = \sum_{n=0}^{\infty} x[n] z^{-n} = x[0] + x[1]z^{-1} + x[2]z^{-2} + \cdots$$

---

## 9. 계산 예제

### 예제 1 — 부분분수 역Z변환

$$X(z) = \frac{z^2}{(z-0.5)(z-0.25)}, \quad \text{ROC: }|z|>0.5$$

$$\frac{X(z)}{z} = \frac{z}{(z-0.5)(z-0.25)} = \frac{A}{z-0.5} + \frac{B}{z-0.25}$$

$$A = (z-0.5)\frac{z}{(z-0.5)(z-0.25)}\Bigg|_{z=0.5} = \frac{0.5}{0.25} = 2$$

$$B = (z-0.25)\frac{z}{(z-0.5)(z-0.25)}\Bigg|_{z=0.25} = \frac{0.25}{-0.25} = -1$$

$$X(z) = \frac{2z}{z-0.5} - \frac{z}{z-0.25}$$

$$\Rightarrow \boxed{x[n] = \left[2(0.5)^n - (0.25)^n\right]u[n]}$$

두 극점 모두 단위원 안 → 안정.

### 예제 2 — 전달함수와 안정도

1차 IIR 필터: $y[n] = 0.8y[n-1] + x[n]$

$$H(z) = \frac{1}{1 - 0.8z^{-1}} = \frac{z}{z-0.8}$$

극점: $z = 0.8$ → $|0.8| < 1$ → **안정**

임펄스응답: $h[n] = (0.8)^n u[n]$

안정성 검증: $\sum_{n=0}^\infty |0.8^n| = \frac{1}{1-0.8} = 5 < \infty$ ✓

### 예제 3 — 멱급수 역변환

$$X(z) = \frac{1}{1 + 0.5z^{-1}} = \sum_{n=0}^\infty (-0.5)^n z^{-n}$$

$$\Rightarrow x[n] = (-0.5)^n u[n] = \{1,\,-0.5,\,0.25,\,-0.125,\,\ldots\}$$

---

## 10. 실무 연결과 주의점

- **디지털 PI 제어기**: 이산 전달함수 $C(z)$로 구현. 적분 항의 극점 $z=1$ (단위원 위)은 한계 안정이므로, 폐루프 전달함수의 모든 극점이 단위원 안에 있는지 확인 필수.
- **EV OBC 디지털 전류 제어기** (예: 62.5 kHz 샘플링, $T_s = 16\,\mu\text{s}$): 연속 영역 $H(s)$를 Tustin(Bilinear) 변환으로 $H(z)$로 변환.

  $$s \leftarrow \frac{2}{T_s}\cdot\frac{z-1}{z+1} \quad \text{(Tustin)}$$

- **시간 지연 $z^{-1}$**: 디지털 구현에서 1샘플 지연은 $z^{-1}$. 계산 지연이 누적되면 위상 마진을 갉아먹는다.
- **최종값 정리** $\lim_{z\to1}(z-1)X(z)$: PI 제어기가 정상상태 오차를 0으로 수렴시키는지 확인하는 데 사용.

---

## 11. 자가 점검

1. $h[n] = (1.2)^n u[n]$인 이산 LTI가 BIBO 안정인지 판별하라.
2. $X(z) = \frac{z}{z-0.9}$의 역Z변환을 구하라 (ROC: $|z|>0.9$).
3. 이산 LTI 전달함수의 극점이 $z=0.6+j0.6$ 이라면 이 극점의 $|z|$는? 안정한가?

<details><summary>정답</summary>

1. 극점 $z=1.2$, $|1.2|>1$ → **불안정**. $\sum|h[n]|=\sum 1.2^n=\infty$.
2. $x[n] = (0.9)^n u[n]$ (표준 변환쌍 직접 적용).
3. $|z|=\sqrt{0.6^2+0.6^2}=\sqrt{0.72}\approx 0.849 < 1$ → **안정**.

</details>

---

## 참고자료

- [MIT OCW 6.003 Lecture 20–22 — Z-Transform](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — Z변환, ROC, 역변환
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 10](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — Z변환 이론과 이산 LTI 해석
- [MathWorks — `ztrans` and `iztrans` Symbolic](https://www.mathworks.com/help/symbolic/ztrans.html) — MATLAB Z변환 심볼릭
- [MathWorks — Digital Filter Design using `designfilt`](https://www.mathworks.com/help/signal/ref/designfilt.html) — IIR/FIR 이산 필터 설계
