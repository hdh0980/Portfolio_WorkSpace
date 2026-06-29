# 라플라스 변환과 연속시스템

## 학습 목표
- 양방향·단방향 라플라스 변환과 수렴영역(ROC)을 정의하고 차이를 설명할 수 있다.
- 부분분수 분해로 역라플라스 변환을 수행할 수 있다.
- 전달함수 $H(s)$를 정의하고 극점·영점 위치로 안정도를 판별할 수 있다.
- ROC와 인과성·안정성의 관계를 설명할 수 있다.
- 회로이론(RLC) 전달함수와 연결하여 보드선도의 기초를 이해한다.

---

## 1. 라플라스 변환 정의

### 1.1 양방향 (Bilateral)

$$X(s) = \int_{-\infty}^{\infty} x(t)\,e^{-st}\,dt, \quad s = \sigma + j\omega \in \mathbb{C}$$

### 1.2 단방향 (Unilateral, 인과 시스템 전용)

$$X(s) = \int_{0^-}^{\infty} x(t)\,e^{-st}\,dt$$

$t=0$에서 초기조건을 자연스럽게 포함할 수 있어 회로·제어 해석에 표준으로 사용된다.

### 1.3 푸리에 변환과의 관계

$s = j\omega$ (즉 $\sigma=0$, 허수축)으로 대입하면 라플라스 변환 → 푸리에 변환.

허수축이 ROC 안에 있어야 푸리에 변환이 존재한다.

---

## 2. 수렴 영역 (Region of Convergence, ROC)

$|X(s)|<\infty$인 복소 평면의 $s$ 집합.

### ROC 기본 규칙

| 신호 형태 | ROC |
|---------|-----|
| 인과(우방향) $e^{at}u(t)$ | $\text{Re}(s) > a$ (오른쪽 반평면) |
| 반인과(좌방향) $-e^{at}u(-t)$ | $\text{Re}(s) < a$ (왼쪽 반평면) |
| 유한 지속 신호 | 전체 $s$-평면 (극점 제외) |
| 양방향 지수 $e^{-a|t|}$ | 스트립 $-a < \text{Re}(s) < a$ |

- ROC는 극점을 포함하지 않는다.
- 인과 LTI: ROC는 가장 오른쪽 극점의 오른쪽.
- BIBO 안정 LTI: ROC가 $j\omega$축(허수축)을 포함.
- 인과 + 안정: 모든 극점이 좌반면(LHP).

---

## 3. 주요 변환쌍

| $x(t)$ | $X(s)$ | ROC |
|--------|---------|-----|
| $\delta(t)$ | $1$ | 전체 |
| $u(t)$ | $\frac{1}{s}$ | $\text{Re}(s)>0$ |
| $e^{-at}u(t)$ | $\frac{1}{s+a}$ | $\text{Re}(s)>-a$ |
| $te^{-at}u(t)$ | $\frac{1}{(s+a)^2}$ | $\text{Re}(s)>-a$ |
| $\cos(\omega_0 t)u(t)$ | $\frac{s}{s^2+\omega_0^2}$ | $\text{Re}(s)>0$ |
| $\sin(\omega_0 t)u(t)$ | $\frac{\omega_0}{s^2+\omega_0^2}$ | $\text{Re}(s)>0$ |
| $e^{-at}\cos(\omega_0 t)u(t)$ | $\frac{s+a}{(s+a)^2+\omega_0^2}$ | $\text{Re}(s)>-a$ |

---

## 4. 주요 성질

| 성질 | 시간 영역 | $s$ 영역 |
|------|---------|---------|
| 선형성 | $\alpha x_1+\beta x_2$ | $\alpha X_1+\beta X_2$ |
| 시간 이동 | $x(t-t_0)u(t-t_0)$ | $e^{-st_0}X(s)$ |
| $s$ 이동 | $e^{s_0 t}x(t)$ | $X(s-s_0)$ |
| 미분 | $\frac{d}{dt}x(t)$ | $sX(s) - x(0^-)$ |
| 적분 | $\int_0^t x(\tau)d\tau$ | $\frac{X(s)}{s}$ |
| 컨볼루션 | $x(t)*h(t)$ | $X(s)H(s)$ |
| 초기값 정리 | $x(0^+)$ | $\lim_{s\to\infty} sX(s)$ |
| 최종값 정리 | $\lim_{t\to\infty}x(t)$ | $\lim_{s\to 0} sX(s)$ (극점 LHP) |

---

## 5. 전달함수 H(s)와 안정도

$$H(s) = \frac{Y(s)}{X(s)} = \frac{b_m s^m + \cdots + b_0}{a_n s^n + \cdots + a_0} = K\frac{\prod_{k=1}^{m}(s-z_k)}{\prod_{k=1}^{n}(s-p_k)}$$

- **극점 $p_k$**: $H(s)$가 무한대 — 시스템 자유응답 결정
- **영점 $z_k$**: $H(s)=0$ — 주파수 선택 특성 결정

### 안정도 판별 (인과 LTI)

| 극점 위치 | 안정도 |
|---------|--------|
| 모두 LHP ($\text{Re}(p_k)<0$) | BIBO 안정 |
| $j\omega$축 단순 극점 | 한계 안정 (marginally stable) |
| RHP 극점 또는 허수축 중복 극점 | 불안정 |

---

## 6. 역라플라스 변환 — 부분분수 분해

$$X(s) = \frac{N(s)}{D(s)} = \sum_k \frac{A_k}{s - p_k} + \text{(중복 극점 항)}$$

잔류값: $A_k = (s-p_k)X(s)\big|_{s=p_k}$

중복 극점 $p_k$ (차수 $r$):

$$\frac{A_{k,r}}{(s-p_k)^r} + \cdots + \frac{A_{k,1}}{s-p_k}$$

$$A_{k,j} = \frac{1}{(r-j)!}\frac{d^{r-j}}{ds^{r-j}}\left[(s-p_k)^r X(s)\right]\Bigg|_{s=p_k}$$

---

## 7. 계산 예제

### 예제 1 — 부분분수 역변환

$$X(s) = \frac{2s+5}{(s+1)(s+3)}, \quad \text{ROC: } \text{Re}(s) > -1$$

$$X(s) = \frac{A}{s+1} + \frac{B}{s+3}$$

$$A = (s+1)X(s)\big|_{s=-1} = \frac{2(-1)+5}{(-1+3)} = \frac{3}{2}$$

$$B = (s+3)X(s)\big|_{s=-3} = \frac{2(-3)+5}{(-3+1)} = \frac{-1}{-2} = \frac{1}{2}$$

$$\Rightarrow x(t) = \left(\frac{3}{2}e^{-t} + \frac{1}{2}e^{-3t}\right)u(t)$$

두 극점 모두 LHP → 인과·안정 확인.

### 예제 2 — RC 회로 전달함수

1차 RC 저역통과 필터: $R=1\,\text{k}\Omega$, $C=10\,\mu\text{F}$

$$H(s) = \frac{1/sC}{R+1/sC} = \frac{1}{1+sRC} = \frac{1}{1+s\cdot 0.01}$$

극점: $s = -100$ (LHP) → 안정.

$-3\,\text{dB}$ 주파수: $\omega_c = 1/RC = 100\,\text{rad/s} = 15.9\,\text{Hz}$

최종값 정리: $\lim_{t\to\infty}y(t) = \lim_{s\to 0} s\cdot H(s)\cdot \frac{1}{s} = H(0) = 1$ (DC 이득 1).

---

## 8. 실무 연결과 주의점

- **EV OBC 전류 루프 전달함수** $G(s)$는 인덕터($sL$), 커패시터($1/sC$), 저항으로 구성된다. 폐루프 $T(s) = G(s)C(s)/[1+G(s)C(s)]$의 극점이 모두 LHP에 있어야 루프 안정이다.
- **최종값 정리**는 PI 제어기의 정상상태 오차 분석에 직접 쓰인다. 단, 극점이 허수축에 있으면(진동) 사용 불가.
- **라플라스 변환이 푸리에 변환으로 퇴화하는 조건**: ROC가 $j\omega$축을 포함할 때. 안정 LTI 시스템의 $H(s)|_{s=j\omega} = H(j\omega)$가 바로 보드선도의 기반이다.
- **초기조건 취급**: 단방향 변환의 미분 성질 $sX(s)-x(0^-)$ 덕분에 커패시터 초기 전압, 인덕터 초기 전류를 직접 포함시켜 해석할 수 있다.

---

## 9. 자가 점검

1. $x(t) = e^{2t}u(t)$의 라플라스 변환과 ROC를 구하라. 푸리에 변환이 존재하는가?
2. $H(s) = \frac{s+2}{s^2+3s+2}$의 극점을 구하고 안정도를 판별하라.
3. $X(s) = \frac{3}{s(s+2)}$의 역변환을 구하라 (ROC: $\text{Re}(s)>0$).

<details><summary>정답</summary>

1. $X(s)=\frac{1}{s-2}$, ROC: $\text{Re}(s)>2$. 허수축($\text{Re}=0$)이 ROC 밖 → 푸리에 변환 존재하지 않음.
2. $s^2+3s+2=(s+1)(s+2)$ → 극점 $s=-1$, $s=-2$ (모두 LHP) → 안정.
3. $X(s)=\frac{3}{s(s+2)}=\frac{3/2}{s}-\frac{3/2}{s+2}$ → $x(t)=\frac{3}{2}(1-e^{-2t})u(t)$.

</details>

---

## 참고자료

- [MIT OCW 6.003 Lecture 18–20 — Laplace Transform](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — ROC, 역변환, 전달함수
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 9](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — 라플라스 변환과 연속 LTI 해석
- [MathWorks — `laplace` and `ilaplace` Symbolic](https://www.mathworks.com/help/symbolic/laplace.html) — MATLAB 라플라스 심볼릭 연산
- [MathWorks — `tf` Transfer Function object](https://www.mathworks.com/help/control/ref/tf.html) — 전달함수 모델링 및 보드선도
