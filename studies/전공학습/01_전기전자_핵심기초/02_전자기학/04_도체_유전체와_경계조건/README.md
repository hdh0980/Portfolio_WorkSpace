# 도체, 유전체와 경계조건

## 1. 도체 내부 전계 E = 0

정전 평형 상태의 이상적 도체에서:

- 자유 전자가 무한히 빠르게 재배치되므로 내부에 $\mathbf{E}$가 존재하면 힘 $\mathbf{F}=q\mathbf{E}$가 전자를 이동시켜 결국 $\mathbf{E}=\mathbf{0}$이 될 때까지 재배치된다.
- 따라서 도체 내부의 자유전하 밀도 $\rho_v=0$ (가우스 법칙 $\nabla\cdot\mathbf{D}=\rho_v=0$).
- 전하는 **표면**에만 존재한다.
- 도체 내부는 등전위: $V=\text{const}$.

> 참고 도식: Hayt & Buck, *Engineering Electromagnetics* 8판, Fig. 5.3.

## 2. 도체 표면 경계조건

도체(1)와 자유공간(2) 경계면에서 접선·법선 성분을 분리한다.

**접선 성분** (폐경로 적분에 패러데이 정적 조건 적용):

$$
E_{t1} = E_{t2} = 0
$$

도체 표면 위의 접선 전계는 0 — 전기력선이 표면에 수직.

**법선 성분** (가우스 법칙, 필박스 가우스 면):

$$
D_{n2} - D_{n1} = \rho_S \quad \Rightarrow \quad D_{n} = \rho_S \quad (D_{n1}=0)
$$

$$
E_n = \frac{\rho_S}{\varepsilon_0}
$$

도체 표면 외부 전계의 크기는 표면 전하밀도에 비례한다.

## 3. 유전체와 분극 P

유전체에 외부 전계 $\mathbf{E}$를 가하면 원자·분자 내 전하가 미시적으로 변위되어 **전기 쌍극자**가 형성된다. 이것이 **분극(polarization)** $\mathbf{P}$다.

$$
\mathbf{P} = \varepsilon_0 \chi_e \mathbf{E} \quad [\text{C/m}^2]
$$

여기서 $\chi_e$는 전기 감수율(electric susceptibility).

**속박 체전하와 면전하**:

$$
\rho_{vb} = -\nabla \cdot \mathbf{P}, \qquad \rho_{Sb} = \mathbf{P}\cdot\hat{\mathbf{n}}
$$

분극이 균일하면 내부 속박 체전하는 0이고, 표면에만 속박 면전하가 나타난다.

## 4. 전기변위 D와 비유전율

자유전하와 속박전하를 함께 다루는 불편함을 피하려고 전기변위 $\mathbf{D}$를 정의한다:

$$
\mathbf{D} = \varepsilon_0\mathbf{E} + \mathbf{P}
$$

선형 등방성 유전체에서 $\mathbf{P} = \varepsilon_0\chi_e\mathbf{E}$이므로:

$$
\mathbf{D} = \varepsilon_0(1+\chi_e)\mathbf{E} = \varepsilon_0\varepsilon_r\mathbf{E} = \varepsilon\mathbf{E}
$$

여기서 $\varepsilon_r = 1+\chi_e$는 비유전율(relative permittivity), $\varepsilon = \varepsilon_r\varepsilon_0$.

| 재료 | $\varepsilon_r$ |
|------|----------------|
| 진공 | 1.000 |
| 공기 | 1.0006 |
| PTFE | 2.1 |
| 에폭시(FR4) | 4.5 |
| 세라믹(BaTiO₃) | 1,000 ~ 10,000 |

## 5. 유전체-유전체 경계조건

두 유전체 1($\varepsilon_1$)과 2($\varepsilon_2$) 경계면에서:

**접선 성분** (정적 $\nabla\times\mathbf{E}=\mathbf{0}$ 적용):

$$
E_{t1} = E_{t2}
$$

**법선 성분** (자유 면전하 $\rho_S=0$ 가정):

$$
D_{n1} = D_{n2} \quad \Rightarrow \quad \varepsilon_1 E_{n1} = \varepsilon_2 E_{n2}
$$

전계의 굴절:

$$
\frac{\tan\theta_1}{\tan\theta_2} = \frac{\varepsilon_1}{\varepsilon_2}
$$

여기서 $\theta$는 전계 방향과 경계 법선 사이의 각도.

## 6. 비선형 유전체와 강유전체

- **비선형 유전체**: $\mathbf{D}$가 $\mathbf{E}$의 비선형 함수. 예: 강유전체(BaTiO₃)에서 히스테리시스.
- **이방성 유전체**: $\varepsilon$이 텐서. 수정(crystal)처럼 방향에 따라 $\varepsilon$ 다름.
- **강유전체**: 외부 $\mathbf{E}=\mathbf{0}$에도 자발 분극 $\mathbf{P}_s$ 존재 — MLCC 용량 비선형성의 원인.

## 7. 계산 예제

**예제**: 두 유전체 경계: $\varepsilon_{r1}=3$, $\varepsilon_{r2}=6$. 영역 1의 전계 $\mathbf{E}_1 = 5\hat{\mathbf{x}} + 3\hat{\mathbf{y}}$ kV/m (경계면 $= xy$ 평면, 법선 = $\hat{\mathbf{z}}$). 영역 2의 전계를 구하라.

**접선 성분** (연속):
$$
E_{t2} = E_{t1} \Rightarrow E_{x2} = 5\;\text{kV/m},\quad E_{y2} = 3\;\text{kV/m}
$$

**법선 성분** ($z$방향, 자유전하 없음, $D_{n1}=D_{n2}$):
$$
\varepsilon_{r1}E_{z1} = \varepsilon_{r2}E_{z2}
$$
$E_{z1} = 0$ (주어진 벡터에 $z$ 성분 없음) → $E_{z2} = 0$.

$$
\mathbf{E}_2 = 5\hat{\mathbf{x}} + 3\hat{\mathbf{y}}\;\text{kV/m}
$$

(법선 성분이 0이므로 이 예제에서 굴절 없음. $E_{z1}\neq0$인 경우에 굴절이 나타남.)

**보충**: $E_{z1}=4$ kV/m라면 $E_{z2}=\varepsilon_{r1}/\varepsilon_{r2}\times4=2$ kV/m로 감소.

## 메모

$\varepsilon_{r1}=3$, $\varepsilon_{r2}=6$ 경계에서 접선 성분 $(5,3)$ kV/m는 그대로 넘어가고, $E_{z1}=4$ kV/m를 주면 $E_{z2}=2$ kV/m로 절반이 된다.
경계에 자유 면전하가 있을 때는 $D_{n2}-D_{n1}=\rho_S$를 넣어 양쪽 전계 크기와 굴절각을 다시 구해 볼 것.

## 참고자료

- [MIT OCW 6.013 Electromagnetics and Applications](https://ocw.mit.edu/courses/6-013-electromagnetics-and-applications-fall-2005/) — 도체·유전체 경계조건 강의
- [OpenStax University Physics Vol. 2 — Dielectrics](https://openstax.org/books/university-physics-volume-2/pages/8-4-dielectrics) — 분극과 유전체 기초
- [OpenStax — Conductors in Electrostatic Equilibrium](https://openstax.org/books/university-physics-volume-2/pages/7-4-conductors-in-electrostatic-equilibrium) — 도체 정전 평형
