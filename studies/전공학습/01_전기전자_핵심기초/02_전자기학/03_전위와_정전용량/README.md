# 전위와 정전용량

## 학습 목표

- 전위 $V$와 전계 $\mathbf{E}$의 관계식 $\mathbf{E} = -\nabla V$를 유도하고 적용한다.
- 등전위면의 기하적 성질과 전계와의 관계를 설명한다.
- 정전용량의 정의에서 구형·원통형·평행판 커패시터 용량을 계산한다.
- 유전체 내 전계 에너지밀도를 구하고 커패시터 저장 에너지를 계산한다.
- 커패시터 직렬·병렬 합성 원리를 도출한다.

## 1. 전위 V

전위(electric potential)는 단위 양전하를 기준점(보통 무한원)에서 관심 점까지 이동시키는 데 필요한 일이다.

$$
V(\mathbf{r}) = -\int_{\infty}^{\mathbf{r}} \mathbf{E}\cdot d\mathbf{l} \quad [\text{V} = \text{J/C}]
$$

점전하 $Q$에 의한 전위:

$$
V = \frac{Q}{4\pi\varepsilon_0 R}
$$

전위는 스칼라이므로 중첩이 쉽다:

$$
V = \sum_k \frac{Q_k}{4\pi\varepsilon_0 R_k} = \int \frac{\rho_v\,dV'}{4\pi\varepsilon_0 R}
$$

## 2. 전위와 전계의 관계

$$
\mathbf{E} = -\nabla V = -\left(\frac{\partial V}{\partial x}\hat{\mathbf{x}} + \frac{\partial V}{\partial y}\hat{\mathbf{y}} + \frac{\partial V}{\partial z}\hat{\mathbf{z}}\right)
$$

두 점 A, B 사이의 전위차:

$$
V_{AB} = V_A - V_B = -\int_B^A \mathbf{E}\cdot d\mathbf{l} = \int_A^B \mathbf{E}\cdot d\mathbf{l}
$$

- $\mathbf{E}$는 높은 전위에서 낮은 전위 방향(양전하가 내려가는 방향).
- 보존적 벡터장: $\oint \mathbf{E}\cdot d\mathbf{l} = 0$ (정전계).

## 3. 등전위면

$V = \text{const}$인 면이 등전위면이다.

- $\mathbf{E} = -\nabla V$이므로 $\mathbf{E}$는 등전위면에 **항상 수직**.
- 등전위면 위에서 전하를 이동시키는 데는 일이 필요하지 않다.
- 도체 표면은 정전 평형 상태에서 등전위면이다.

> 참고 도식: Hayt & Buck, *Engineering Electromagnetics* 8판, Fig. 2.17.

## 4. 정전용량 C

두 도체 사이에 전위차 $V_0$를 줄 때 도체에 쌓이는 전하량 $Q$의 비:

$$
C = \frac{Q}{V_0} \quad [\text{F}]
$$

계산 절차: ① 가우스 법칙으로 전계 $\mathbf{E}$ 표현 → ② 전계 적분으로 $V_0$ 계산 → ③ $C = Q/V_0$.

### 평행판 커패시터

판 면적 $A$, 간격 $d$, 유전율 $\varepsilon$:

$$
E = \frac{\rho_S}{\varepsilon} = \frac{Q}{\varepsilon A}, \quad V_0 = Ed = \frac{Qd}{\varepsilon A}
$$

$$
C = \frac{\varepsilon A}{d}
$$

### 원통형 커패시터

내반경 $a$, 외반경 $b$, 길이 $L$, 유전율 $\varepsilon$:

$$
C = \frac{2\pi\varepsilon L}{\ln(b/a)}
$$

### 구형 커패시터

내반경 $a$, 외반경 $b$:

$$
C = \frac{4\pi\varepsilon ab}{b-a}
$$

$b \to \infty$ 이면 고립 구의 정전용량 $C = 4\pi\varepsilon a$.

## 5. 에너지 밀도와 저장 에너지

유전체 내 전기장 에너지밀도:

$$
w_E = \frac{1}{2}\varepsilon E^2 = \frac{1}{2}\mathbf{D}\cdot\mathbf{E} \quad [\text{J/m}^3]
$$

커패시터 저장 에너지:

$$
W_E = \frac{1}{2}CV_0^2 = \frac{Q^2}{2C} = \frac{QV_0}{2}
$$

전체 부피 적분으로도 같은 결과:

$$
W_E = \frac{1}{2}\varepsilon\int_V E^2\,dV
$$

## 6. 커패시터 직렬·병렬

**병렬**: 전압 같음, 전하 합산

$$
C_{\text{eq}} = C_1 + C_2 + \cdots
$$

**직렬**: 전하 같음, 전압 합산

$$
\frac{1}{C_{\text{eq}}} = \frac{1}{C_1} + \frac{1}{C_2} + \cdots
$$

## 7. 계산 예제

**예제**: 평행판 커패시터: $A = 400\;\text{cm}^2 = 400\times10^{-4}\;\text{m}^2$, $d = 2\;\text{mm}$, 유전율 $\varepsilon_r = 4.5$ (세라믹), $V_0 = 50\;\text{V}$.

**정전용량**:
$$
C = \frac{\varepsilon_r\varepsilon_0 A}{d} = \frac{4.5\times8.854\times10^{-12}\times400\times10^{-4}}{2\times10^{-3}} = 796\;\text{pF}
$$

**저장 전하**:
$$
Q = CV_0 = 796\times10^{-12}\times50 = 39.8\;\text{nC}
$$

**전계**:
$$
E = V_0/d = 50/(2\times10^{-3}) = 25{,}000\;\text{V/m} = 25\;\text{kV/m}
$$

**에너지**:
$$
W_E = \frac{1}{2}CV_0^2 = \frac{1}{2}\times796\times10^{-12}\times50^2 = 995\;\text{nJ} \approx 1\;\mu\text{J}
$$

## 학습·검증 기록

- **핵심 정리:** 전위차를 적분해 전계를 연결하고, $C=Q/V_0$와 $W_E=CV_0^2/2$로 형상·유전율·전압에 따른 정전용량과 저장 에너지를 계산한다.
- **확인 근거:** 평행판 예제에서 $C=796$ pF, $Q=39.8$ nC, $E=25$ kV/m를 구하고 저장 에너지를 $995$ nJ, 즉 약 $1$ μJ로 계산했다.
- **다음 탐구:** 같은 유전율과 길이 조건에서 평행판·원통형·구형 커패시터의 형상 변수 변화가 정전용량에 미치는 영향을 비교한다.

## 참고자료

- [MIT OCW 8.02 Electricity and Magnetism](https://ocw.mit.edu/courses/8-02-electricity-and-magnetism-spring-2002/) — 전위·커패시터 강의
- [OpenStax University Physics Vol. 2 — Electric Potential](https://openstax.org/books/university-physics-volume-2/pages/7-introduction) — 전위 단원
- [OpenStax — Capacitance](https://openstax.org/books/university-physics-volume-2/pages/8-introduction) — 정전용량 단원
