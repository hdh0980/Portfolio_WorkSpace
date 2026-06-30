# 정상전류와 전도

## 학습 목표

- 전류밀도 $\mathbf{J}$의 정의와 전류의 관계를 설명한다.
- 미시적 옴의 법칙 $\mathbf{J}=\sigma\mathbf{E}$를 도출하고 거시적 옴의 법칙과 연결한다.
- 연속방정식 $\nabla\cdot\mathbf{J}=-\partial\rho_v/\partial t$에서 정상전류 조건을 유도한다.
- 완전도체와 실제 도체의 차이를 이해하고 줄 손실을 계산한다.
- 주어진 형상의 저항과 전도도를 계산한다.

## 1. 전류밀도 J

**전류**(current) $I$는 단위 시간에 단면을 통과하는 전하량이다.

$$
I = \frac{dQ}{dt} \quad [\text{A}]
$$

**전류밀도**(current density) $\mathbf{J}$는 단위 면적당 전류 벡터다.

$$
I = \int_S \mathbf{J}\cdot d\mathbf{S} \quad [\text{A/m}^2]
$$

미시적 관점에서 전하 캐리어 밀도 $n$, 전하 $q$, 드리프트 속도 $\mathbf{v}_d$:

$$
\mathbf{J} = nq\mathbf{v}_d
$$

## 2. 미시적 옴의 법칙

자유전자는 전계 $\mathbf{E}$의 힘 $q\mathbf{E}$를 받고, 격자 진동에 의한 충돌로 평균 드리프트 속도가 생긴다.

$$
\mathbf{v}_d = \mu_e \mathbf{E} \quad (\mu_e \text{: 전자 이동도})
$$

따라서:

$$
\mathbf{J} = nq\mu_e \mathbf{E} = \sigma\mathbf{E}
$$

여기서 $\sigma = nq\mu_e$는 **전도율(conductivity)** [S/m].

| 재료 | $\sigma$ [S/m] |
|------|---------------|
| 구리 | $5.8\times10^7$ |
| 알루미늄 | $3.5\times10^7$ |
| 은 | $6.1\times10^7$ |
| 실리콘(순수) | $1.56\times10^{-3}$ |
| 유리 | $10^{-12}$ |

**거시적 옴의 법칙** ($V=IR$)과의 연결: 균일 단면적 $A$, 길이 $L$의 도체에서:

$$
V = EL, \quad I = JA = \sigma EA \quad \Rightarrow \quad R = \frac{V}{I} = \frac{L}{\sigma A} = \frac{\rho L}{A}
$$

저항률 $\rho = 1/\sigma$ [Ω·m].

## 3. 연속방정식

전하 보존 법칙의 미분형:

$$
\nabla \cdot \mathbf{J} = -\frac{\partial \rho_v}{\partial t}
$$

유도: 임의 부피 $V$에서 순 유출 전류 = 내부 전하 감소율.

$$
\oint_S \mathbf{J}\cdot d\mathbf{S} = -\frac{d}{dt}\int_V \rho_v\,dV
$$

**정상전류(steady-state current)**: $\partial\rho_v/\partial t = 0$ 이면:

$$
\nabla \cdot \mathbf{J} = 0
$$

KCL의 미분형. 정상전류는 폐경로를 따라 흐르며 소멸되지 않는다.

## 4. 완전 도체의 정상 상태

완전 도체($\sigma\to\infty$)에서 유한한 $\mathbf{J}$가 흐르려면:

$$
\mathbf{E} = \frac{\mathbf{J}}{\sigma} \to \mathbf{0} \quad (\sigma\to\infty)
$$

즉, 완전 도체 내부 $\mathbf{E}=\mathbf{0}$은 정전계(정전 평형)뿐 아니라 정상전류 상태에서도 성립한다.

**이완 시간**(relaxation time): 초기 체전하 $\rho_{v0}$가 0으로 사라지는 시간상수.

$$
\rho_v(t) = \rho_{v0}\,e^{-t/\tau_r}, \quad \tau_r = \frac{\varepsilon}{\sigma}
$$

구리의 경우 $\tau_r = 8.854\times10^{-12}/(5.8\times10^7) \approx 1.5\times10^{-19}$ s — 사실상 즉각 표면 이동.

## 5. 줄 손실과 전력

미시적 전력 손실:

$$
p_v = \mathbf{J}\cdot\mathbf{E} = \sigma E^2 = \frac{J^2}{\sigma} \quad [\text{W/m}^3]
$$

부피 전체 손실:

$$
P = \int_V \mathbf{J}\cdot\mathbf{E}\,dV
$$

거시적 등가: $P = I^2R = V^2/R$.

## 6. 저항 계산

임의 형상의 저항은 $\mathbf{J}=\sigma\mathbf{E}$와 경계조건으로 풀거나, 대칭이 있으면 해석적으로 계산한다.

**동축 원통 저항** (내반경 $a$, 외반경 $b$, 길이 $L$, 전도율 $\sigma$, 전류 방향 = $\hat{r}$):

$$
R = \frac{\ln(b/a)}{2\pi\sigma L}
$$

이는 동축 커패시터 $C = 2\pi\varepsilon L/\ln(b/a)$와 $RC = \varepsilon/\sigma$ 관계를 만족한다.

## 7. 계산 예제

**예제**: 구리 버스바: 폭 40 mm, 두께 5 mm, 길이 50 cm. 직류 200 A가 흐를 때 (1) 전류밀도, (2) 전계, (3) 전압강하, (4) 손실을 구하라.

**단면적**:
$$
A = 40\times10^{-3}\times5\times10^{-3} = 2\times10^{-4}\;\text{m}^2
$$

**(1) 전류밀도**:
$$
J = I/A = 200/(2\times10^{-4}) = 10^6\;\text{A/m}^2 = 1\;\text{MA/m}^2
$$

**(2) 전계** ($\sigma_{\text{Cu}}=5.8\times10^7$ S/m):
$$
E = J/\sigma = 10^6/(5.8\times10^7) = 0.01724\;\text{V/m}
$$

**(3) 전압강하**:
$$
V = EL = 0.01724\times0.5 = 8.62\;\text{mV}
$$

**(4) 줄 손실**:
$$
P = VI = 8.62\times10^{-3}\times200 = 1.724\;\text{W}
$$

또는 $R = L/(\sigma A) = 0.5/(5.8\times10^7\times2\times10^{-4}) = 43.1\;\mu\Omega$, $P=I^2R=1.724$ W. ✓

## 학습·검증 기록

- **핵심 정리:** $J=I/A=\sigma E$로 전류밀도와 전계를 연결하고, 도체의 전압강하와 줄 손실을 $P=VI=I^2R$로 교차 계산한다.
- **확인 근거:** $200$ A 구리 버스바 예제에서 $J=1$ MA/m², $E=0.01724$ V/m, 전압강하 $8.62$ mV를 구했으며 $VI$와 $I^2R$ 모두 손실 $1.724$ W를 주었다.
- **다음 탐구:** 버스바의 폭·두께·길이를 변수로 두고 $R=L/(\sigma A)$와 $P=I^2R$로 단면적 변화에 따른 전압강하와 손실을 비교한다.

## 참고자료

- [MIT OCW 6.013 Electromagnetics and Applications](https://ocw.mit.edu/courses/6-013-electromagnetics-and-applications-fall-2005/) — 전도·전류밀도 강의
- [OpenStax University Physics Vol. 2 — Current and Resistance](https://openstax.org/books/university-physics-volume-2/pages/9-introduction) — 전류·저항 단원
- [OpenStax — Ohm's Law](https://openstax.org/books/university-physics-volume-2/pages/9-3-resistivity-and-resistance) — 미시적 옴의 법칙
