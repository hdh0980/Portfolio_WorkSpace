# 정현파 교류와 페이저

## 학습 목표

- 진폭·주파수·위상을 이용해 정현파를 비교한다.
- RMS와 페이저의 의미를 구분한다.
- 직교형과 극형을 선택해 페이저의 합·곱·나눗셈을 계산한다.
- R·L·C의 임피던스로 교류 정상상태 회로를 해석한다.

## 1. 정현파와 RMS

$$
v(t)=V_m\cos(\omega t+\phi), \qquad f=\frac{\omega}{2\pi}
$$

정현파의 RMS는 같은 저항에서 동일한 평균전력을 만드는 직류 등가값이다.

$$
V_{rms}=\frac{V_m}{\sqrt2}, \qquad I_{rms}=\frac{I_m}{\sqrt2}
$$

페이저는 공통 시간인자 $e^{j\omega t}$를 생략한 복소수 표현이다. 이 노트에서는
RMS 크기를 사용해 $\mathbf V=V_{rms}\angle\phi$로 표시한다.

## 2. 임피던스

정현파 정상상태에서 미분은 $j\omega$ 곱셈으로 바뀐다.

$$
Z_R=R, \qquad Z_L=j\omega L, \qquad Z_C=\frac{1}{j\omega C}
$$

KCL·KVL과 노달·메시해석은 저항 대신 복소 임피던스를 사용하면 그대로 적용된다.
계산이 끝난 페이저는 크기와 위상을 이용해 시간함수로 복원한다.

## 3. 페이저 연산과 복소 분압

페이저의 덧셈·뺄셈은 실수부와 허수부를 사용하는 직교형이 편하고, 곱셈·나눗셈은
크기와 위상을 사용하는 극형이 편하다. 같은 각주파수에서 직렬 임피던스
$Z_1$, $Z_2$의 출력 전압은 복소 분압으로 계산한다.

$$
\mathbf V_o=\mathbf V_s\frac{Z_2}{Z_1+Z_2}
$$

크기만 계산하면 증폭·감쇠는 알 수 있지만 시간축에서 앞서는지 늦는지는 잃는다.
따라서 최종 결과는 크기와 위상을 함께 기록한다.

## 4. 계산 예제

$V=120\angle0^\circ$ V(RMS), $R=100\,\Omega$, $L=50$ mH가 직렬이고
$f=60$ Hz이면

$$
Z=100+j18.85=101.76\angle10.67^\circ\,\Omega
$$

$$
I=\frac{120\angle0^\circ}{101.76\angle10.67^\circ}
=1.179\angle-10.67^\circ\,\text{A}
$$

인덕성 회로이므로 전류가 전압보다 늦는다.

## 5. 실무 연결과 주의점

- 페이저는 같은 주파수의 정현파 정상상태에만 직접 적용한다. 과도응답은 포함하지 않는다.
- 최대값과 RMS를 섞으면 전력 계산이 2배 틀릴 수 있다.
- 커패시터 임피던스의 위상은 $-90^\circ$, 인덕터는 $+90^\circ$다.
- 복소수 계산 후 `atan(imag/real)` 대신 사분면을 보존하는 `angle` 또는 `atan2`를 사용한다.

## 6. 자가 점검

1. $v(t)=170\cos(377t)$ V의 RMS와 주파수는?
2. 주파수가 2배가 되면 $|Z_L|$과 $|Z_C|$는 각각 어떻게 변하는가?
3. 페이저 두 개를 더할 때 극형을 바로 더하지 않는 이유는?

<details><summary>정답</summary>

1. 약 120.2 V, 60.0 Hz.
2. $|Z_L|$은 2배, $|Z_C|$는 절반.
3. 크기와 위상은 벡터 성분이 아니므로, 직교형의 실수부·허수부로 변환해 더해야 한다.

</details>

## 참고자료

- [OpenStax — RLC Series Circuits with AC](https://openstax.org/books/university-physics-volume-2/pages/15-3-rlc-series-circuits-with-ac) — 페이저, 리액턴스, 임피던스
- [OpenStax — Chapter 15 Introduction](https://openstax.org/books/university-physics-volume-2/pages/15-introduction) — 교류회로 학습 범위
- [MIT OCW 6.002 — Video Lectures](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/video_galleries/video-lectures/) — Sinusoidal Steady State와 Impedance Model
