# 라플라스 회로해석

## 1. 일방 라플라스변환

회로의 스위칭 문제에는 $t=0^-$ 초기조건을 포함하기 쉬운 일방 변환을 주로 쓴다.

$$
F(s)=\int_{0^-}^{\infty}f(t)e^{-st}dt
$$

$$
\mathcal L\left\{\frac{df}{dt}\right\}=sF(s)-f(0^-)
$$

계단함수 $u(t)$는 $1/s$, 임펄스 $\delta(t)$는 1로 변환된다. 초기조건이 0이면
$Z_L=sL$, $Z_C=1/(sC)$를 사용해 저항회로와 같은 방식으로 해석할 수 있다.

## 2. 초기조건을 포함한 소자식

$$
V_L(s)=sLI_L(s)-Li_L(0^-)
$$

$$
I_C(s)=sCV_C(s)-Cv_C(0^-)
$$

초기 에너지는 s영역에서 독립원과 같은 항으로 나타난다. 이를 누락하면 영입력
응답이 사라져 완전응답이 틀린다.

## 3. 전달함수와 극점

초기조건을 0으로 두었을 때

$$
H(s)=\frac{Y(s)}{X(s)}=K\frac{\prod(s-z_i)}{\prod(s-p_i)}
$$

극점 $p_i$는 자연응답의 모드를, 영점 $z_i$는 특정 입력·출력 경로의 상쇄를
결정한다. 연속시간 안정 회로는 모든 극점의 실수부가 음수여야 한다.

## 4. 초기값·최종값 정리

$t=0$에 임펄스가 없고 극한이 존재하면 초기값은

$$
f(0^+)=\lim_{s\to\infty}sF(s)
$$

로 확인할 수 있다. 최종값 정리는 $sF(s)$의 모든 극점이 열린 좌반평면에 있을
때만 적용한다.

$$
f(\infty)=\lim_{s\to0}sF(s)
$$

우반평면 극점이나 허수축의 지속 진동 극점이 있으면 대수적 극한값이 나오더라도
실제 시간응답의 최종값으로 해석하면 안 된다.

## 5. 계산 예제

출력을 커패시터 전압으로 잡은 RC 저역통과 회로에서

$$
H(s)=\frac{1}{RCs+1}
$$

이다. 5 V 계단입력, $R=1$ kΩ, $C=100\,\mu$F이면

$$
V_C(s)=\frac{5}{s(0.1s+1)}
=\frac{5}{s}-\frac{0.5}{0.1s+1}
$$

이고 역변환 결과는 $v_C(t)=5(1-e^{-10t})u(t)$다. 극점 $-10$ rad/s가 시정수
0.1 s를 결정한다.

위 예제의 $V_C(s)$에 초기값·최종값 정리를 적용하면 각각 0 V와 5 V가 되어
시간영역 해와 일치한다.

## 메모

RC 저역통과 $H(s)=1/(0.1s+1)$은 극점 $-10$ rad/s, 시정수 0.1 s이고, 초기값·최종값 정리로 얻은 0 V와 5 V가 시간영역 해와 맞았다.
극점은 그대로 두고 좌반평면 영점과 우반평면 영점을 하나씩 넣어, 계단응답 초기 방향과 위상이 어떻게 달라지는지 비교해 볼 것.

## 참고자료

- [MIT OCW 18.03 — Laplace Transform Notes and Exercises](https://ocw.mit.edu/courses/18-03-differential-equations-spring-2010/pages/readings/notes_exe/) — 라플라스변환과 선형 시스템
- [MIT OCW 18.03SC — Solving Initial Value Problems](https://ocw.mit.edu/courses/18-03sc-differential-equations-fall-2011/pages/unit-iii-fourier-series-and-laplace-transform/laplace-transform-solving-initial-value-problems/) — 초기값 문제 풀이
- [MIT OCW 6.002 — Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 1·2차 회로의 시간·주파수영역 해석
