# 샘플링과 복원

6절 예제 2에서 OBC 전류 센싱 ADC(62.5 kHz 스위칭 동기 샘플링)의 AAF 조건을 잡고, 필터 차수 계산은 단원 09 예제 2로 넘긴다.

---

## 1. 이상 샘플링 (Ideal Sampling)

연속신호 $x(t)$를 임펄스열 $p(t)$로 곱하여 샘플링한다.

$$p(t) = \sum_{n=-\infty}^{\infty} \delta(t - nT_s), \quad f_s = \frac{1}{T_s}$$

$$x_s(t) = x(t)\cdot p(t) = \sum_{n=-\infty}^{\infty} x(nT_s)\,\delta(t - nT_s)$$

### 1.1 스펙트럼 복제

$p(t)$의 푸리에 변환: $P(j\omega) = \frac{2\pi}{T_s}\sum_{k=-\infty}^{\infty}\delta(\omega - k\omega_s)$, $\omega_s = 2\pi f_s$

시간 영역 곱 → 주파수 영역 컨볼루션:

$$X_s(j\omega) = \frac{1}{2\pi}X(j\omega)*P(j\omega) = \frac{1}{T_s}\sum_{k=-\infty}^{\infty} X(j(\omega - k\omega_s))$$

샘플링된 스펙트럼 $X_s$는 원래 스펙트럼 $X$의 **주기적 복제**이다.

---

## 2. 나이퀴스트 정리 (Nyquist-Shannon Sampling Theorem)

대역 제한 신호 $x(t)$의 최고 주파수가 $\omega_M$ (rad/s, 즉 $f_M$ Hz)일 때:

$$\boxed{f_s \geq 2f_M \quad \Leftrightarrow \quad \omega_s \geq 2\omega_M}$$

이 조건을 만족할 때만 복제본들이 겹치지 않아 원신호를 완전 복원할 수 있다.

- $f_s = 2f_M$: 나이퀴스트 레이트 (최소 샘플링 주파수)
- 실제 시스템: 보통 $f_s = 5 \sim 10 \times f_M$ 이상 사용 (안전 마진)

---

## 3. 에일리어싱 (Aliasing)

$f_s < 2f_M$이면 스펙트럼 복제본들이 겹쳐 원신호 정보가 파괴된다.

$$\text{에일리어스 주파수: } f_a = |f - k f_s|, \quad k = \text{round}(f/f_s)$$

> 참고 도식: Oppenheim & Willsky, *Signals and Systems* 2판, Fig. 7.14.

**예:** $f_s = 1000\,\text{Hz}$로 $f = 800\,\text{Hz}$ 신호 샘플링:

에일리어스 = $|800 - 1000| = 200\,\text{Hz}$ — 원래 없던 200 Hz 성분이 나타남.

---

## 4. 이상 복원 (Ideal Reconstruction)

이상 저역통과 필터(ILPF) 적용:

$$H_r(j\omega) = \begin{cases} T_s, & |\omega| < \omega_s/2 \\ 0, & |\omega| \geq \omega_s/2 \end{cases}$$

출력: $X_r(j\omega) = X_s(j\omega)\cdot H_r(j\omega) = X(j\omega)$ (에일리어싱 없을 때)

시간 영역: sinc 보간

$$x_r(t) = \sum_{n=-\infty}^{\infty} x(nT_s)\,\text{sinc}\!\left(\frac{t - nT_s}{T_s}\right)$$

에일리어싱이 없으면 샘플 값을 sinc로 보간한 결과가 원신호와 같다.

---

## 5. 실제 ADC와 안티-에일리어싱 필터

### 5.1 실제 ADC의 제약

| 항목 | 이상 모델 | 실제 ADC |
|------|---------|---------|
| 샘플링 | 임펄스 | 유한 폭 aperture |
| 복원 | ILPF (sinc 보간) | ZOH(영차유지) DAC |
| 양자화 | 무한 비트 | $N$ 비트 (양자화 잡음) |

### 5.2 안티-에일리어싱 필터 (AAF) 설계

에일리어싱 방지를 위해 ADC 전단에 **아날로그 저역통과 필터**를 배치한다.

$$f_{\text{cutoff, AAF}} < f_s / 2$$

**설계 절차:**

1. 관심 대역 $f_{\text{sig}}$ 결정 → $f_s = 5 \sim 10 \times f_{\text{sig}}$ 선정
2. 폴딩 주파수 $f_s/2$에서 충분한 감쇠(예: -40 dB 이상) 확보
3. 필터 차수와 컷오프 결정 (Butterworth/Chebyshev 타협)

---

## 6. 계산 예제

### 예제 1 — 나이퀴스트 레이트

$x(t) = 3\cos(2\pi \cdot 500 t) + 2\sin(2\pi \cdot 1200 t)$

최고 주파수: $f_M = 1200\,\text{Hz}$

나이퀴스트 레이트: $f_s \geq 2 \times 1200 = \boxed{2400\,\text{Hz}}$

실무 권장: $f_s = 8000\,\text{Hz}$ (나이퀴스트 레이트의 약 3.3배)

### 예제 2 — EV OBC ADC 사양 도출

**조건:**
- 전류 루프 제어 대역: $f_{\text{loop}} = 2\,\text{kHz}$
- 스위칭 주파수: $f_{\text{sw}} = 62.5\,\text{kHz}$
- ADC 샘플링: $f_s = 62.5\,\text{kHz}$ (스위칭 동기)

**폴딩 주파수:** $f_s/2 = 31.25\,\text{kHz}$

**요구 AAF:**
- 통과대역: $f \leq 2\,\text{kHz}$ 내 평탄 ($\leq 0.5\,\text{dB}$ 리플)
- 저지대역: $f \geq 31.25\,\text{kHz}$에서 $-40\,\text{dB}$ 이상 감쇠

**1차 RC 필터 예:**

$$R = 1\,\text{k}\Omega, \quad C = \frac{1}{2\pi f_c \cdot R} = \frac{1}{2\pi \times 10\,\text{kHz} \times 10^3} \approx 15.9\,\text{nF}$$

컷오프 $f_c = 10\,\text{kHz}$일 때 $31.25\,\text{kHz}$에서 감쇠:

$$20\log_{10}\!\left(\frac{f_c}{\sqrt{f_c^2+f^2}}\right) \approx 20\log_{10}\!\frac{10}{32.8} \approx -10.3\,\text{dB}$$

1차로 부족 → 2차 이상 Butterworth 사용 (단원 09 참고).

### 예제 3 — 에일리어싱 계산

$f_s = 8000\,\text{Hz}$, 입력에 $f = 9500\,\text{Hz}$ 성분 존재.

$$f_a = |9500 - 8000| = 1500\,\text{Hz}$$

원래 없던 1500 Hz 성분이 기저 대역에 나타난다.

---

## 메모

최고 1.2 kHz 신호의 나이퀴스트 레이트는 2.4 kHz이고, $f_s=8$ kHz에서 9.5 kHz 성분은 $|9.5-8|=1.5$ kHz로 접힌다. AAF를 1차 RC($f_c=10$ kHz, 15.9 nF)로 두면 31.25 kHz에서 $-10.3$ dB밖에 안 나온다.
같은 1.2 kHz 신호를 2.4, 4, 8 kHz로 샘플링했을 때 복제본 위치와 복원 필터 전이대역 여유를 각각 계산해 볼 것.

---

## 참고자료

- [MIT OCW 6.003 Lecture 11 — Sampling](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/pages/lecture-notes/) — 나이퀴스트 정리, 에일리어싱
- [Oppenheim & Willsky, *Signals and Systems* 2판 Ch. 7](https://www.pearson.com/en-us/subject-catalog/p/signals-and-systems/P200000003361) — 샘플링 이론과 복원
- [MathWorks — Anti-Aliasing Filter Design](https://www.mathworks.com/help/signal/ug/practical-introduction-to-digital-filtering.html) — MATLAB 안티-에일리어싱 필터 설계
- [MathWorks — `nyquist` and ADC Model](https://www.mathworks.com/help/signal/ref/aliasfreq.html) — 에일리어스 주파수 계산
