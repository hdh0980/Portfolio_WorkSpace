# 교류전력과 3상회로

## 1. 단상 복소전력

RMS 페이저를 사용하면

$$
\mathbf S=\mathbf V\mathbf I^*=P+jQ, \qquad |S|=VI
$$

$$
P=VI\cos\phi, \qquad Q=VI\sin\phi, \qquad PF=\frac{P}{|S|}
$$

$P$는 평균적으로 소비·변환되는 유효전력(W), $Q$는 저장소자와 소스 사이를
왕복하는 무효전력(var), $|S|$는 설비 전류·전압 정격과 관련된 피상전력(VA)이다.

## 2. 평형 3상 관계

| 결선 | 전압 관계 | 전류 관계 |
|---|---|---|
| Y | $V_L=\sqrt3V_{ph}$ | $I_L=I_{ph}$ |
| Δ | $V_L=V_{ph}$ | $I_L=\sqrt3I_{ph}$ |

평형 부하의 총전력은 결선 방식과 무관하게 선간전압과 선전류로 쓸 수 있다.

$$
P=\sqrt3V_LI_L\cos\phi, \quad
Q=\sqrt3V_LI_L\sin\phi, \quad
|S|=\sqrt3V_LI_L
$$

평형 3상 순간전력의 합은 일정하므로 단상보다 토크와 DC 링크 전력 맥동이 작다.

## 3. 계산 예제

$V_L=380$ V, $I_L=10$ A, 지상역률 0.9인 평형 부하에서

$$
|S|=6.58\,\text{kVA}, \qquad
P=5.92\,\text{kW}, \qquad
Q=2.87\,\text{kvar}
$$

이다. Y결선이면 상전압은 $380/\sqrt3=219.4$ V다.

## 4. MATLAB 실습

- [평형 3상 전력 코드](./01_MATLAB_코드/three_phase_power.m)
- 세 상의 전압·전류 파형과 전체 순간전력을 계산하고 평균값을 복소전력식과 비교한다.

![MATLAB 평형 3상 전력](./02_결과_그림/three_phase_power.png)

## 메모

380 V, 10 A, 지상역률 0.9 예제는 $|S|=6.58$ kVA, $P=5.92$ kW, $Q=2.87$ kvar, Y결선 상전압 219.4 V다. MATLAB 예제는 세 상 순간전력 합의 평균을 복소전력식과 비교한다.
불평형 부하는 상별 복소전력을 따로 더해야 하니, 평형식 $\sqrt3V_LI_L\cos\phi$와 얼마나 벌어지는지 계산해 볼 것.

## 참고자료

- [MIT OCW 6.061 — Introduction to Electric Power Systems, Chapter 3](https://www.ocw.mit.edu/courses/6-061-introduction-to-electric-power-systems-spring-2011/c6393a58319200a5344752de0cf47ec4_MIT6_061S11_ch3.pdf) — 다상 시스템과 3상 관계
- [OpenStax — Power in an AC Circuit](https://openstax.org/books/university-physics-volume-2/pages/15-4-power-in-an-ac-circuit) — RMS, 평균전력, 역률
- [OpenStax — Chapter 15 Summary](https://openstax.org/books/university-physics-volume-2/pages/15-summary) — 교류 전력 핵심식
