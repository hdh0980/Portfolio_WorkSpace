# 발진기

## 학습 목표
- Barkhausen 기준을 이용해 발진 조건(이득·위상)을 판별할 수 있다.
- RC 위상편이, 빈브리지, 콜피츠, 하틀리 발진기의 발진 주파수를 유도할 수 있다.
- 진폭 안정화(AGC) 메커니즘의 필요성과 구현 방법을 이해한다.
- PLL의 구성 블록과 위상 잠금 원리를 설명할 수 있다.
- OBC 게이트드라이버 발진 방지와 클록 생성에의 연결을 이해한다.

---

## 1. Barkhausen 발진 기준

피드백 시스템 $T(j\omega) = A(j\omega)\beta(j\omega)$에서 발진 조건:

$$|A(j\omega_0)\beta(j\omega_0)| = 1 \quad (\text{이득 조건})$$

$$\angle A(j\omega_0)\beta(j\omega_0) = 0° \text{ (또는 } 360°) \quad (\text{위상 조건})$$

- 이득 > 1: 진폭 증가 (발진 성장)
- 이득 = 1: 지속 발진 (안정 발진기)
- 이득 < 1: 진폭 감쇠 (발진 사멸)

실제 회로는 이득 > 1로 시작 후 비선형 포화로 자동 안정화.

---

## 2. RC 위상편이 발진기

3단 RC 사다리 + 반전 증폭기(-180°)로 구성.

각 RC 단이 $-60°$ 위상 편이 → 총 $-180°$ → 반전 증폭기의 $-180°$와 합산 = $-360°$ = 발진 조건.

**발진 주파수:**

$$f_0 = \frac{1}{2\pi\sqrt{6}\,RC}$$

**최소 이득 조건:**

$$|A_v| \geq 29$$

> 참고 도식: Sedra & Smith, *Microelectronic Circuits* 8판, Fig. 17.7.

계산 예: $R = 10\ \text{k}\Omega$, $C = 1\ \text{nF}$:

$$f_0 = \frac{1}{2\pi\sqrt{6}\times10^4\times10^{-9}} = \frac{1}{2\pi\times2.449\times10^{-5}} \approx 6.50\ \text{kHz}$$

---

## 3. 빈브리지 발진기 (Wien Bridge)

저역통과 + 고역통과 조합으로 $0°$ 위상편이 달성.

**발진 주파수:**

$$f_0 = \frac{1}{2\pi RC}$$

**이득 조건:** 비반전 증폭기 이득 = 3 (즉 $R_f = 2R_1$).

실제 진폭 안정화: 열저항 소자(램프 필라멘트) 또는 AGC 회로로 이득을 3에 고정.

계산 예: $R = 15.9\ \text{k}\Omega$, $C = 10\ \text{nF}$:

$$f_0 = \frac{1}{2\pi\times15.9\times10^3\times10^{-8}} \approx 1.0\ \text{kHz}$$

---

## 4. 콜피츠 발진기 (Colpitts)

LC 탱크 회로 기반. 두 캐패시터 $C_1$, $C_2$와 인덕터 $L$로 구성.

**발진 주파수:**

$$f_0 = \frac{1}{2\pi\sqrt{L\,C_{eq}}}, \quad C_{eq} = \frac{C_1 C_2}{C_1+C_2}$$

**이득 조건:**

$$g_m R \geq \frac{C_1}{C_2}$$

특징: RF 발진기에 주로 사용, 높은 Q-factor, 안정적인 주파수.

계산 예: $L = 1\ \mu\text{H}$, $C_1 = C_2 = 100\ \text{pF}$:

$$C_{eq} = 50\ \text{pF}$$

$$f_0 = \frac{1}{2\pi\sqrt{10^{-6}\times50\times10^{-12}}} = \frac{1}{2\pi\times7.07\times10^{-9}} \approx 22.5\ \text{MHz}$$

---

## 5. 하틀리 발진기 (Hartley)

콜피츠와 쌍대(dual) 구조. 두 인덕터 $L_1$, $L_2$와 캐패시터 $C$.

**발진 주파수:**

$$f_0 = \frac{1}{2\pi\sqrt{(L_1+L_2+2M)\,C}}$$

($M$: 상호 인덕턴스. 독립이면 $M=0$)

계산 예: $L_1 = L_2 = 1\ \mu\text{H}$($M=0$), $C = 100\ \text{pF}$:

$$f_0 = \frac{1}{2\pi\sqrt{2\times10^{-6}\times10^{-10}}} = \frac{1}{2\pi\times14.1\times10^{-9}} \approx 11.3\ \text{MHz}$$

---

## 6. PLL (Phase-Locked Loop) 기초

**기본 구성 블록:**

```
Ref → [위상검출기] → [저역통과 필터] → [VCO] → 출력
              ↑__________________________|
                   (피드백, 분주기 N)
```

- **PD (위상검출기):** 기준 신호와 VCO 출력의 위상 오차를 전압으로 변환
- **LPF:** 고주파 위상검출기 출력 제거, 루프 대역폭 결정
- **VCO (전압제어발진기):** 제어 전압에 비례해 주파수 변환
  $f_{VCO} = f_0 + K_{VCO} \cdot V_{ctrl}$

**분주비 N이 있을 때:**

$$f_{out} = N \cdot f_{ref}$$

**잠금 범위:**

$$f_{lock} \approx \frac{K_{PD} \cdot K_{VCO}}{N} \cdot \text{LPF 대역폭}$$

---

## 7. 계산 예제

**문제:** 빈브리지 발진기. $R = 10\ \text{k}\Omega$, $C = 15.9\ \text{nF}$.
(a) 발진 주파수, (b) 발진 조건 이득, (c) $R_f$ 설계 ($R_1 = 10\ \text{k}\Omega$).

**(a) 발진 주파수:**

$$f_0 = \frac{1}{2\pi\times10^4\times15.9\times10^{-9}} = \frac{1}{2\pi\times1.59\times10^{-4}} \approx 1.0\ \text{kHz}$$

**(b) 이득 조건:**

비반전 증폭기 이득 = 3 (빈브리지 이론).

**(c) $R_f$ 설계:**

$$A_v = 1+\frac{R_f}{R_1} = 3 \Rightarrow R_f = 2R_1 = 20\ \text{k}\Omega$$

실제: $R_f = 22\ \text{k}\Omega$ (표준값, 이득 3.2)로 시작해 진폭 포화까지 가도록 설계.

---

## 8. 실무 연결과 주의점

- **OBC 게이트드라이버 기생 발진:** PCB 레이아웃에 의한 기생 인덕턴스 $L_{par}$와 MOSFET $C_{iss}$ 간 LC 공진 → Barkhausen 발진 조건을 만족하면 게이트 드라이브 라인에서 고주파 링잉(ringing) 발생. $R_g$ 증가 또는 페라이트 비드로 Q 저하.
- **OBC DSP 클록 생성:** 내부 PLL로 외부 저속 크리스탈(8 MHz)에서 고속 코어 클록(100~400 MHz) 생성. 잠금 시간(lock time)과 위상 노이즈가 ADC 샘플링 타이밍 지터에 영향.
- **LLC 공진 주파수 정밀도:** LLC 컨버터의 공진 주파수 $f_r = 1/(2\pi\sqrt{LC_r})$이 온도에 따라 변화 → 인덕터 $L$의 코어 포화 특성과 열 계수가 발진 안정성에 영향.
- **EMI 스펙트럼 확산:** 스위칭 주파수를 소폭 변조(Frequency Spread Spectrum, FSS)하면 첨두 EMI 방사를 $3\sim6\ \text{dB}$ 감소. 내부 발진기 변조로 구현.

---

## 9. 자가 점검

1. RC 위상편이 발진기에서 RC 단 수를 3개가 아닌 4개로 늘리면 발진 주파수는 어떻게 변하는가?
2. Barkhausen 기준에서 이득 조건만 만족하고 위상 조건을 만족하지 못하면 어떻게 되는가?
3. PLL에서 분주비 N을 2배로 늘리면 출력 주파수는 어떻게 되는가?
4. 콜피츠 발진기에서 $C_1/C_2$ 비율이 이득 조건에 영향을 주는 이유는?

<details><summary>정답</summary>

1. 4단 RC: 각 단의 위상 이동이 $-45°$ → 총 $-180°$. 발진 주파수는 $f_0 = 1/(2\pi RC\sqrt{1/\tan(45°)\cdots}$ 방식으로 변경. 일반적으로 단 수가 늘면 발진 주파수가 낮아지고 최소 이득 요구값도 변함.
2. 위상 조건이 없으면 루프 신호가 입력과 위상이 맞지 않아 보강 간섭 불가 → 특정 주파수에서 $|T| > 1$이어도 자체 강화가 안 됨 → 발진 불발생. 두 조건을 동시에 만족하는 $\omega_0$에서만 발진.
3. $f_{out} = N \cdot f_{ref}$이므로 N을 2배로 늘리면 출력 주파수도 2배 증가. 잠금된 상태에서 PLL은 VCO 출력을 $f_{ref}$의 N배로 유지.
4. 콜피츠 피드백비 $\beta = C_2/(C_1+C_2)$ (또는 $C_1/C_2$ 분압). 발진 이득 조건 $|A_v| \geq C_1/C_2$. $C_1$ 증가 → 더 높은 이득 필요 → 발진기 설계에서 트랜지스터 $g_m$이 조건을 만족해야 함.

</details>

---

## 참고자료

- [MIT OCW 6.002 Circuits and Electronics](https://ocw.mit.edu/courses/6-002-circuits-and-electronics-spring-2007/) — 발진기 회로 기초
- [MIT OCW 6.301 Solid State Circuits](https://ocw.mit.edu/courses/6-301-solid-state-circuits-fall-2010/) — LC 발진기·PLL
- Sedra & Smith, *Microelectronic Circuits* 8th ed., Ch.17 — RC·LC 발진기 전체 체계
- Razavi, *Design of Analog CMOS Integrated Circuits* 2nd ed., Ch.14~15 — 발진기·PLL CMOS 설계
- [Texas Instruments SLAA617: PLL Fundamentals](https://www.ti.com/) — PLL 설계 실전 안내
