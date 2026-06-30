# 주파수응답과 필터 기초

## 학습 목표
- 연속·이산 LTI 시스템의 주파수응답 $H(j\omega)$, $H(e^{j\omega})$ 정의와 크기·위상 분리를 수행할 수 있다.
- 저역·고역·대역통과·대역저지 필터의 이상 특성과 실제 사양을 정의할 수 있다.
- Butterworth·Chebyshev·Bessel 필터의 설계 기준과 트레이드오프를 비교 설명할 수 있다.
- 전류·전압 센서 AAF의 사양을 주어진 OBC 제어 대역으로부터 도출할 수 있다.
- 보드선도를 그리고 -3 dB 주파수, 위상 마진 기초를 읽을 수 있다.

---

## 1. 연속 LTI 주파수응답

LTI 시스템에 복소 정현파 $e^{j\omega t}$를 입력하면 출력도 같은 주파수의 복소 정현파이며, 계수가 $H(j\omega)$이다.

$$x(t)=e^{j\omega t} \to y(t) = H(j\omega)\,e^{j\omega t}$$

$$H(j\omega) = \int_{-\infty}^{\infty} h(t)\,e^{-j\omega t}\,dt = \mathcal{F}\{h(t)\}$$

즉 **주파수응답 = 임펄스응답의 푸리에 변환**.

**크기응답(진폭특성):** $|H(j\omega)|$ — 주파수 $\omega$에서 신호의 이득

**위상응답:** $\angle H(j\omega)$ — 주파수 $\omega$에서 신호의 위상 변화

---

## 2. 이산 LTI 주파수응답

$$H(e^{j\omega}) = \sum_{n=-\infty}^{\infty} h[n]\,e^{-j\omega n} = H(z)\big|_{z=e^{j\omega}}$$

- $\omega \in [-\pi, \pi]$ [rad/sample]
- **$2\pi$ 주기성**: $H(e^{j(\omega+2\pi)}) = H(e^{j\omega})$
- 나이퀴스트 주파수: $\omega = \pi$ (연속 $f = f_s/2$)

물리적 주파수 환산:

$$f = \frac{\omega}{2\pi T_s} = \frac{\omega\,f_s}{2\pi}$$

---

## 3. 이상 필터 특성

### 3.1 저역통과 (Low-Pass Filter, LPF)

$$H_{\text{LPF}}(j\omega) = \begin{cases} 1, & |\omega| \leq \omega_c \\ 0, & |\omega| > \omega_c \end{cases}$$

임펄스응답: $h(t) = \frac{\omega_c}{\pi}\text{sinc}\!\left(\frac{\omega_c t}{\pi}\right)$ — 비인과적(non-causal)이므로 실제 구현 불가.

### 3.2 고역통과 (High-Pass Filter, HPF)

$$H_{\text{HPF}} = 1 - H_{\text{LPF}}$$

### 3.3 대역통과 (Band-Pass Filter, BPF)

$$H_{\text{BPF}}(j\omega) = \begin{cases} 1, & \omega_1 \leq |\omega| \leq \omega_2 \\ 0, & \text{otherwise} \end{cases}$$

### 3.4 대역저지 (Band-Stop / Notch Filter)

$$H_{\text{BSF}} = 1 - H_{\text{BPF}}$$

---

## 4. 실제 필터 사양

| 사양 파라미터 | 설명 |
|-------------|------|
| 통과대역 엣지 $f_p$ | 이 주파수까지 최대 $R_p$ dB 리플 허용 |
| 저지대역 엣지 $f_s$ | 이 주파수 이상 최소 $A_s$ dB 감쇠 필요 |
| 전이대역 | $f_p$와 $f_s$ 사이 — 감쇠가 점진적으로 증가 |
| 리플 $R_p$ | 통과대역 최대 허용 이득 변동 (전형적 0.5~3 dB) |
| 저지대역 감쇠 $A_s$ | 저지대역 최소 감쇠 (전형적 40~60 dB) |

---

## 5. 필터 유형 비교

### 5.1 Butterworth 필터

크기응답이 최대한 평탄(maximally flat):

$$|H(j\omega)|^2 = \frac{1}{1 + (\omega/\omega_c)^{2N}}$$

- 통과대역에서 리플 없음(단조 감쇠)
- 전이대역 감쇠 중간 수준
- 위상 선형성 중간
- $N$차 Butterworth의 -3 dB 주파수 = $\omega_c$

차수 공식 (사양으로부터):

$$N = \frac{\log\!\left[\frac{10^{A_s/10}-1}{10^{R_p/10}-1}\right]}{2\log(f_s/f_p)}$$

### 5.2 Chebyshev Type I 필터

통과대역 내 등리플(equiripple), 전이대역 감쇠 더 가파름:

- **Type I**: 통과대역 리플, 저지대역 단조
- **Type II**: 통과대역 단조, 저지대역 리플
- 같은 차수에서 Butterworth보다 전이대역 날카로움
- 단점: 통과대역 위상 비선형성 증가

### 5.3 Elliptic (Cauer) 필터

통과대역·저지대역 모두 등리플:
- 같은 차수에서 가장 날카로운 전이대역
- 위상 비선형성 가장 심함

### 5.4 Bessel 필터

통과대역 내 **최대 선형 위상** (=일정 군지연):

$$\tau_g(\omega) = -\frac{d}{d\omega}\angle H(j\omega) = \text{const}$$

- 임펄스응답 오버슈트 최소
- 전이대역 감쇠 가장 완만
- 파형 보존이 중요한 곳에 사용 (ADC 입력, CAN 버스 등)

### 필터 유형 트레이드오프 요약

| 특성 | Butterworth | Cheby I | Elliptic | Bessel |
|------|:-----------:|:-------:|:--------:|:------:|
| 통과대역 평탄도 | 최고 | 중 | 중 | 중 |
| 전이대역 감쇠 | 중 | 좋음 | 최고 | 최저 |
| 위상 선형성 | 중 | 나쁨 | 최악 | 최고 |
| 군지연 일정 | X | X | X | O |

---

## 6. 보드선도 (Bode Plot) 기초

$H(j\omega) = K \cdot \frac{\prod(1+j\omega/z_k)}{\prod(1+j\omega/p_k)}$에서

**크기:** $20\log_{10}|H(j\omega)|$ [dB]

**위상:** $\angle H(j\omega) = \angle K + \sum\angle(1+j\omega/z_k) - \sum\angle(1+j\omega/p_k)$

1차 극점 $p$의 점근선 근사:

- $\omega \ll p$: 0 dB, 0°
- $\omega = p$: $-3$ dB, $-45°$
- $\omega \gg p$: $-20$ dB/decade, $-90°$

---

## 7. 계산 예제

### 예제 1 — 1차 RC 저역통과 주파수응답

$R = 10\,\text{k}\Omega$, $C = 1.6\,\text{nF}$ → $f_c = \frac{1}{2\pi RC} = 10\,\text{kHz}$

$$H(j\omega) = \frac{1}{1 + j\omega/\omega_c}, \quad \omega_c = 2\pi\times 10^4$$

| $f$ (Hz) | $\omega/\omega_c$ | $|H|$ | $|H|$ (dB) | $\angle H$ |
|---------|-----------------|-------|-----------|-----------|
| 1 k | 0.1 | 0.995 | $-0.04$ dB | $-5.7°$ |
| 10 k | 1.0 | $1/\sqrt{2}$ | $-3$ dB | $-45°$ |
| 100 k | 10 | 0.0995 | $-20$ dB | $-84.3°$ |
| 1 M | 100 | 0.01 | $-40$ dB | $-89.4°$ |

### 예제 2 — Butterworth 차수 결정

**OBC AAF 사양:** $f_p = 2\,\text{kHz}$ ($R_p = 1\,\text{dB}$), $f_s = 31.25\,\text{kHz}$ ($A_s = 40\,\text{dB}$)

$$N \geq \frac{\log\!\left[\frac{10^4-1}{10^{0.1}-1}\right]}{2\log(31.25/2)} = \frac{\log\!\left[\frac{9999}{0.259}\right]}{2\log(15.625)} = \frac{\log(38610)}{2\times 1.194} = \frac{4.587}{2.388} \approx 1.92$$

→ $N = 2$ (2차 Butterworth) 선택.

**2차 Butterworth 전달함수** (컷오프 $\omega_c = 2\pi \times 2\,\text{kHz}$):

$$H(s) = \frac{\omega_c^2}{s^2 + \sqrt{2}\,\omega_c\, s + \omega_c^2}$$

극점: $p_{1,2} = \omega_c e^{j\frac{3\pi}{4}}, \omega_c e^{-j\frac{3\pi}{4}}$ (LHP, 안정)

### 예제 3 — 이산 주파수응답 계산

1차 IIR (단원 08 예제): $H(z) = \frac{1}{1-0.8z^{-1}}$

$$H(e^{j\omega}) = \frac{1}{1-0.8e^{-j\omega}}$$

$\omega = 0$: $H = \frac{1}{0.2} = 5$ (DC 이득 5 = 14 dB)

$\omega = \pi$: $H = \frac{1}{1+0.8} = \frac{1}{1.8} \approx 0.556$ ($-5.1$ dB)

→ 저역통과 특성.

---

## 학습·검증 기록

- **핵심 정리:** 주파수응답의 크기와 위상은 주파수별 이득과 지연을 나타내며, 필터 종류와 차수는 통과대역 평탄도·차단 기울기·위상 특성의 절충으로 선택한다.
- **확인 근거:** 차단주파수 약 $10\ \text{kHz}$인 1차 RC 저역통과 예제에서 $10\ \text{kHz}$ 응답은 $-3\ \text{dB}$, $-45°$이고, 한 decade 높은 $100\ \text{kHz}$에서는 약 $-20\ \text{dB}$, $-84.3°$로 계산되었다.
- **다음 탐구:** 상호 부하가 없는 동일한 1차 RC 전달함수 두 개를 연결해 $1$, $10$, $100\ \text{kHz}$에서 전체 크기와 위상을 더하고, 1차와 2차의 차단 이후 기울기를 비교할 것이다.

---

## 참고자료

- [MIT OCW 6.003 Lecture 12–14 — Frequency Response and Filtering](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — LTI 주파수응답, 필터 이상 특성
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 6](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — 연속·이산 주파수응답
- [MathWorks — Filter Design and Analysis Tool (`fdatool` / `filterDesigner`)](https://www.mathworks.com/help/signal/ref/filterdesigner-app.html) — Butterworth/Cheby/Bessel 차수·계수 설계
- [MathWorks — `butter`, `cheby1`, `besself` functions](https://www.mathworks.com/help/signal/ref/butter.html) — MATLAB 아날로그/디지털 필터 계수 계산
