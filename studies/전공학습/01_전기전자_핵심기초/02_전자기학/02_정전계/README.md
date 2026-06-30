# 정전계

## 학습 목표

- 쿨롱 법칙으로 점전하 사이의 힘과 전계를 계산한다.
- 가우스 법칙(적분형·미분형)을 이용해 대칭 전하 분포의 전계를 구한다.
- 선·면·체 전하 분포에 대한 전계를 중첩 원리로 계산한다.
- 전기 쌍극자의 전계와 전위를 표현하고 전기력선을 이해한다.
- 가우스 법칙이 성립하는 조건과 가우스 면 선택 전략을 설명한다.

## 1. 쿨롱 법칙

진공 중 점전하 $Q_1$, $Q_2$ 사이의 힘:

$$
\mathbf{F}_{12} = \frac{Q_1 Q_2}{4\pi\varepsilon_0 R_{12}^2}\,\hat{\mathbf{R}}_{12}
$$

여기서 $\varepsilon_0 = 8.854 \times 10^{-12}$ F/m, $\hat{\mathbf{R}}_{12}$는 $Q_1 \to Q_2$ 방향 단위벡터.

- 같은 부호: 척력, 다른 부호: 인력.
- 쿨롱 상수 $k = 1/(4\pi\varepsilon_0) \approx 9\times10^9$ N·m²/C².

## 2. 전계 E

전계(electric field intensity)는 시험 전하 $q_t$에 가해지는 힘 $\mathbf{F}$를 $q_t$로 나눈 것이다.

$$
\mathbf{E} = \lim_{q_t \to 0}\frac{\mathbf{F}}{q_t}
$$

점전하 $Q$로부터 거리 $R$에서의 전계:

$$
\mathbf{E} = \frac{Q}{4\pi\varepsilon_0 R^2}\,\hat{\mathbf{R}} \quad [\text{V/m}]
$$

여러 점전하가 있으면 중첩 원리를 쓴다:

$$
\mathbf{E} = \sum_k \frac{Q_k}{4\pi\varepsilon_0 |\mathbf{r}-\mathbf{r}_k|^2}\,\hat{\mathbf{R}}_k
$$

## 3. 연속 전하분포

| 분포 | 원소 | 전계 기여 |
|------|------|-----------|
| 선전하 $\rho_L$ [C/m] | $dQ = \rho_L\,dl$ | $d\mathbf{E} = \dfrac{\rho_L\,dl}{4\pi\varepsilon_0 R^2}\hat{\mathbf{R}}$ |
| 면전하 $\rho_S$ [C/m²] | $dQ = \rho_S\,dS$ | $d\mathbf{E} = \dfrac{\rho_S\,dS}{4\pi\varepsilon_0 R^2}\hat{\mathbf{R}}$ |
| 체전하 $\rho_v$ [C/m³] | $dQ = \rho_v\,dV$ | $d\mathbf{E} = \dfrac{\rho_v\,dV}{4\pi\varepsilon_0 R^2}\hat{\mathbf{R}}$ |

**무한 직선 전하** $\rho_L$의 반경 $r$ 위치 전계:

$$
\mathbf{E} = \frac{\rho_L}{2\pi\varepsilon_0 r}\,\hat{\mathbf{r}}
$$

**무한 평면 면전하** $\rho_S$의 전계:

$$
\mathbf{E} = \frac{\rho_S}{2\varepsilon_0}\,\hat{\mathbf{n}}
$$

## 4. 가우스 법칙

**적분형**: 임의 폐곡면 $S$를 통과하는 전기선속은 내부 총 전하에 비례한다.

$$
\oint_S \mathbf{D} \cdot d\mathbf{S} = Q_{\text{enc}}, \quad \mathbf{D} = \varepsilon_0 \mathbf{E}
$$

**미분형** (발산정리 적용):

$$
\nabla \cdot \mathbf{D} = \rho_v
$$

가우스 면은 **대칭** 조건이 있을 때만 $\mathbf{E}$를 면 밖으로 꺼낼 수 있다:
구형, 원통형, 판형 대칭이 대표적이다.

## 5. 전기 쌍극자

크기 $Q$, 간격 $d$인 쌍극자. 쌍극자 모멘트 $\mathbf{p} = Qd\,\hat{\mathbf{z}}$.

원거리 ($R \gg d$) 구면 좌표에서의 전위와 전계:

$$
V = \frac{Qd\cos\theta}{4\pi\varepsilon_0 R^2} = \frac{p\cos\theta}{4\pi\varepsilon_0 R^2}
$$

$$
\mathbf{E} = \frac{p}{4\pi\varepsilon_0 R^3}(2\cos\theta\,\hat{\mathbf{R}} + \sin\theta\,\hat{\boldsymbol{\theta}})
$$

쌍극자장은 단극($1/R^2$)보다 빠르게 ($1/R^3$) 감쇠한다.

## 6. 계산 예제

**예제**: $y=0$ 평면에 면전하 $\rho_S = 20$ nC/m²이 균일 분포. 점 $P(0, 4, 0)$ m에서 전계를 구하라.

**풀이**: 무한 평면이므로 수직 방향 성분만 남고:

$$
E = \frac{\rho_S}{2\varepsilon_0} = \frac{20\times10^{-9}}{2\times8.854\times10^{-12}} \approx 1,129 \;\text{V/m}
$$

$P$는 $y=+4$ 쪽에 있으므로:

$$
\mathbf{E} = 1{,}129\,\hat{\mathbf{y}} \;\text{V/m}
$$

**검산**: $\rho_S / (2\varepsilon_0) = 20\text{n} / (17.7\text{p}) \approx 1{,}130$ V/m (유효숫자 4자리). ✓

## 학습·검증 기록

- **핵심 정리:** 가우스 법칙은 폐곡면 내부 전하와 전기선속을 연결하며, 구형·원통형·판형 대칭에서 전계를 간단히 구할 수 있다.
- **확인 근거:** $20$ nC/m² 무한 면전하 예제에 $E=\rho_S/(2\varepsilon_0)$를 적용해 $1{,}129$ V/m를 얻었고, 단위 비율 검산값 약 $1{,}130$ V/m와 일치했다.
- **다음 탐구:** 유한 크기 평면의 축상 전계를 적분해 무한 평면 결과와 비교하고, 거리에 따른 가우스 법칙 단순화의 오차를 살펴본다.

## 참고자료

- [MIT OCW 8.02 Electricity and Magnetism](https://ocw.mit.edu/courses/8-02-electricity-and-magnetism-spring-2002/) — 쿨롱 법칙·가우스 법칙 강의 및 문제
- [OpenStax University Physics Vol. 2 — Electric Charges and Fields](https://openstax.org/books/university-physics-volume-2/pages/5-introduction) — 정전계 기초 개념
- [OpenStax — Gauss's Law](https://openstax.org/books/university-physics-volume-2/pages/6-introduction) — 가우스 법칙 단원
