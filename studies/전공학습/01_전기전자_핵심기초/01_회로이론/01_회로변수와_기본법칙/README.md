# 회로변수와 기본법칙

## 1. 회로변수

전류는 단위 시간에 이동하는 전하량이고, 전압은 단위 전하당 에너지 차이다.

$$
i(t)=\frac{dq(t)}{dt}, \qquad
v_{ab}=\frac{dw}{dq}
$$

전류가 소자의 `+` 단자로 들어가도록 기준을 잡으면 수동부호규약이 성립한다.

$$
p(t)=v(t)i(t), \qquad
w(t)=\int_{t_0}^{t}p(\tau)d\tau
$$

- $p>0$: 소자가 전력을 흡수한다.
- $p<0$: 소자가 외부로 전력을 공급한다.
- 전압과 전류의 기준 방향은 임의로 정할 수 있지만, 계산 중 바꾸면 안 된다.

## 2. 기본 소자

| 소자 | 전압·전류 관계 | 저장 에너지 |
|---|---|---|
| 저항 $R$ | $v=Ri$ | 저장하지 않고 $p=i^2R$로 소모 |
| 커패시터 $C$ | $i=C\,dv/dt$ | $w_C=\tfrac12Cv^2$ |
| 인덕터 $L$ | $v=L\,di/dt$ | $w_L=\tfrac12Li^2$ |

이상적인 커패시터 전압과 인덕터 전류는 유한한 전력 조건에서 순간적으로
변하지 않는다. 과도응답의 초기조건은 이 연속성으로 정한다.

## 3. 독립원과 종속원

독립 전압원·전류원은 회로의 다른 변수와 무관하게 지정된 값을 만든다. 종속원은
회로 내부의 전압 또는 전류에 비례하며 트랜지스터·연산증폭기 같은 능동소자의
선형 모델에 사용한다.

| 종속원 | 출력 관계 | 제어변수 |
|---|---|---|
| 전압제어 전압원(VCVS) | $v_o=\mu v_x$ | 전압 |
| 전압제어 전류원(VCCS) | $i_o=g_m v_x$ | 전압 |
| 전류제어 전압원(CCVS) | $v_o=r_m i_x$ | 전류 |
| 전류제어 전류원(CCCS) | $i_o=\beta i_x$ | 전류 |

종속원 기호에는 출력 방향과 제어변수의 기준을 함께 표시한다. 테브난 등가저항을
구할 때 독립원은 0으로 만들 수 있지만 종속원은 회로 동작을 나타내므로 유지한다.

## 4. KCL과 KVL

키르히호프 전류법칙(KCL)은 전하 보존에서, 전압법칙(KVL)은 에너지 보존에서
나온다.

$$
\sum_k i_k=0 \quad\text{(한 노드)}, \qquad
\sum_k v_k=0 \quad\text{(한 폐루프)}
$$

집중정수 회로에서는 소자의 크기가 관심 신호의 파장보다 충분히 작고,
노드와 가지 사이 전파 지연을 무시할 수 있다고 가정한다.

## 5. 계산 예제

12 V 전원에 $R_1=2\,\text{k}\Omega$, $R_2=4\,\text{k}\Omega$가 직렬 연결되면

$$
I=\frac{12}{2\,000+4\,000}=2\,\text{mA}
$$

전압강하는 각각 4 V와 8 V이며 KVL 합은 $12-4-8=0$이다. 저항의 총 소비전력은
$I^2(R_1+R_2)=24\,\text{mW}$로 전원이 공급한 $VI=24\,\text{mW}$와 같다.

## 메모

수동부호규약으로 소자별 전력을 다 더하면 0이 되어야 한다. 위 직렬회로는 2 mA, 4 V·8 V에서 전원 24 mW와 저항 합계 24 mW가 맞았다.
종속원이 섞인 회로에서도 소자별 전력 부호를 적어 두고 $\sum p_k=0$으로 검산해 볼 것.

## 참고자료

- [MIT OpenCourseWare 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 집중정수 회로, 소자, 네트워크 해석의 대학 기초과정
- [OpenStax University Physics Vol. 2 — Electrical Energy and Power](https://openstax.org/books/university-physics-volume-2/pages/9-5-electrical-energy-and-power) — 전기 에너지와 전력
- [OpenStax — Kirchhoff's Rules](https://openstax.org/books/university-physics-volume-2/pages/10-3-kirchhoffs-rules) — KCL·KVL과 보존법칙
