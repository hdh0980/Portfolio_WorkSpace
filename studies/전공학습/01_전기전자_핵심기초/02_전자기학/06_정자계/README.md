# 정자계

## 학습 목표

- 비오-사바르 법칙으로 임의 전류 경로의 자속밀도 $\mathbf{B}$를 계산한다.
- 암페어 법칙(적분형·미분형)을 이용해 대칭 전류 분포의 $\mathbf{B}$를 구한다.
- 자기력(로렌츠 힘)으로 전류 도체와 하전 입자에 작용하는 힘을 계산한다.
- 직선·원형·솔레노이드 전류의 자속밀도를 공식으로 표현한다.
- 자기 선속 보존 $\nabla\cdot\mathbf{B}=0$의 의미를 설명한다.

## 1. 비오-사바르 법칙

전류 소자 $Id\mathbf{l}$이 위치 $\mathbf{r}'$에 있을 때, 관측점 $\mathbf{r}$에서의 자속밀도 기여:

$$
d\mathbf{B} = \frac{\mu_0}{4\pi}\frac{I\,d\mathbf{l}\times\hat{\mathbf{R}}}{R^2}
$$

여기서 $\mathbf{R}=\mathbf{r}-\mathbf{r}'$, $\mu_0 = 4\pi\times10^{-7}$ H/m (진공 투자율).

전체 $\mathbf{B}$는 경로 전체를 적분한다:

$$
\mathbf{B} = \frac{\mu_0 I}{4\pi}\int_C \frac{d\mathbf{l}\times\hat{\mathbf{R}}}{R^2}
$$

- $\mathbf{B}$ 단위: T (테슬라) = Wb/m² = V·s/m².
- 자속밀도 $\mathbf{B}$는 전계와 달리 홀극(자기 단극)이 없어 항상 폐경로를 이룬다.

## 2. 무한 직선 전류의 B

원통 좌표에서 $z$축 방향 무한 직선 전류 $I$:

$$
\mathbf{B} = \frac{\mu_0 I}{2\pi r}\hat{\boldsymbol{\phi}}
$$

- $r$ 증가에 따라 $1/r$로 감쇠.
- 오른나사 법칙: 전류 방향으로 오른 엄지를 향하면 손가락이 감기는 방향 = $\hat{\boldsymbol{\phi}}$.

## 3. 원형 전류 루프의 B (축 위)

반지름 $a$인 원형 루프, $z$축 위 거리 $z$에서:

$$
\mathbf{B} = \frac{\mu_0 I a^2}{2(a^2+z^2)^{3/2}}\hat{\mathbf{z}}
$$

루프 중심($z=0$):

$$
B = \frac{\mu_0 I}{2a}
$$

## 4. 솔레노이드와 토로이드

**솔레노이드** (단위 길이당 $n$회 권선, 무한 길이):

$$
B = \mu_0 nI \quad (\text{내부 균일})
$$

외부: $B\approx0$.

**토로이드** (단면 내부, $N$회 권선, 평균 반경 $R$):

$$
B = \frac{\mu_0 NI}{2\pi R}
$$

## 5. 암페어 법칙

**적분형**: 폐경로 $C$를 통과하는 전류의 합.

$$
\oint_C \mathbf{H}\cdot d\mathbf{l} = I_{\text{enc}}
$$

자계 세기 $\mathbf{H} = \mathbf{B}/\mu_0$ (진공).

**미분형** (스토크스 정리):

$$
\nabla\times\mathbf{H} = \mathbf{J}
$$

암페어 법칙은 **대칭이 있을 때** 해석적으로 $\mathbf{H}$를 구하는 데 쓰인다.

## 6. 자기 선속과 자기 단극 없음

$$
\Phi = \int_S \mathbf{B}\cdot d\mathbf{S} \quad [\text{Wb}]
$$

$$
\oint_S \mathbf{B}\cdot d\mathbf{S} = 0 \quad \Leftrightarrow \quad \nabla\cdot\mathbf{B} = 0
$$

자기 선속선은 항상 폐곡선 — 자기 단극(monopole)은 존재하지 않는다.

## 7. 자기력 (로렌츠 힘)

하전 입자($q$, 속도 $\mathbf{v}$)에 작용하는 힘:

$$
\mathbf{F} = q\mathbf{v}\times\mathbf{B}
$$

전류 도체 소자 $Id\mathbf{l}$에 작용하는 힘:

$$
d\mathbf{F} = I\,d\mathbf{l}\times\mathbf{B}
$$

전기·자기 결합 로렌츠 힘:

$$
\mathbf{F} = q(\mathbf{E}+\mathbf{v}\times\mathbf{B})
$$

**평행 도체 사이의 힘**: 간격 $d$, 전류 $I_1$, $I_2$인 평행 직선 도체 단위 길이당 힘:

$$
\frac{F}{L} = \frac{\mu_0 I_1 I_2}{2\pi d}
$$

같은 방향: 인력, 반대 방향: 척력.

## 8. 계산 예제

**예제**: 두 평행 직선 도체가 3 cm 떨어져 각각 100 A를 같은 방향으로 흐른다. 1 m당 힘을 구하라.

$$
\frac{F}{L} = \frac{\mu_0 I_1 I_2}{2\pi d} = \frac{4\pi\times10^{-7}\times100\times100}{2\pi\times0.03}
$$

$$
= \frac{4\pi\times10^{-3}}{2\pi\times0.03} = \frac{4\times10^{-3}}{2\times0.03} = \frac{4\times10^{-3}}{0.06} = 66.7\;\text{mN/m}
$$

같은 방향이므로 **인력** 66.7 mN/m.

**검산**: $\mu_0/(2\pi) = 2\times10^{-7}$ H/m 사용:
$F/L = 2\times10^{-7}\times10^4/0.03 = 2\times10^{-3}/0.03 = 0.0667$ N/m. ✓

## 9. 실무 연결과 주의점

- EV OBC 버스바·케이블 레이아웃에서 왕복 전류 경로를 가깝게 배치하면 자기장이 상쇄되어 EMI가 줄어들고, 방향이 반대이면 척력으로 기계적 진동 발생 가능.
- 토로이드 코어 인덕터는 자기장이 코어 내부에 갇혀 누설이 적다 — 그래서 OBC PFC/DAB에서 일반 솔레노이드보다 EMC 측면에서 유리.
- 평행 도체 인력은 고전류 계통 버스바·차단기에서 기계적 설계 하중이 된다 (IEC 60865 단락전류 기계적 응력 기준).
- 비오-사바르 법칙은 선 적분이 복잡한 형상에서 수치해석(BEM/FEM)으로 처리한다.

## 10. 자가 점검

1. $z$축 방향으로 500 A가 흐르는 직선 도체. 점 $(3, 4, 0)$ cm에서 $\mathbf{B}$의 크기와 방향은? (원점이 도체 위치)
2. 반지름 5 cm인 100회 권선 솔레노이드에 2 A가 흐른다 (길이 20 cm). 내부 $B$를 구하라.
3. 자기 단극이 존재하면 $\nabla\cdot\mathbf{B}=0$이 성립하는가? 이유를 설명하라.

<details><summary>정답</summary>

1. $r = \sqrt{3^2+4^2} = 5$ cm. $B = \mu_0 I/(2\pi r) = 4\pi\times10^{-7}\times500/(2\pi\times0.05) = 2\times10^{-3}$ T $= 2$ mT. 방향: 오른나사 법칙으로 $\hat{\boldsymbol{\phi}}$ — 점 $(3,4,0)$에서는 $(-4\hat{x}+3\hat{y})/5$ 방향.
2. $n = N/L = 100/0.2 = 500$ 회/m. $B = \mu_0 nI = 4\pi\times10^{-7}\times500\times2 = 1.257$ mT.
3. 자기 단극이 있으면 $\nabla\cdot\mathbf{B}=\mu_0\rho_m\neq0$ (자기 전하밀도). 현재까지 실험적으로 자기 단극은 발견되지 않아 $\nabla\cdot\mathbf{B}=0$이 맥스웰 방정식으로 채택되어 있다.

</details>

## 참고자료

- [MIT OCW 8.02 Electricity and Magnetism](https://ocw.mit.edu/courses/8-02-electricity-and-magnetism-spring-2002/) — 암페어 법칙·비오-사바르 강의
- [OpenStax University Physics Vol. 2 — Sources of Magnetic Fields](https://openstax.org/books/university-physics-volume-2/pages/12-introduction) — 정자계 소스
- [OpenStax — Magnetic Forces and Fields](https://openstax.org/books/university-physics-volume-2/pages/11-introduction) — 자기력 단원
