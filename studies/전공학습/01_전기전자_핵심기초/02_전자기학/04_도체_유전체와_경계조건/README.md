# 도체, 유전체와 경계조건

## 학습 목표

- 정전 평형 도체 내부에서 $\mathbf{E}=\mathbf{0}$임을 가우스 법칙으로 설명한다.
- 도체-자유공간 경계조건 $E_t=0$, $D_n=\rho_S$를 유도한다.
- 유전체 분극 $\mathbf{P}$와 속박 전하의 관계를 이해한다.
- 전기변위 $\mathbf{D}=\varepsilon_0\mathbf{E}+\mathbf{P}=\varepsilon\mathbf{E}$를 정의하고 경계조건을 적용한다.
- 비선형·이방성 유전체의 특성과 실무적 의미를 파악한다.

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

## 8. 실무 연결과 주의점

- EV OBC PCB 설계에서 FR4($\varepsilon_r\approx4.5$)와 공기 경계에서 전계 굴절이 생겨 모서리에 전계 집중 → 부분방전(PD) 위험.
- MLCC는 BaTiO₃ 강유전체 기반으로 $\varepsilon_r$이 수천에 달하지만, 직류 전압·온도·주파수에 따라 $\varepsilon_r$이 크게 변한다(비선형). 고전압 스위칭 회로에서 실제 용량을 과소평가하지 않도록 주의.
- 절연 재료의 전계 경계조건을 이해해야 절연층 두께·재질 선택 시 내압(breakdown voltage) 마진을 정확히 계산할 수 있다.

## 9. 자가 점검

1. 이상 도체 구 내부에 전하를 넣으면 어떻게 되는가? 외부 전계는?
2. 비유전율 $\varepsilon_r=5$ 슬래브의 한 면에 면전하 $\rho_S=40$ nC/m²이 있다. 슬래브 내부 $D_n$과 $E_n$을 구하라.
3. 전계가 유전체 경계에서 굴절될 때 접선 성분과 법선 성분 중 어느 것이 연속(불변)인가?

<details><summary>정답</summary>

1. 내부 전하는 표면으로 이동(정전 차폐). 외부 전계는 도체 구 표면의 유도 전하 분포로 결정된다. 외부에서는 도체 구 중심에 같은 전하가 있는 것과 동일한 전계.
2. $D_n = \rho_S = 40$ nC/m². $E_n = D_n/\varepsilon = 40\times10^{-9}/(5\times8.854\times10^{-12}) = 904$ V/m.
3. 접선 성분 $E_t$가 연속, 법선 성분 $D_n$이 연속(자유 면전하 없을 때). $E_n$은 $\varepsilon$ 비율만큼 달라진다.

</details>

## 참고자료

- [MIT OCW 6.013 Electromagnetics and Applications](https://ocw.mit.edu/courses/6-013-electromagnetics-and-applications-fall-2005/) — 도체·유전체 경계조건 강의
- [OpenStax University Physics Vol. 2 — Dielectrics](https://openstax.org/books/university-physics-volume-2/pages/8-4-dielectrics) — 분극과 유전체 기초
- [OpenStax — Conductors in Electrostatic Equilibrium](https://openstax.org/books/university-physics-volume-2/pages/7-4-conductors-in-electrostatic-equilibrium) — 도체 정전 평형
