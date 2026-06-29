# 회로망 정리

## 학습 목표

- 중첩·전원변환·테브난·노턴 정리의 적용 조건을 구분한다.
- 부하 단자에서 본 등가전압과 등가저항을 계산한다.
- 최대전력전달 조건과 효율의 관계를 설명한다.

## 1. 선형성과 중첩

중첩정리는 선형 소자로 구성된 회로에서 독립원 하나의 효과를 차례로 계산해
합하는 방법이다. 다른 독립 전압원은 단락, 독립 전류원은 개방한다. 종속원은
회로의 선형 관계를 유지하므로 제거하지 않는다. 전력은 전압이나 전류의 제곱에
비례하므로 개별 전력 결과를 중첩하면 안 된다.

## 2. 전원변환

이상 전압원 $V_s$와 직렬저항 $R_s$는 이상 전류원 $I_s=V_s/R_s$와 같은
$R_s$의 병렬 연결로 바꿀 수 있다. 두 회로는 외부 단자에서 같은 $v$-$i$
특성을 보이지만 내부 가지 전류는 같다고 볼 수 없다.

## 3. 테브난·노턴 등가

선형 2단자망은 부하 관점에서 다음 두 형태로 치환할 수 있다.

$$
V_{th}=V_{oc}, \qquad I_N=I_{sc}, \qquad
R_{th}=R_N=\frac{V_{oc}}{I_{sc}}
$$

독립원만 있는 저항망에서는 독립원을 0으로 만든 뒤 단자에서 본 저항을
계산할 수 있다. 종속원이 있으면 독립 시험원을 단자에 인가해 $R_{th}=V_t/I_t$로
구한다.

## 4. 최대전력전달

저항 부하의 전력은

$$
P_L=\frac{V_{th}^2R_L}{(R_{th}+R_L)^2}
$$

이고 $R_L=R_{th}$일 때 최대다. 이때 소스 등가저항에서도 같은 전력이 소모되어
효율은 50%다. 전력변환 장치에서는 최대전력보다 효율과 열을 우선하는 경우가 많다.

## 5. 계산 예제

12 V 전원에 $R_1=2\,\text{k}\Omega$가 직렬, $R_2=4\,\text{k}\Omega$가 접지로
연결된 분압기의 출력 단자에서

$$
V_{th}=12\frac{4}{2+4}=8\,\text{V}, \qquad
R_{th}=2\parallel4=1.333\,\text{k}\Omega
$$

$R_L=2\,\text{k}\Omega$를 연결하면 $V_L=4.8$ V, $I_L=2.4$ mA다. 최대전력
부하는 1.333 kΩ이고 $P_{L,max}=V_{th}^2/(4R_{th})=12$ mW다.

## 6. 실무 연결과 주의점

- 센서 출력 임피던스와 ADC 입력 임피던스의 관계를 테브난 등가로 빠르게 판단할 수 있다.
- 전원을 0으로 만든다는 말은 물리적으로 제거한다는 뜻이 아니라 이상원의 값만 0으로 둔다는 뜻이다.
- 비선형 다이오드 회로에는 동작점 주변 소신호 선형화 없이 중첩정리를 직접 적용할 수 없다.

## 7. 자가 점검

1. 10 V 전압원과 5 Ω 직렬저항의 노턴 등가는 무엇인가?
2. $R_{th}=10\,\Omega$에서 최대전력 조건의 부하저항과 효율은 얼마인가?

<details><summary>정답</summary>

1. 2 A 전류원과 5 Ω 병렬저항.
2. $R_L=10\,\Omega$, 이상적인 저항 등가 기준 효율 50%.

</details>

## 참고자료

- [MIT OCW 6.002 — Course Resources](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/download/) — Lecture 3 Superposition, Thévenin and Norton
- [MIT OCW 6.002 — Course Home](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 선형 저항망과 독립·종속원
- [OpenStax — Direct-Current Circuits Summary](https://openstax.org/books/university-physics-volume-2/pages/10-summary) — 직렬·병렬 및 키르히호프 해석 요약
