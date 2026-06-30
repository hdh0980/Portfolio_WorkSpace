# 시변전자계와 맥스웰 방정식

## 학습 목표

- 패러데이 법칙으로 시변 자속이 기전력(EMF)을 유도하는 원리를 설명한다.
- 변위전류(displacement current)의 개념과 물리적 의미를 이해한다.
- 맥스웰 4방정식을 적분형·미분형으로 모두 쓰고 각각의 물리 법칙을 대응시킨다.
- 포인팅 벡터로 전자기 에너지 흐름을 계산한다.
- 정자계·정전계가 시변 조건의 특수 경우임을 인식한다.

## 1. 패러데이 법칙

자속이 시간에 따라 변하면 폐경로에 EMF가 유도된다.

$$
\mathcal{E} = \oint_C \mathbf{E}\cdot d\mathbf{l} = -\frac{d\Phi_B}{dt} = -\frac{d}{dt}\int_S \mathbf{B}\cdot d\mathbf{S}
$$

**미분형**:

$$
\nabla\times\mathbf{E} = -\frac{\partial\mathbf{B}}{\partial t}
$$

- 정자계: $\partial\mathbf{B}/\partial t=0$ → $\nabla\times\mathbf{E}=\mathbf{0}$ (보존 전계).
- 시변: $\mathbf{E}$가 회전성을 가지므로 스칼라 전위 $V$만으로는 전계를 완전히 기술하지 못한다.

**렌츠 법칙**: 유도 EMF는 자속 변화를 방해하는 방향으로 전류를 흐르게 한다. 음(−) 부호의 물리적 의미.

## 2. 변위전류

암페어 법칙 $\nabla\times\mathbf{H}=\mathbf{J}$에서 $\nabla\cdot\mathbf{J}\neq0$ 문제 발생 (커패시터 내부 전도전류 없음). 맥스웰이 **변위전류**를 추가해 해결:

$$
\nabla\times\mathbf{H} = \mathbf{J} + \frac{\partial\mathbf{D}}{\partial t}
$$

$$
\mathbf{J}_d = \frac{\partial\mathbf{D}}{\partial t} = \varepsilon\frac{\partial\mathbf{E}}{\partial t} \quad \text{(변위전류밀도)}
$$

- 커패시터 플레이트 사이 진공에서도 $\partial\mathbf{E}/\partial t$가 있으면 $\mathbf{J}_d\neq0$ → 자계 발생.
- 이것이 전자기파 자기진동·전파의 핵심 메커니즘이다.

## 3. 맥스웰 방정식 4개

### 적분형

$$
\oint_S \mathbf{D}\cdot d\mathbf{S} = Q_{\text{enc}} = \int_V \rho_v\,dV \quad \text{(가우스 전기법칙)}
$$

$$
\oint_S \mathbf{B}\cdot d\mathbf{S} = 0 \quad \text{(가우스 자기법칙, 자기 단극 없음)}
$$

$$
\oint_C \mathbf{E}\cdot d\mathbf{l} = -\frac{d}{dt}\int_S \mathbf{B}\cdot d\mathbf{S} \quad \text{(패러데이 법칙)}
$$

$$
\oint_C \mathbf{H}\cdot d\mathbf{l} = \int_S\!\left(\mathbf{J}+\frac{\partial\mathbf{D}}{\partial t}\right)\!\cdot d\mathbf{S} \quad \text{(암페어-맥스웰 법칙)}
$$

### 미분형

$$
\nabla\cdot\mathbf{D} = \rho_v
$$

$$
\nabla\cdot\mathbf{B} = 0
$$

$$
\nabla\times\mathbf{E} = -\frac{\partial\mathbf{B}}{\partial t}
$$

$$
\nabla\times\mathbf{H} = \mathbf{J} + \frac{\partial\mathbf{D}}{\partial t}
$$

### 구성 관계 (선형 등방성 매질)

$$
\mathbf{D}=\varepsilon\mathbf{E}, \quad \mathbf{B}=\mu\mathbf{H}, \quad \mathbf{J}=\sigma\mathbf{E}
$$

## 4. 포인팅 벡터와 에너지 흐름

전자기장 에너지 흐름 밀도(단위 면적당 전력):

$$
\mathbf{S} = \mathbf{E}\times\mathbf{H} \quad [\text{W/m}^2]
$$

**포인팅 정리** (에너지 보존):

$$
-\frac{\partial}{\partial t}\left(\frac{1}{2}\varepsilon E^2 + \frac{1}{2}\mu H^2\right) = \nabla\cdot\mathbf{S} + \mathbf{J}\cdot\mathbf{E}
$$

- 좌변: 전자기 에너지 감소율
- $\nabla\cdot\mathbf{S}$: 단위 부피당 에너지 유출
- $\mathbf{J}\cdot\mathbf{E}$: 줄 열손실

동축 케이블에서 전력은 도체 안이 아니라 **도체 주변 전자기장**을 통해 전달된다 (포인팅 벡터 방향 = 축 방향).

## 5. 시변 경계조건

정자계·정전계 경계조건에 시변 효과가 추가된다 (면 자유전류 $\mathbf{K}_f$):

$$
\hat{\mathbf{n}}\times(\mathbf{H}_1-\mathbf{H}_2) = \mathbf{K}_f
$$

$$
\hat{\mathbf{n}}\times(\mathbf{E}_1-\mathbf{E}_2) = \mathbf{0}
$$

$$
\hat{\mathbf{n}}\cdot(\mathbf{D}_1-\mathbf{D}_2) = \rho_S
$$

$$
\hat{\mathbf{n}}\cdot(\mathbf{B}_1-\mathbf{B}_2) = 0
$$

## 6. 계산 예제

**예제**: 진공 중 평면 전자기파 $\mathbf{E}=10\cos(\omega t - \beta z)\hat{\mathbf{x}}$ V/m. 포인팅 벡터의 시간 평균 크기를 구하라.

파동 임피던스 $\eta_0 = \sqrt{\mu_0/\varepsilon_0} = 377\;\Omega$.

$$
H = E/\eta_0 = 10/377 = 26.5\;\text{mA/m}
$$

시간 평균 포인팅 벡터:

$$
\langle S\rangle = \frac{1}{2}E_0 H_0 = \frac{1}{2}\times10\times26.5\times10^{-3} = 0.133\;\text{W/m}^2
$$

또는:

$$
\langle S\rangle = \frac{E_0^2}{2\eta_0} = \frac{100}{2\times377} = 0.133\;\text{W/m}^2
$$

## 학습·검증 기록

- **핵심 정리:** 맥스웰 네 방정식은 전하·자속·유도 전계·전도 및 변위전류를 하나의 체계로 묶고, 포인팅 벡터 $\mathbf{E}\times\mathbf{H}$로 에너지 흐름을 표현한다.
- **확인 근거:** 진공 평면파 예제에서 $E_0=10$ V/m와 $\eta_0=377$ Ω로 $H_0=26.5$ mA/m를 구하고, $E_0H_0/2$와 $E_0^2/(2\eta_0)$ 모두 평균 전력밀도 $0.133$ W/m²를 주었다.
- **다음 탐구:** 패러데이 법칙과 암페어-맥스웰 법칙의 회전형을 연속 적용해 균일 매질의 파동방정식을 유도한다.

## 참고자료

- [MIT OCW 8.03 Physics III: Vibrations and Waves](https://ocw.mit.edu/courses/8-03sc-physics-iii-vibrations-and-waves-fall-2016/) — 맥스웰 방정식과 전자기파
- [MIT OCW 6.013 Electromagnetics and Applications](https://ocw.mit.edu/courses/6-013-electromagnetics-and-applications-fall-2005/) — 시변 전자계 강의
- [OpenStax University Physics Vol. 2 — Maxwell's Equations and Electromagnetic Waves](https://openstax.org/books/university-physics-volume-2/pages/16-introduction) — 맥스웰 방정식 단원
