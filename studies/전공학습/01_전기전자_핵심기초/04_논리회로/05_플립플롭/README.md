# 플립플롭

## 학습 목표
- SR·D·JK·T 플립플롭의 특성 방정식과 진리표를 작성할 수 있다.
- 레벨 트리거와 엣지 트리거의 차이를 설명하고 타이밍 다이어그램을 그릴 수 있다.
- 마스터-슬레이브 플립플롭의 구조와 동작을 설명할 수 있다.
- 셋업 타임·홀드 타임·전파 지연의 개념과 타이밍 여유(Slack)를 계산할 수 있다.
- 메타스테이블리티 발생 조건과 실무에서의 대처 방안을 설명할 수 있다.

---

## 1. 순차 논리의 기본 개념

조합논리는 현재 입력만으로 출력 결정.
순차논리는 **과거 상태(메모리)** + 현재 입력으로 출력 결정.

플립플롭(Flip-Flop, FF): 1비트 기억 소자. 클록 신호에 동기화.

---

## 2. SR 플립플롭

| 입력 | 동작 |
|------|------|
| S=0, R=0 | 보류(상태 유지) |
| S=1, R=0 | Set (Q=1) |
| S=0, R=1 | Reset (Q=0) |
| S=1, R=1 | **금지 (불정 상태)** |

특성 방정식: Q(t+1) = S + R'Q,  조건: SR = 0 (SR=1 금지)

| S | R | Q(t) | Q(t+1) |
|---|---|------|--------|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | x | 0 |
| 1 | 0 | x | 1 |
| 1 | 1 | x | 부정 |

---

## 3. D 플립플롭

SR의 S=1, R=1 금지 조건 해결. R = S' 강제.

| D | Q(t+1) |
|---|--------|
| 0 | 0 |
| 1 | 1 |

특성 방정식: **Q(t+1) = D**

엣지 트리거 D-FF는 클록 상승(혹은 하강) 에지에서만 D 값을 샘플링.

---

## 4. JK 플립플롭

SR의 S=J, R=K로 대응. J=K=1 시 **Toggle(반전)** 동작으로 금지 조건 제거.

| J | K | Q(t+1) |
|---|---|--------|
| 0 | 0 | Q(t)   |
| 0 | 1 | 0      |
| 1 | 0 | 1      |
| 1 | 1 | Q'(t)  |

특성 방정식: **Q(t+1) = JQ' + K'Q**

---

## 5. T 플립플롭

JK에서 J=K=T로 묶은 것. T=1이면 Toggle, T=0이면 보류.

| T | Q(t+1) |
|---|--------|
| 0 | Q(t) |
| 1 | Q'(t) |

특성 방정식: **Q(t+1) = T ⊕ Q**

카운터 설계에 최적 — 각 비트 자리에 T-FF 배치.

---

## 6. 레벨 트리거 vs 엣지 트리거

| 구분 | 레벨 트리거 (Latch) | 엣지 트리거 (FF) |
|------|---------------------|-----------------|
| 동작 시점 | CLK=1 구간 전체 | CLK 상승/하강 엣지 순간 |
| 투명 구간 | CLK=1이면 입력 직통 | 없음 |
| 노이즈 민감 | 높음 | 낮음 |
| 사용 예 | 레지스터 버스 홀드 | 동기 설계 FF |

```
레벨 트리거 (D Latch):
CLK=1 구간: Q = D (투명)
CLK=0 구간: Q = Q_prev (보류)

엣지 트리거 (Positive Edge D-FF):
↑CLK 순간: Q ← D
```

---

## 7. 마스터-슬레이브 플립플롭

두 개의 래치(Master + Slave)를 직렬 연결, 반대 CLK 위상으로 구동.

```
Master(CLK=1활성) → Slave(CLK=0활성)

CLK=1: Master가 D 흡수, Slave는 이전 상태 보류
CLK=0: Master 보류, Slave가 Master 값 출력
→ 결과: CLK 하강 엣지에서 Q 확정
```

SR 마스터-슬레이브: 1의 포착(1s-catching) 문제 → JK로 대체 설계.

---

## 8. 셋업·홀드 타임과 전파 지연

```
셋업 타임 t_su: CLK 엣지 전에 D가 안정되어야 하는 최소 시간
홀드 타임 t_h:  CLK 엣지 후에 D가 안정 유지되어야 하는 최소 시간
전파 지연 t_p:  CLK 엣지 → Q 안정 출력까지 소요 시간
클록 주기 T ≥ t_p(FF1) + t_comb + t_su(FF2)
```

타이밍 여유(Setup Slack): Slack = T - (t_p + t_comb + t_su)
Slack < 0 → 타이밍 위반(셋업 실패)

홀드 여유(Hold Slack): t_p + t_comb - t_h
Slack < 0 → 홀드 위반 (클록 주기와 무관, 더 위험)

---

## 9. 메타스테이블리티 (Metastability)

**정의**: 셋업/홀드 타임 위반 시 FF 출력이 0과 1 사이 불정 상태에 머무는 현상.

발생 조건: 비동기 입력(외부 버튼, UART, 서로 다른 클록 도메인 신호)이 FF 타이밍 윈도우를 침범.

```
메타스테이블 상태에서 확정(resolve)될 확률:
  P(fail) ∝ exp(-t_res / τ)
  t_res: 허용 해결 시간, τ: 공정·온도 의존 상수
```

대처 방안:
1. **동기화 체인(Synchronizer)**: 2단 이상 FF로 확정 확률 높임.
2. **Clock Domain Crossing(CDC) 분석**: 도구(Synopsys CDC, Questa CDC)로 자동 검출.
3. **FIFO 사용**: 속도가 다른 도메인 간 데이터 전달.

---

## 10. 계산 예제

**예제 1.** JK-FF를 D-FF로 변환하라.

```
D-FF 특성: Q(t+1) = D
JK-FF 특성: Q(t+1) = JQ' + K'Q

JQ' + K'Q = D  되려면:
  J = D, K = D'  (∵ JQ' + D''Q = DQ' + DQ = D(Q'+Q) = D)
→ D = J = K'
```

**예제 2.** 클록 주기 계산.

```
조건: t_p(FF) = 0.5ns, t_comb = 2.0ns, t_su = 0.3ns
최소 클록 주기: T_min = 0.5 + 2.0 + 0.3 = 2.8 ns
최대 클록 주파수: f_max = 1 / 2.8 ns ≈ 357 MHz
```

---

## 11. 실무 연결과 주의점

- **AURIX TC365 클록 도메인**: SPB(시스템 주변장치 버스) 클록과 CPU 클록이 다름. SPI/CAN 컨트롤러와 CPU 간 레지스터 접근 시 CDC 위험 → TC365는 HW 동기화 레지스터(SAFE·SCUSR) 제공.
- **AUTOSAR OS 인터럽트 진입**: 인터럽트 핸들러 진입 시 레지스터 스냅샷이 순간에 완료되어야 함 → 셋업/홀드 위반 없이 안전한 컨텍스트 전환은 HW FF 타이밍에 의존.
- **OBC ADC 샘플 타이밍**: ADC SOC(Start of Conversion) 신호와 PWM 스위칭 엣지가 충돌하면 실제 메타스테이블 유사 현상(잡음 샘플) 발생. ADC 트리거를 PWM 주기 중앙에 배치.
- **D 래치 vs D FF**: AUTOSAR BSW에서 공유 변수 보호는 스핀락/인터럽트 마스킹 → SW 수준의 "래치" 개념. HW D-Latch와 혼동 주의.

---

## 12. 자가 점검

1. JK-FF에서 J=1, K=1일 때 Q의 동작을 설명하라.
2. D 래치와 D 플립플롭의 타이밍 동작 차이를 설명하라.
3. 셋업 타임 위반과 홀드 타임 위반을 각각 어떻게 해결하는가?
4. 메타스테이블 상태에서 2단 동기화기가 왜 효과적인지 설명하라.
5. T-FF로 divide-by-2 회로를 만드는 방법은?

<details><summary>정답</summary>

1. J=K=1이면 Toggle: Q(t+1) = Q'(t). 이전 상태의 반전이 출력됨. SR-FF와 달리 금지 상태 없음.
2. D 래치: CLK=1 구간 동안 Q=D(투명). D FF: CLK 상승/하강 에지 순간에만 Q에 D 값 저장, 이후 보류.
3. 셋업 위반: 조합 논리 경로 최적화(느린 게이트 교체), 클록 주파수 낮춤, 파이프라인 추가. 홀드 위반: 데이터 경로에 버퍼/지연 삽입 (클록 주기 조정으로 해결 불가).
4. 1단 FF에서 메타스테이블이 발생해도, 다음 클록 주기 동안 확정될 시간(t_res)이 주어짐. 2단에서 확정 실패 확률 = P(1단 실패)^2 → 지수적으로 감소.
5. T 입력을 1로 고정(VCC에 연결). CLK마다 Q가 Toggle → Q 주파수 = CLK 주파수 / 2.

</details>

---

## 참고자료

- [MIT 6.004 — Sequential Logic and Flip-Flops](https://ocw.mit.edu/courses/6-004-computation-structures-spring-2017/) — 순차 논리 기본 강의
- [nandland — Flip-Flop Tutorial](https://nandland.com/flip-flop/) — FPGA 구현 포함
- [HDLBits — D Flip-Flop Exercises](https://hdlbits.01xz.net/wiki/Dff) — Verilog FF 실습
- [Clifford Cummings — Synthesis and Simulation Design of State Machines](http://www.sunburst-design.com/papers/CummingsSNUG2019SJ_FSM.pdf) — 산업 전문가 자료
- Mano & Ciletti, *Digital Design* 6판, Chapter 5 — 플립플롭 기준 교재
