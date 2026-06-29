# 전자파와 전송선

## 학습 목표

- 균일 평면파의 파동방정식을 유도하고 위상속도·파수·파장을 계산한다.
- 전송선 방정식(텔레그래퍼 방정식)을 유도하고 분산 정수 모델을 이해한다.
- 반사계수와 투과계수, 정재파비(SWR)를 계산한다.
- 임피던스 변환(λ/4 변환기, 단락·개방 스텁)을 해석한다.
- 임피던스 정합이 전력 전송 효율과 EMI에 미치는 영향을 설명한다.

## 1. 균일 평면파

맥스웰 방정식에서 무손실 매질($\sigma=0$, $\varepsilon$, $\mu$)의 전계·자계 파동방정식:

$$
\nabla^2\mathbf{E} - \mu\varepsilon\frac{\partial^2\mathbf{E}}{\partial t^2} = \mathbf{0}
$$

$z$방향으로 진행하는 $x$-편광 균일 평면파:

$$
\mathbf{E} = E_0\cos(\omega t - \beta z)\hat{\mathbf{x}}
$$

$$
\mathbf{H} = \frac{E_0}{\eta}\cos(\omega t - \beta z)\hat{\mathbf{y}}
$$

**위상상수**:
$$
\beta = \omega\sqrt{\mu\varepsilon} \quad [\text{rad/m}]
$$

**파동 임피던스**:
$$
\eta = \sqrt{\frac{\mu}{\varepsilon}} \quad [\Omega], \quad \eta_0 = \sqrt{\frac{\mu_0}{\varepsilon_0}} = 377\;\Omega
$$

**위상속도**:
$$
v_p = \frac{\omega}{\beta} = \frac{1}{\sqrt{\mu\varepsilon}} = \frac{c}{\sqrt{\mu_r\varepsilon_r}}
$$

**파장**:
$$
\lambda = \frac{2\pi}{\beta} = \frac{v_p}{f}
$$

## 2. 손실 매질에서의 전자파

손실 매질($\sigma\neq0$)에서 파수가 복소수가 된다:

$$
\gamma = \alpha + j\beta = j\omega\sqrt{\mu(\varepsilon - j\sigma/\omega)}
$$

- $\alpha$: 감쇠상수 [Np/m], 전계가 $e^{-\alpha z}$로 감쇠.
- **표피 깊이**: $\delta = 1/\alpha$

좋은 도체($\sigma\gg\omega\varepsilon$)에서:

$$
\alpha = \beta = \sqrt{\frac{\pi f\mu\sigma}{1}} = \frac{1}{\delta}, \quad \delta = \sqrt{\frac{2}{\omega\mu\sigma}}
$$

구리 1 MHz: $\delta = \sqrt{2/(2\pi\times10^6\times4\pi\times10^{-7}\times5.8\times10^7)} \approx 66\;\mu\text{m}$.

## 3. 전송선 방정식 (텔레그래퍼 방정식)

전송선(동축·마이크로스트립·평행선)을 단위 길이당 분산 정수로 모델링:

| 정수 | 기호 | 단위 |
|------|------|------|
| 직렬 저항 | $R'$ | Ω/m |
| 직렬 인덕턴스 | $L'$ | H/m |
| 병렬 컨덕턴스 | $G'$ | S/m |
| 병렬 커패시턴스 | $C'$ | F/m |

**텔레그래퍼 방정식**:

$$
\frac{\partial V}{\partial z} = -(R'+j\omega L')I, \qquad \frac{\partial I}{\partial z} = -(G'+j\omega C')V
$$

결합하면:

$$
\frac{d^2V}{dz^2} = \gamma^2 V, \quad \gamma = \sqrt{(R'+j\omega L')(G'+j\omega C')}
$$

**특성 임피던스**:

$$
Z_0 = \sqrt{\frac{R'+j\omega L'}{G'+j\omega C'}}
$$

무손실: $Z_0 = \sqrt{L'/C'}$.

## 4. 반사계수와 정재파비

부하 임피던스 $Z_L$이 $Z_0$과 다르면 반사가 발생한다.

**전압 반사계수**:

$$
\Gamma_L = \frac{Z_L - Z_0}{Z_L + Z_0}, \quad |\Gamma_L|\le1
$$

특수한 경우:
- 정합($Z_L=Z_0$): $\Gamma_L=0$, 반사 없음.
- 단락($Z_L=0$): $\Gamma_L=-1$, 완전 반사 (위상 반전).
- 개방($Z_L\to\infty$): $\Gamma_L=+1$, 완전 반사 (위상 유지).

**정재파비(SWR)**:

$$
\text{SWR} = \frac{1+|\Gamma_L|}{1-|\Gamma_L|} \ge 1
$$

- 완전 정합: SWR = 1.
- 완전 반사: SWR = ∞.

## 5. 임피던스 변환

부하에서 거리 $l$인 위치에서의 입력 임피던스:

$$
Z_{\text{in}}(l) = Z_0\frac{Z_L + jZ_0\tan\beta l}{Z_0 + jZ_L\tan\beta l}
$$

**λ/4 임피던스 변환기** ($\beta l = \pi/2$):

$$
Z_{\text{in}} = \frac{Z_0^2}{Z_L}
$$

변환기 특성 임피던스: $Z_{0,\text{trans}} = \sqrt{Z_{\text{in}}\cdot Z_L}$.

**단락 스텁** ($Z_L=0$, 길이 $l$): $Z_{\text{in}} = jZ_0\tan\beta l$ (순 리액턴스).
**개방 스텁** ($Z_L\to\infty$): $Z_{\text{in}} = -jZ_0\cot\beta l$.

## 6. 계산 예제

**예제**: 특성 임피던스 $Z_0=50\;\Omega$ 전송선 끝에 $Z_L = 75+j25\;\Omega$ 부하. 반사계수와 SWR을 구하라.

$$
\Gamma_L = \frac{Z_L - Z_0}{Z_L + Z_0} = \frac{(75+j25)-50}{(75+j25)+50} = \frac{25+j25}{125+j25}
$$

분자: $25+j25 = 25\sqrt{2}\angle45°$

분모: $125+j25 = \sqrt{125^2+25^2}\angle\arctan(25/125) = 127.5\angle11.3°$

$$
|\Gamma_L| = \frac{25\sqrt{2}}{127.5} = \frac{35.36}{127.5} = 0.277
$$

$$
\text{SWR} = \frac{1+0.277}{1-0.277} = \frac{1.277}{0.723} = 1.77
$$

반사 전력 비율: $|\Gamma|^2 = 0.0767 = 7.67\%$.

## 7. 실무 연결과 주의점

- EV OBC 게이트 드라이브 배선이나 고속 신호(CAN·이더넷 차량 이더넷)에서 전송선 효과를 무시하면 임피던스 불일치로 반사 노이즈가 발생한다. 배선 길이가 신호 파장 $\lambda = v_p/f$의 1/10 이상이면 전송선 해석 필요.
- 100 MHz 신호, $\varepsilon_r=4.5$ PCB에서 $v_p = 3\times10^8/\sqrt{4.5} = 1.41\times10^8$ m/s, $\lambda=1.41$ m → 배선 14 cm 이상이면 전송선 취급.
- λ/4 변환기는 협대역이다 (중심 주파수에서만 정합). 광대역 정합에는 다단 변환기·테이퍼 라인이 필요.
- 표피 효과로 고주파에서 버스바 유효 단면적 감소 → 저항 증가 → 손실·발열 악화. OBC에서 100 kHz 이상 표피 깊이와 버스바 두께를 비교해야 한다.

## 8. 자가 점검

1. 자유공간에서 5 GHz 전자기파의 파장과 위상속도는?
2. $Z_0=75\;\Omega$ 전송선에 $Z_L=300\;\Omega$ 저항 부하. λ/4 변환기로 정합하려면 변환기 특성 임피던스는?
3. SWR=∞인 상황이 단락과 개방 외에도 가능한가? 어떤 조건인가?

<details><summary>정답</summary>

1. $v_p = c = 3\times10^8$ m/s (자유공간). $\lambda = v_p/f = 3\times10^8/(5\times10^9) = 0.06$ m $= 6$ cm.
2. $Z_{0,\text{trans}} = \sqrt{Z_0\cdot Z_L} = \sqrt{75\times300} = \sqrt{22500} = 150\;\Omega$.
3. $|\Gamma_L|=1$이면 SWR=∞. 이는 순수 리액턴스 부하($Z_L=jX$, 실수부 0)에서도 발생한다. 예: $Z_L=j50\;\Omega$이면 $|\Gamma|=1$.

</details>

## 참고자료

- [MIT OCW 6.013 Electromagnetics and Applications](https://ocw.mit.edu/courses/6-013-electromagnetics-and-applications-fall-2005/) — 전자파·전송선 강의
- [MIT OCW 6.003 Signals and Systems](https://ocw.mit.edu/courses/6-003-signals-and-systems-fall-2011/) — 파동·임피던스 관련 배경
- [OpenStax University Physics Vol. 2 — Electromagnetic Waves](https://openstax.org/books/university-physics-volume-2/pages/16-introduction) — 전자기파 기초
