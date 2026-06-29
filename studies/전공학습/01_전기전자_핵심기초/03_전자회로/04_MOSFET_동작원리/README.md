# MOSFET 동작원리

## 학습 목표
- NMOS/PMOS의 구조와 채널 형성 원리를 설명할 수 있다.
- 문턱전압 $V_{th}$, 선형·포화·차단 영역의 $I_D$-$V_{DS}$ 특성을 수식으로 표현할 수 있다.
- 채널길이 변조 계수 $\lambda$와 기생 커패시턴스 $C_{gs}$/$C_{gd}$의 영향을 이해한다.
- 전력 MOSFET의 $R_{DS(on)}$, $Q_g$, $V_{BR}$ 관계를 EV OBC 설계에 적용할 수 있다.
- SiC/GaN MOSFET이 Si MOSFET 대비 갖는 성능 이점을 정량적으로 비교할 수 있다.

---

## 1. MOSFET 구조

**NMOS (n채널 Enhancement):**

- P형 기판 위 두 개의 N+ 소스/드레인 확산 영역
- 게이트(다결정 Si 또는 금속) — 산화막(SiO₂, 두께 수 nm ~ 수십 nm) — 기판 구조

```
Gate
 |
[SiO2]
|N+(S)  P-sub  N+(D)|
```

$V_{GS} > V_{th}$이면 P형 기판 표면에 반전층(inversion layer) → N채널 형성.

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 5.1.

---

## 2. 동작 영역과 $I_D$ 수식

### 2-1. 차단(Cutoff) 영역

$$V_{GS} < V_{th} \Rightarrow I_D = 0$$

### 2-2. 선형(Linear/Triode) 영역

$$V_{GS} \geq V_{th},\quad V_{DS} < V_{GS} - V_{th}$$

$$I_D = \mu_n C_{ox} \frac{W}{L}\!\left[(V_{GS}-V_{th})V_{DS} - \frac{V_{DS}^2}{2}\right]$$

$V_{DS} \ll 2(V_{GS}-V_{th})$이면:

$$I_D \approx \mu_n C_{ox}\frac{W}{L}(V_{GS}-V_{th})V_{DS} \equiv \frac{V_{DS}}{R_{DS(on)}}$$

$$R_{DS(on)} = \frac{1}{\mu_n C_{ox}(W/L)(V_{GS}-V_{th})}$$

### 2-3. 포화(Saturation) 영역

$$V_{DS} \geq V_{GS} - V_{th} \quad (\text{핀치오프})$$

$$I_D = \frac{1}{2}\mu_n C_{ox}\frac{W}{L}(V_{GS}-V_{th})^2 (1 + \lambda V_{DS})$$

- $\mu_n C_{ox}$: 공정 트랜스컨덕턴스 파라미터 ($k'_n$)
- $\lambda$: 채널길이 변조 계수 ($\text{V}^{-1}$)

> 참고 도식: Razavi, *Design of Analog CMOS Integrated Circuits* 2판, Fig. 2.12.

---

## 3. 핵심 파라미터

### 3-1. 문턱전압 $V_{th}$

$$V_{th} = V_{FB} + 2\phi_F + \frac{\sqrt{2q\varepsilon_s N_A(2\phi_F)}}{C_{ox}}$$

- $\phi_F = (kT/q)\ln(N_A/n_i)$: 페르미 전위
- Body effect: 기판 전압 $V_{SB} > 0$이면 $V_{th}$ 증가

### 3-2. 트랜스컨덕턴스 $g_m$

포화 영역에서:

$$g_m = \frac{\partial I_D}{\partial V_{GS}} = \mu_n C_{ox}\frac{W}{L}(V_{GS}-V_{th}) = \sqrt{2\mu_n C_{ox}\frac{W}{L}I_D}$$

### 3-3. 출력 저항 $r_o$

$$r_o = \frac{1}{\lambda I_D} = \frac{V_A}{I_D}$$

($V_A = 1/\lambda$: Early 전압과 유사한 개념)

---

## 4. 기생 커패시턴스

| 커패시턴스 | 위치 | 영향 |
|---|---|---|
| $C_{gs}$ | 게이트-소스 | 스위칭 속도 제한의 주요 인자 |
| $C_{gd}$ ($C_{rss}$) | 게이트-드레인 | 밀러 효과 → 유효 입력 커패시턴스 증폭 |
| $C_{ds}$ ($C_{oss}$) | 드레인-소스 | ZVS/ZCS 동작의 에너지 저장 |
| $C_{iss}$ | 입력 커패시턴스 | $C_{iss} = C_{gs} + C_{gd}$ |

게이트 총 전하:

$$Q_g = C_{iss} \cdot \Delta V_{GS} \quad (\text{비선형, 데이터시트 값 사용})$$

스위칭 손실:

$$P_{sw} \approx \frac{1}{2}V_{DS} I_D (t_r + t_f) f_{sw} \propto Q_g$$

---

## 5. 전력 MOSFET — EV OBC 설계 연결

### 5-1. $R_{DS(on)}$ vs $V_{BR}$ 트레이드오프

Si MOSFET: $R_{DS(on)} \propto V_{BR}^{2.5}$
SiC MOSFET: $R_{DS(on)} \propto V_{BR}^{2.5}/E_{crit}^2$ (임계전계 10× 큰 SiC 이점)

같은 $V_{BR} = 650\ \text{V}$ 기준:
- Si: $R_{DS(on)} \approx 100\ \text{m}\Omega$ (예)
- SiC: $R_{DS(on)} \approx 20\ \text{m}\Omega$ (예, 5× 개선)

### 5-2. OBC 설계 시 MOSFET 선정 체크리스트

| 항목 | 요구사항 | 비고 |
|---|---|---|
| $V_{BR}$ | $V_{bus} \times 1.5$ 이상 | 서지 여유 |
| $R_{DS(on)}$ | 도통손실 $P_{cond} = I^2 R_{DS(on)}$ | 전류 실효값으로 계산 |
| $Q_g$ | 게이트드라이버 출력 전류 결정 | $I_{drive} = Q_g \cdot f_{sw}$ |
| $C_{oss}$ | ZVS 영역 결정 | LLC/DAB 공진 설계 |
| $t_{d(off)}$, $t_f$ | 스위칭 손실 | 고주파 PFC에서 중요 |

---

## 6. 계산 예제

**문제:** NMOS, $k'_n = 200\ \mu\text{A/V}^2$, $W/L = 50$, $V_{th} = 0.8\ \text{V}$, $\lambda = 0.02\ \text{V}^{-1}$
$V_{GS} = 3\ \text{V}$, $V_{DS} = 5\ \text{V}$ 일 때 $I_D$, $g_m$, $r_o$를 구하라.

**Step 1:** 포화 여부 확인

$$V_{GS} - V_{th} = 3 - 0.8 = 2.2\ \text{V} < V_{DS} = 5\ \text{V} \Rightarrow \text{포화}$$

**Step 2:** 드레인 전류

$$I_D = \frac{1}{2} \times 200\times10^{-6} \times 50 \times (2.2)^2 \times (1 + 0.02\times5)$$

$$= 5\times10^{-3} \times 4.84 \times 1.10 = 5\times10^{-3}\times5.324 \approx 26.6\ \text{mA}$$

**Step 3:** 트랜스컨덕턴스

$$g_m = k'_n \frac{W}{L}(V_{GS}-V_{th}) = 200\times10^{-6}\times50\times2.2 = 22\ \text{mA/V}$$

**Step 4:** 출력 저항

$$r_o = \frac{1}{\lambda I_D} = \frac{1}{0.02 \times 26.6\times10^{-3}} \approx 1.88\ \text{k}\Omega$$

---

## 7. 실무 연결과 주의점

- **게이트드라이버 전류:** $I_{peak} = Q_g \cdot f_{sw}$에서 일반적인 OBC(100kHz, $Q_g = 50\ \text{nC}$) → $I_{avg} = 5\ \text{mA}$. 드라이버 공급 전원 용량 설계 시 반영.
- **밀러 플래토:** $V_{GS}$ 상승 중 $C_{gd}$ 충전 구간에서 전압이 멈추는 구간 → 이 기간 동안 dv/dt에 의한 커먼모드 노이즈 발생. 게이트 저항 $R_g$로 조절.
- **역방향 다이오드(Body Diode):** 전력 MOSFET 내부 P-N 바디 다이오드 → SiC MOSFET의 바디 다이오드는 역회복이 있으나 SiC SBD 병렬로 보완 가능.
- **온도 특성:** Si MOSFET의 $R_{DS(on)}$은 온도 상승에 따라 양의 온도계수 → 병렬 사용 시 자동 전류 균형(전류 쏠림 방지) 유리.

---

## 8. 자가 점검

1. NMOS가 포화 영역에 진입하는 $V_{DS}$ 조건을 $V_{GS}$와 $V_{th}$로 표현하라.
2. $\lambda = 0$이면 포화 영역에서 $I_D$가 $V_{DS}$와 무관한 이유는?
3. 전력 MOSFET에서 $Q_g$와 $R_{DS(on)}$ 사이에 트레이드오프가 발생하는 이유는?
4. OBC DAB 변환기에서 ZVS 동작을 위해 $C_{oss}$가 작아야 유리한 이유는?

<details><summary>정답</summary>

1. $V_{DS} \geq V_{GS} - V_{th}$ (pinch-off). 이때 드레인 단의 채널이 소멸되어 전류가 공간 전하 이동으로 드레인에 도달.
2. 채널길이 변조($\lambda$)가 0이면 $V_{DS}$ 증가로 인한 채널 단축 효과 없음 → $I_D$는 오직 $(V_{GS}-V_{th})^2$에만 의존 → 이상적인 전류원 특성.
3. 소자 면적 $W/L$ 증가 → $R_{DS(on)} \downarrow$ (도통손실 감소) but $C_{gs}$, $C_{gd}$ 증가 → $Q_g \uparrow$ → 스위칭 손실 증가. 설계는 도통손실과 스위칭손실의 합을 최소화하는 최적점에서 결정.
4. ZVS에서 스위치 온(turn-on) 전 $C_{oss}$에 저장된 에너지를 공진으로 방전해야 하는데, $C_{oss}$가 크면 방전에 필요한 공진 에너지(인덕터 전류)가 커져야 하므로 순환 전류 증가 → 도통손실 증가. $C_{oss}$가 작으면 더 낮은 전류에서도 ZVS 달성 가능.

</details>

---

## 참고자료

- [MIT OCW 6.012 Microelectronic Devices and Circuits](https://ocw.mit.edu/courses/6-012-microelectronic-devices-and-circuits-fall-2005/) — MOSFET 물리 및 I-V 유도
- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — MOSFET 회로 설계 실습
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.5 — MOSFET 특성 곡선·바이어스
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., Ch.2 — 소신호 모델·고주파 특성
- [Infineon Application Note: SiC MOSFET Characterization](https://www.infineon.com/) — 전력 SiC 특성·게이트드라이버 설계
