# 바이어스와 소신호 모델

## 1. 직류 바이어스 — 4저항 바이어스 (BJT NPN)

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 6.34.

**설계 절차:**

1. 목표 $I_C$, $V_{CE}$ 결정 (부하선 중앙 근방)
2. $V_E = I_E R_E \approx I_C R_E$ (이미터 전압, 보통 $V_{CC}/10$ 내외)
3. $V_B = V_E + 0.7$
4. 전압분배: $R_1$, $R_2$ 선택 ($I_{div} \gg I_B$ 조건: $I_{div} \geq 10 I_B$)
5. $R_C$: $V_{CE} = V_{CC} - I_C(R_C + R_E)$에서 결정

**안정성 지표:**

$$S = \frac{\partial I_C}{\partial I_{CO}} \approx \frac{\beta+1}{1+\beta R_E/(R_1\|R_2)}$$

$S$ 작을수록 안정 ($R_E$ 증가, $R_1 \| R_2$ 감소 시 개선).

---

## 2. MOSFET 직류 바이어스

**전압분배 바이어스 (Enhancement NMOS):**

$$V_G = V_{DD}\frac{R_2}{R_1+R_2}, \quad V_{GS} = V_G - I_D R_S$$

포화 가정:

$$I_D = \frac{k'_n W}{2L}(V_{GS}-V_{th})^2$$

연립 방정식을 풀어 $I_D$, $V_{DS}$ 결정.

MOSFET은 $I_G = 0$ → 게이트 전류 없음 → 전압분배 소자 선택 자유도 높음.

---

## 3. BJT 소신호 π-모델

능동 영역 소신호 등가 (저주파):

$$g_m = \frac{I_C}{V_T} = \frac{I_C}{26\ \text{mV}}$$

$$r_\pi = \frac{\beta}{g_m} = \frac{V_T}{I_B}$$

$$r_o = \frac{V_A}{I_C}$$

| 파라미터 | 물리 의미 | 전형값 ($I_C = 1\ \text{mA}$, $\beta=100$) |
|---|---|---|
| $g_m$ | 전달컨덕턴스 | $1\ \text{mA}/26\ \text{mV} \approx 38.5\ \text{mA/V}$ |
| $r_\pi$ | 베이스-이미터 저항 | $\beta/g_m = 100/0.0385 \approx 2.6\ \text{k}\Omega$ |
| $r_o$ | 출력 저항 | $V_A/I_C$, 보통 $10\sim100\ \text{k}\Omega$ |

**고주파 π-모델 추가 소자:**

$$C_\pi = C_{diff} + C_{je}, \quad C_\mu = C_{bc}$$

트랜지션 주파수:

$$f_T = \frac{g_m}{2\pi(C_\pi + C_\mu)}$$

---

## 4. MOSFET 소신호 모델

포화 영역에서:

$$g_m = \sqrt{2k'_n\frac{W}{L}I_D} = \frac{2I_D}{V_{GS}-V_{th}}$$

$$r_o = \frac{1}{\lambda I_D}$$

소신호 등가회로: 게이트($G$) — $C_{gs}$ — 소스($S$), $G$-$D$ 간 $C_{gd}$, $D$-$S$ 간 전류원 $g_m v_{gs} \| r_o$.

BJT와 MOSFET 비교:

| 항목 | BJT | MOSFET |
|---|---|---|
| $g_m$ 결정 | $I_C/V_T$ (선형) | $\sqrt{2k'_n(W/L)I_D}$ (제곱근) |
| 입력 저항 | $r_\pi$ (유한) | 무한대 (DC) |
| 잡음 | 샷 노이즈 지배 | 열잡음($4kT\gamma g_m$) 지배 |

---

## 5. 소신호 회로 해석 — 공통이미터 증폭기

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 6.54.

바이패스 캐패시터 $C_E$로 $R_E$ 단락, $C_C$로 DC 차단 가정.

**전압이득:**

$$A_v = \frac{v_o}{v_i} = -g_m(R_C \| r_o \| R_L)$$

**입력 저항:**

$$R_{in} = R_1 \| R_2 \| r_\pi$$

**출력 저항:**

$$R_{out} = R_C \| r_o$$

---

## 6. 계산 예제

**문제:** NPN BJT 공통이미터 증폭기
$V_{CC}=15\ \text{V}$, $R_1=100\ \text{k}\Omega$, $R_2=47\ \text{k}\Omega$, $R_C=4.7\ \text{k}\Omega$, $R_E=1.5\ \text{k}\Omega$, $R_L=10\ \text{k}\Omega$
$\beta=120$, $V_A=80\ \text{V}$, $T=300\text{K}$

**Step 1:** DC 동작점

$$V_B = 15\times\frac{47}{147} \approx 4.80\ \text{V}, \quad V_E = 4.80-0.7 = 4.10\ \text{V}$$

$$I_C \approx I_E = \frac{4.10}{1500} \approx 2.73\ \text{mA}$$

$$V_{CE} = 15 - 2.73\times10^{-3}\times(4700+1500) = 15 - 16.9 \approx -1.9\ \text{V}$$

→ $V_{CE} < 0$이면 포화 → $R_C$를 줄여 재설계 필요.
수정: $R_C = 2.2\ \text{k}\Omega$ 사용 시:

$$V_{CE} = 15 - 2.73\times10^{-3}\times(2200+1500) = 15 - 10.1 \approx 4.9\ \text{V}$$

**Step 2:** 소신호 파라미터

$$g_m = \frac{2.73\times10^{-3}}{0.026} \approx 105\ \text{mA/V}$$

$$r_\pi = \frac{120}{0.105} \approx 1.14\ \text{k}\Omega$$

$$r_o = \frac{80}{2.73\times10^{-3}} \approx 29.3\ \text{k}\Omega$$

**Step 3:** 전압이득 (바이패스 캐패시터 완전 단락 가정)

$$A_v = -g_m(R_C \| r_o \| R_L) = -0.105\times(2.2\text{k} \| 29.3\text{k} \| 10\text{k})$$

$$= -0.105 \times 1.70\ \text{k}\Omega \approx -178$$

---

## 메모

예제는 $R_C=4.7\ \text{k}\Omega$에서 $V_{CE}\approx-1.9$ V가 나와 능동 영역 가정이 깨진다. $R_C=2.2\ \text{k}\Omega$로 바꾸면 $I_C\approx2.73$ mA, $V_{CE}\approx4.9$ V이고, $g_m\approx105$ mA/V, $r_\pi\approx1.14\ \text{k}\Omega$, $r_o\approx29.3\ \text{k}\Omega$로 $A_v\approx-178$이다.
SPICE에서 온도별 `IS`·`BF`·`VAF`와 $R_E$를 바꿔 Q-point가 움직일 때 $g_m$, $r_\pi$, 이득이 얼마나 따라 변하는지 볼 것.

---

## 참고자료

- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 소신호 모델 유도와 증폭기 해석
- [MIT OCW 6.012 Microelectronic Devices and Circuits](https://ocw.mit.edu/courses/6-012-microelectronic-devices-and-circuits-fall-2005/) — $g_m$, $r_o$ 물리적 기원
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.6 — BJT 바이어스·소신호 체계
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., Ch.3 — MOSFET 소신호·고주파 모델
- [OpenStax University Physics Vol.3](https://openstax.org/books/university-physics-volume-3/pages/9-introduction) — 반도체 기초 복습
