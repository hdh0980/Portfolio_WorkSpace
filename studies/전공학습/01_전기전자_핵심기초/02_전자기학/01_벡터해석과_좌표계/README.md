# 벡터해석과 좌표계

## 학습 목표

- 스칼라장과 벡터장의 차이를 구분하고, 기울기·발산·회전의 물리적 의미를 설명한다.
- 직교·원통·구면 좌표계 사이의 변환 공식을 적용한다.
- 발산정리(가우스 정리)와 스토크스 정리를 이용해 적분형·미분형을 상호 변환한다.
- 전자기학 각 법칙이 벡터 미분 연산자로 표현됨을 이해한다.
- 라플라시안을 이용해 포아송 방정식과 라플라스 방정식을 구분한다.

## 1. 스칼라장과 벡터장

**스칼라장** $f(\mathbf{r})$은 공간의 각 점에 하나의 수를 대응시킨다. 예: 온도 분포, 전위 $V$.

**벡터장** $\mathbf{F}(\mathbf{r})$은 각 점에 크기와 방향을 가진 벡터를 대응시킨다. 예: 전계 $\mathbf{E}$, 자속밀도 $\mathbf{B}$.

직교좌표계(Cartesian)에서:

$$
\mathbf{F} = F_x\,\hat{\mathbf{x}} + F_y\,\hat{\mathbf{y}} + F_z\,\hat{\mathbf{z}}
$$

단위벡터 $\hat{\mathbf{x}},\hat{\mathbf{y}},\hat{\mathbf{z}}$는 서로 직교하며 $\hat{\mathbf{x}}\times\hat{\mathbf{y}}=\hat{\mathbf{z}}$ (오른손 좌표계).

## 2. 기울기 (Gradient)

스칼라장의 기울기 $\nabla f$는 $f$가 가장 빠르게 증가하는 방향의 벡터를 준다.

$$
\nabla f = \frac{\partial f}{\partial x}\hat{\mathbf{x}} + \frac{\partial f}{\partial y}\hat{\mathbf{y}} + \frac{\partial f}{\partial z}\hat{\mathbf{z}}
$$

물리적 의미: 전위 $V$의 기울기가 전계와 반대 방향.

$$
\mathbf{E} = -\nabla V
$$

등전위면은 $\nabla V$에 항상 수직이다.

## 3. 발산 (Divergence)

벡터장의 발산 $\nabla \cdot \mathbf{F}$는 단위 부피당 순 유출을 나타낸다.

$$
\nabla \cdot \mathbf{F} = \frac{\partial F_x}{\partial x} + \frac{\partial F_y}{\partial y} + \frac{\partial F_z}{\partial z}
$$

- $\nabla \cdot \mathbf{F} > 0$: 해당 점에서 벡터장이 퍼져 나온다 (소스).
- $\nabla \cdot \mathbf{F} < 0$: 벡터장이 빨려 들어간다 (싱크).
- $\nabla \cdot \mathbf{F} = 0$: 비압축성(소스·싱크 없음).

전자기학에서: $\nabla \cdot \mathbf{D} = \rho_v$ (가우스 법칙 미분형).

## 4. 회전 (Curl)

벡터장의 회전 $\nabla \times \mathbf{F}$는 단위 면적당 순환(circulation)을 나타낸다.

$$
\nabla \times \mathbf{F} =
\begin{vmatrix}
\hat{\mathbf{x}} & \hat{\mathbf{y}} & \hat{\mathbf{z}} \\
\dfrac{\partial}{\partial x} & \dfrac{\partial}{\partial y} & \dfrac{\partial}{\partial z} \\
F_x & F_y & F_z
\end{vmatrix}
$$

- $\nabla \times \mathbf{F} \neq \mathbf{0}$: 회전하는 흐름이 존재 (와류).
- $\nabla \times \mathbf{F} = \mathbf{0}$: 보존적 벡터장 → 스칼라 퍼텐셜 존재.

전자기학에서: $\nabla \times \mathbf{H} = \mathbf{J} + \partial\mathbf{D}/\partial t$ (암페어-맥스웰 법칙).

## 5. 라플라시안

스칼라의 라플라시안은 기울기의 발산이다.

$$
\nabla^2 f = \nabla \cdot (\nabla f) = \frac{\partial^2 f}{\partial x^2} + \frac{\partial^2 f}{\partial y^2} + \frac{\partial^2 f}{\partial z^2}
$$

- **라플라스 방정식**: $\nabla^2 V = 0$ (소스 없는 영역의 전위)
- **포아송 방정식**: $\nabla^2 V = -\rho_v/\varepsilon$ (전하 분포 영역)

## 6. 좌표계 변환

### 원통 좌표계 $(r, \phi, z)$

$$
x = r\cos\phi,\quad y = r\sin\phi,\quad z = z
$$

$$
\nabla f = \frac{\partial f}{\partial r}\hat{\mathbf{r}} + \frac{1}{r}\frac{\partial f}{\partial \phi}\hat{\boldsymbol{\phi}} + \frac{\partial f}{\partial z}\hat{\mathbf{z}}
$$

$$
\nabla \cdot \mathbf{F} = \frac{1}{r}\frac{\partial(rF_r)}{\partial r} + \frac{1}{r}\frac{\partial F_\phi}{\partial \phi} + \frac{\partial F_z}{\partial z}
$$

### 구면 좌표계 $(R, \theta, \phi)$

$$
x = R\sin\theta\cos\phi,\quad y = R\sin\theta\sin\phi,\quad z = R\cos\theta
$$

$$
\nabla f = \frac{\partial f}{\partial R}\hat{\mathbf{R}} + \frac{1}{R}\frac{\partial f}{\partial \theta}\hat{\boldsymbol{\theta}} + \frac{1}{R\sin\theta}\frac{\partial f}{\partial \phi}\hat{\boldsymbol{\phi}}
$$

$$
\nabla \cdot \mathbf{F} = \frac{1}{R^2}\frac{\partial(R^2 F_R)}{\partial R} + \frac{1}{R\sin\theta}\frac{\partial(\sin\theta\, F_\theta)}{\partial \theta} + \frac{1}{R\sin\theta}\frac{\partial F_\phi}{\partial \phi}
$$

## 7. 발산정리 (가우스 정리)와 스토크스 정리

**발산정리**: 부피 적분과 면 적분을 연결한다.

$$
\oint_S \mathbf{F} \cdot d\mathbf{S} = \int_V (\nabla \cdot \mathbf{F})\, dV
$$

**스토크스 정리**: 면 적분과 선 적분을 연결한다.

$$
\oint_C \mathbf{F} \cdot d\mathbf{l} = \int_S (\nabla \times \mathbf{F}) \cdot d\mathbf{S}
$$

이 두 정리 덕분에 맥스웰 방정식의 적분형과 미분형이 동치임을 증명할 수 있다.

## 8. 계산 예제

**예제**: $\mathbf{F} = 2x\,\hat{\mathbf{x}} + 3y^2\,\hat{\mathbf{y}} + z\,\hat{\mathbf{z}}$ 의 발산을 구하고, $0 \le x,y,z \le 1$ 정육면체에서 발산정리를 검증하라.

**미분형**:
$$
\nabla \cdot \mathbf{F} = \frac{\partial(2x)}{\partial x} + \frac{\partial(3y^2)}{\partial y} + \frac{\partial(z)}{\partial z} = 2 + 6y + 1 = 3 + 6y
$$

**부피 적분**:
$$
\int_0^1\int_0^1\int_0^1 (3+6y)\,dx\,dy\,dz = \int_0^1(3+6y)\,dy = [3y+3y^2]_0^1 = 6
$$

**면 적분** (6개 면): $x=0$ 면 $(-2\cdot0)=-0$, $x=1$ 면 $(+2)$, $y=0$ 면 $0$, $y=1$ 면 $(+3)$, $z=0$ 면 $0$, $z=1$ 면 $(+1)$. 합 $= 2+3+1 = 6$. ✓

## 9. 실무 연결과 주의점

- EV OBC 설계에서 자기 부품(인덕터·트랜스) 해석 시, 토로이드나 원통형 코어는 원통/구면 좌표계로 장 분포를 계산한다.
- 발산정리는 가우스 법칙의 적분형 → 미분형 유도에 직접 쓰인다. EMI 차폐 설계에서 전하 분포와 E 장 관계를 빠르게 추산할 때 유용하다.
- $\nabla \times \mathbf{E} = -\partial\mathbf{B}/\partial t$: 고속 스위칭(수십~수백 kHz)에서 전계와 자계가 강하게 결합되므로, 정자계·정전계 근사가 깨지는 주파수 영역을 인식해야 한다.
- 원통 좌표계의 $\hat{\boldsymbol{\phi}}$ 방향이 위치에 따라 변한다는 점을 주의 — 미분할 때 단위벡터 자체도 미분해야 한다.

## 10. 자가 점검

1. $f = x^2 y + yz^2$의 $\nabla f$를 구하고 점 $(1, 2, 1)$에서 값을 계산하라.
2. $\mathbf{F} = \hat{\mathbf{r}}/r^2$ (원통 좌표)의 발산을 계산하라. 물리적으로 이것은 무엇을 의미하는가?
3. 스토크스 정리를 이용해 보존적 벡터장($\nabla \times \mathbf{F}=\mathbf{0}$)의 임의 폐경로 선 적분이 0임을 보여라.

<details><summary>정답</summary>

1. $\nabla f = 2xy\,\hat{\mathbf{x}} + (x^2+z^2)\,\hat{\mathbf{y}} + 2yz\,\hat{\mathbf{z}}$. 점 $(1,2,1)$: $4\,\hat{\mathbf{x}}+2\,\hat{\mathbf{y}}+4\,\hat{\mathbf{z}}$.
2. 원통 좌표에서 $\nabla\cdot(\hat{\mathbf{r}}/r^2) = \frac{1}{r}\frac{\partial}{\partial r}(r\cdot r^{-2}) = \frac{1}{r}\frac{\partial}{\partial r}(r^{-1}) = \frac{-1}{r^2}$. 단, $r=0$인 선원(line source)을 제외한 곳에서는 소스가 없음을 의미한다. 2D 점전하 아날로그.
3. 스토크스 정리: $\oint_C \mathbf{F}\cdot d\mathbf{l} = \int_S (\nabla\times\mathbf{F})\cdot d\mathbf{S} = \int_S \mathbf{0}\cdot d\mathbf{S} = 0$.

</details>

## 참고자료

- [MIT OCW 18.02 Multivariable Calculus](https://ocw.mit.edu/courses/18-02sc-multivariable-calculus-fall-2010/) — 기울기·발산·회전·스토크스·발산정리 전체 강의
- [MIT OCW 6.013 Electromagnetics and Applications](https://ocw.mit.edu/courses/6-013-electromagnetics-and-applications-fall-2005/) — 벡터해석이 전자기학에 어떻게 적용되는지 체계적으로 다룸
- [OpenStax University Physics Vol. 2 — Appendix: Coordinate Systems](https://openstax.org/books/university-physics-volume-2/pages/preface) — 좌표계 변환 공식 참조
