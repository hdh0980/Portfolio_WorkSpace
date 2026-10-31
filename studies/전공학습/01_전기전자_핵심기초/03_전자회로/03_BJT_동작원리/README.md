# BJT 동작원리

## 1. BJT 구조

BJT(Bipolar Junction Transistor)는 두 개의 PN접합을 등을 맞대어 붙인 구조.

```
NPN:   E(N) | B(P) | C(N)
PNP:   E(P) | B(N) | C(P)
```

- **이미터(E):** 다수 캐리어를 공급하는 단자 (높은 도핑 $N_E \gg N_B$)
- **베이스(B):** 얇고 가볍게 도핑, 소수 캐리어 통과 제어
- **컬렉터(C):** 캐리어를 수집하는 단자

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 6.1.

---

## 2. 동작 영역

| 영역 | BE 접합 | BC 접합 | 용도 |
|---|---|---|---|
| 능동(Active) | 순방향 | 역방향 | 증폭기 |
| 포화(Saturation) | 순방향 | 순방향 | 스위치(ON) |
| 차단(Cutoff) | 역방향 | 역방향 | 스위치(OFF) |
| 역방향 활성 | 역방향 | 순방향 | 드물게 사용 |

---

## 3. 전류 관계와 전류이득

능동 영역 NPN BJT:

$$I_C = \beta I_B = \alpha I_E$$

$$I_E = I_B + I_C$$

전류이득 관계:

$$\alpha = \frac{\beta}{\beta + 1}, \quad \beta = \frac{\alpha}{1-\alpha}$$

$\beta$ 범위: 보통 50~300 (BJT 종류에 따라 다름)

예: $\beta = 100$이면 $\alpha = 100/101 \approx 0.99$

---

## 4. Ebers-Moll 모델 개요

BJT를 두 개의 다이오드와 전류 의존 전류원으로 표현하는 완전 모델.

$$I_C = I_S\!\left[\exp\!\left(\frac{V_{BE}}{V_T}\right) - 1\right] - \frac{I_S}{\beta_R}\!\left[\exp\!\left(\frac{V_{BC}}{V_T}\right) - 1\right]$$

능동 영역 단순화 ($V_{BC} \ll 0$):

$$I_C \approx I_S \exp\!\left(\frac{V_{BE}}{V_T}\right)$$

$$I_B = \frac{I_C}{\beta}, \quad I_E = I_C\!\left(1 + \frac{1}{\beta}\right)$$

$I_S$: 포화전류 ($10^{-15}$ ~ $10^{-12}\ \text{A}$)

---

## 5. 직류 바이어스와 동작점 (Q-point)

**4저항 바이어스 (전압분배 바이어스) 회로:**

1. 테브낭 등가: $V_{TH} = V_{CC}\frac{R_2}{R_1+R_2}$, $R_{TH} = R_1 \| R_2$
2. KVL: $V_{TH} = I_B R_{TH} + V_{BE} + I_E R_E$
3. $I_E \approx I_C = \beta I_B$로 연립 풀기

$$I_C \approx \frac{V_{TH} - V_{BE}}{R_E + R_{TH}/\beta}$$

$$V_{CE} = V_{CC} - I_C(R_C + R_E)$$

---

## 6. 계산 예제

**문제:** NPN BJT, $\beta = 100$, $V_{BE} = 0.7\ \text{V}$
회로: $V_{CC} = 12\ \text{V}$, $R_1 = 56\ \text{k}\Omega$, $R_2 = 12\ \text{k}\Omega$, $R_C = 2.2\ \text{k}\Omega$, $R_E = 560\ \Omega$

**Step 1:** 테브낭 등가

$$V_{TH} = 12 \times \frac{12}{56+12} = 12 \times \frac{12}{68} \approx 2.12\ \text{V}$$

$$R_{TH} = \frac{56 \times 12}{56+12} = \frac{672}{68} \approx 9.88\ \text{k}\Omega$$

**Step 2:** 베이스 루프 KVL

$$I_C \approx \frac{2.12 - 0.7}{560 + 9880/100} = \frac{1.42}{560 + 98.8} = \frac{1.42}{658.8} \approx 2.16\ \text{mA}$$

**Step 3:** 동작점

$$V_{CE} = 12 - 2.16\times10^{-3}(2200 + 560) = 12 - 5.96 \approx 6.04\ \text{V}$$

Q-point: $(V_{CE}, I_C) = (6.04\ \text{V},\ 2.16\ \text{mA})$
→ $V_{CE} > V_{CE,sat} \approx 0.2\ \text{V}$이므로 능동 영역.

---

## 메모

전압분배 바이어스 예제를 테브낭 등가($V_{TH}=2.12$ V, $R_{TH}=9.88\ \text{k}\Omega$)로 풀면 $I_C\approx2.16$ mA, $V_{CE}\approx6.04$ V로 능동 영역이다.
`BF`, `VAF`, `IKF`, `TF`를 바꿨을 때 전류이득 저하, Early 효과, 포화 저장시간이 $I_C=\beta I_B$ 판정을 얼마나 흔드는지는 SPICE로 따로 돌려 봐야 한다.

---

## 참고자료

- [MIT OCW 6.012 Microelectronic Devices and Circuits](https://ocw.mit.edu/courses/6-012-microelectronic-devices-and-circuits-fall-2005/) — BJT 물리 동작 심화
- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 소신호 모델·증폭기 실습
- [OpenStax University Physics Vol.3 Ch.9](https://openstax.org/books/university-physics-volume-3/pages/9-introduction) — 반도체 소자 기초
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.6 — BJT 바이어스·소신호 체계 유도
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., Ch.2 — BJT vs MOSFET 소신호 비교
