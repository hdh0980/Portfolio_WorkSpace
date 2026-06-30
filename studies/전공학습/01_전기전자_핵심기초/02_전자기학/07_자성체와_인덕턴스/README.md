# 자성체와 인덕턴스

## 학습 목표

- 자성체 분극(자화) $\mathbf{M}$과 자화전류의 관계를 설명한다.
- 자계 세기 $\mathbf{H} = \mathbf{B}/\mu_0 - \mathbf{M}$을 정의하고 경계조건을 적용한다.
- 자기회로의 기자력·자기저항 개념을 이용해 코어 인덕터를 해석한다.
- 자기 인덕턴스 $L$과 상호인덕턴스 $M$의 정의와 계산 방법을 익힌다.
- 인덕터 저장 에너지와 EV OBC 자성소자 설계를 연결한다.

## 1. 자성체와 자화 M

외부 자계 $\mathbf{H}$를 가하면 재료 내 자기 쌍극자(원자 자기 모멘트)가 정렬되어 **자화**(magnetization) $\mathbf{M}$이 나타난다.

$$
\mathbf{M} = \chi_m \mathbf{H} \quad [\text{A/m}]
$$

여기서 $\chi_m$은 자기 감수율(magnetic susceptibility).

| 자성 종류 | $\chi_m$ | 특성 |
|-----------|---------|------|
| 반자성체(diamagnetic) | $\ll 0$ (작은 음수) | 외부 $\mathbf{B}$ 약간 감소 |
| 상자성체(paramagnetic) | $> 0$ (작은 양수) | 외부 $\mathbf{B}$ 약간 증가 |
| 강자성체(ferromagnetic) | $\gg 0$ | $\mathbf{B}$ 크게 증가, 히스테리시스 |

## 2. 자화전류

자화 $\mathbf{M}$의 불균일에 의해 등가 전류가 발생한다.

**체자화전류**:
$$
\mathbf{J}_m = \nabla\times\mathbf{M}
$$

**면자화전류** (경계면):
$$
\mathbf{K}_m = \mathbf{M}\times\hat{\mathbf{n}}
$$

균일하게 자화된 재료 내부에서는 $\mathbf{J}_m=\mathbf{0}$이고, 표면에만 자화 면전류가 흐른다.

## 3. 자계 세기 H와 자속밀도 B

자유전류와 자화전류를 분리하기 위해 $\mathbf{H}$를 정의한다:

$$
\mathbf{B} = \mu_0(\mathbf{H}+\mathbf{M})
$$

선형 등방성 자성체: $\mathbf{M}=\chi_m\mathbf{H}$이므로:

$$
\mathbf{B} = \mu_0(1+\chi_m)\mathbf{H} = \mu_0\mu_r\mathbf{H} = \mu\mathbf{H}
$$

여기서 $\mu_r = 1+\chi_m$은 비투자율, $\mu=\mu_0\mu_r$.

암페어 법칙(수정형):
$$
\nabla\times\mathbf{H} = \mathbf{J}_f \qquad (\mathbf{J}_f: \text{자유전류만})
$$

$$
\oint_C \mathbf{H}\cdot d\mathbf{l} = I_{f,\text{enc}}
$$

## 4. 자성체 경계조건

두 매질 1($\mu_1$)과 2($\mu_2$) 경계면에서:

**접선 성분** ($\mathbf{J}_f=0$ 가정):
$$
H_{t1} = H_{t2}
$$

**법선 성분** ($\nabla\cdot\mathbf{B}=0$):
$$
B_{n1} = B_{n2} \quad \Rightarrow \quad \mu_1 H_{n1} = \mu_2 H_{n2}
$$

전계 굴절과 유사하게 $\mathbf{H}$가 굴절된다:

$$
\frac{\tan\theta_1}{\tan\theta_2} = \frac{\mu_1}{\mu_2}
$$

## 5. 자기회로와 자기저항

코어-권선 시스템을 자기회로로 모델링한다.

**기자력(MMF)**:
$$
\mathcal{F} = NI \quad [\text{A-turns}]
$$

**자기저항(reluctance)**:
$$
\mathcal{R} = \frac{l}{\mu A} \quad [\text{A/Wb} = \text{H}^{-1}]
$$

**자기 옴의 법칙**:
$$
\Phi = \frac{\mathcal{F}}{\mathcal{R}} = \frac{NI}{\mathcal{R}}
$$

에어갭($\mu_0$, 길이 $l_g$, 단면 $A_g$)이 있는 코어:

$$
\mathcal{R}_{\text{total}} = \mathcal{R}_{\text{core}} + \mathcal{R}_{\text{gap}} = \frac{l_c}{\mu_r\mu_0 A_c} + \frac{l_g}{\mu_0 A_g}
$$

일반적으로 $\mu_r \gg 1$이므로 에어갭 자기저항이 지배적이다.

## 6. 자기 인덕턴스 L

**자기 인덕턴스**는 전류 $I$와 교쇄 자기선속 $\Lambda$의 비:

$$
L = \frac{\Lambda}{I} = \frac{N\Phi}{I} \quad [\text{H}]
$$

자기회로로 표현:

$$
L = \frac{N^2}{\mathcal{R}} = \frac{\mu N^2 A}{l}
$$

**에너지로 정의**:

$$
L = \frac{2W_m}{I^2}, \quad W_m = \frac{1}{2}LI^2
$$

**토로이드 인덕턴스** (단면적 $A$, 평균 길이 $l$, $N$회):

$$
L = \frac{\mu N^2 A}{l} = \frac{\mu_0\mu_r N^2 A}{l}
$$

## 7. 상호인덕턴스 M

두 코일 1, 2가 있을 때 코일 1의 전류 $I_1$이 코일 2에 생성하는 교쇄선속:

$$
M_{21} = \frac{N_2\Phi_{21}}{I_1} \quad \text{(상호인덕턴스)} \quad M_{21}=M_{12}=M
$$

**노이만 공식**:

$$
M = \frac{\mu_0}{4\pi}\oint_{C_1}\oint_{C_2}\frac{d\mathbf{l}_1\cdot d\mathbf{l}_2}{R_{12}}
$$

결합계수:

$$
k = \frac{M}{\sqrt{L_1 L_2}}, \quad 0 \le k \le 1
$$

이상 결합($k=1$)이면 완전 에너지 전달. 변압기 해석의 기초.

## 8. 자기 에너지

단일 인덕터:
$$
W_m = \frac{1}{2}LI^2
$$

부피 에너지밀도:
$$
w_m = \frac{1}{2}\mu H^2 = \frac{B^2}{2\mu} = \frac{1}{2}\mathbf{B}\cdot\mathbf{H} \quad [\text{J/m}^3]
$$

## 9. 계산 예제

**예제**: EV OBC DAB 변압기 코어 설계. 나노크리스탈 코어, $\mu_r=15{,}000$, 단면적 $A=4\;\text{cm}^2$, 평균 자기회로 길이 $l_c=12\;\text{cm}$, 에어갭 $l_g=0.5\;\text{mm}$, 1차 권선수 $N_1=20$. 인덕턴스를 구하라.

**자기저항**:
$$
\mathcal{R}_{\text{core}} = \frac{l_c}{\mu_r\mu_0 A} = \frac{0.12}{15000\times4\pi\times10^{-7}\times4\times10^{-4}}
= \frac{0.12}{7.54\times10^{-6}} = 1.59\times10^4\;\text{A/Wb}
$$

$$
\mathcal{R}_{\text{gap}} = \frac{l_g}{\mu_0 A} = \frac{5\times10^{-4}}{4\pi\times10^{-7}\times4\times10^{-4}}
= \frac{5\times10^{-4}}{5.027\times10^{-10}} = 9.95\times10^5\;\text{A/Wb}
$$

$$
\mathcal{R}_{\text{total}} \approx 1.01\times10^6\;\text{A/Wb} \quad (\text{에어갭 지배})
$$

**인덕턴스**:
$$
L = \frac{N_1^2}{\mathcal{R}_{\text{total}}} = \frac{400}{1.01\times10^6} = 396\;\mu\text{H} \approx 400\;\mu\text{H}
$$

## 학습·검증 기록

- **핵심 정리:** 자기회로에서는 $\mathcal{R}=l/(\mu A)$와 $L=N^2/\mathcal{R}$로 인덕턴스를 구하며, 선형 투자율 가정은 선형 근사 범위에서만 유효하다.
- **확인 근거:** 예제에서 코어 자기저항 $1.59\times10^4$ A/Wb보다 에어갭 자기저항 $9.95\times10^5$ A/Wb가 지배적임을 비교하고, 총 자기저항으로 $L=396$ μH를 계산했다.
- **다음 탐구:** 권선 전류를 변수로 자속밀도 $B$를 계산하고 재료의 $B_{\text{sat}}$와 비교해 선형 자기회로 모델의 적용 범위를 정한다.

## 참고자료

- [MIT OCW 6.013 Electromagnetics and Applications](https://ocw.mit.edu/courses/6-013-electromagnetics-and-applications-fall-2005/) — 자성체·인덕턴스 강의
- [OpenStax University Physics Vol. 2 — Inductance](https://openstax.org/books/university-physics-volume-2/pages/14-introduction) — 인덕턴스 단원
- [OpenStax — Magnetic Materials](https://openstax.org/books/university-physics-volume-2/pages/12-5-the-biot-savart-law) — 자성체 기초
