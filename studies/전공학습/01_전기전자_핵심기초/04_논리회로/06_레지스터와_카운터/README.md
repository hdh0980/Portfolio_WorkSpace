# 레지스터와 카운터

## 1. 레지스터 (Register)

여러 개의 D-FF를 병렬 배치해 n비트 데이터를 한 번에 저장.

```
4비트 병렬 로드 레지스터:
CLK 엣지에서 {I3,I2,I1,I0} → {Q3,Q2,Q1,Q0} 동시 전송
LOAD=1: 입력 데이터 로드
LOAD=0: 현재 상태 보류
```

---

## 2. 시프트 레지스터 (Shift Register)

FF를 직렬 연결: 각 FF의 Q가 다음 FF의 D로 연결.

### 2.1 분류

| 종류 | 입력 | 출력 | 설명 |
|------|------|------|------|
| SISO | 직렬 | 직렬 | 기본 시프트. n클록 후 데이터 출력 |
| SIPO | 직렬 | 병렬 | n클록 직렬 수신 → 병렬 출력. SPI 수신 버퍼 |
| PISO | 병렬 | 직렬 | 병렬 로드 후 직렬 송출. SPI 송신 버퍼 |
| PIPO | 병렬 | 병렬 | 파이프라인 레지스터. 클록 정렬 지연 |

### 2.2 4비트 SIPO 타이밍 예

```
입력 직렬: 1 0 1 1 (MSB first)
CLK  : ↑  ↑  ↑  ↑
Q3Q2Q1Q0:
  초기 = 0000
  CLK1: 1000   (입력=1 → Q3으로 shift)
  CLK2: 0100   (입력=0 → shift right)
  CLK3: 1010   (입력=1)
  CLK4: 1101   (입력=1)
최종 Q3Q2Q1Q0 = 1101  → 먼저 들어온 MSB가 Q0, 병렬 출력은 Q0Q1Q2Q3 = 1011
```

### 2.3 방향 제어 (Universal Shift Register)

MODE 입력으로 Left Shift / Right Shift / Parallel Load / Hold 중 선택.

---

## 3. 리플 카운터 (Ripple Counter)

T-FF(T=1 고정) 를 직렬 연결. 하위 비트 FF의 Q가 상위 비트 FF의 CLK로 입력.

```
FF0 CLK = 외부 클록
FF1 CLK = FF0의 Q (Q0 하강 엣지에 트리거)
FF2 CLK = FF1의 Q
...

4비트 리플 카운터 동작: 0000 → 0001 → 0010 → ... → 1111 → 0000
```

> 참고 도식: Mano & Ciletti, *Digital Design* 6판, Fig. 6.3.

#### 리플 카운터 타이밍 문제

- 각 FF는 이전 FF가 전환된 후에만 변경 → **누적 전파 지연**
- n비트 카운터 최악 지연 = n × t_FF
- 고속 동작 시 중간 글리치 상태 존재 (예: 0111→1000 전환 중 0110, 0100, 0000이 차례로 잠깐 나타남)

---

## 4. 동기 카운터 (Synchronous Counter)

모든 FF가 **공통 CLK**에 동시에 트리거. 전파 지연 누적 없음.

### 4비트 동기 이진 카운터 Enable 방정식

```
T0 = 1              (Q0는 항상 Toggle)
T1 = Q0             (Q1은 Q0=1일 때 Toggle)
T2 = Q1·Q0          (Q2는 Q1=Q0=1일 때)
T3 = Q2·Q1·Q0       (Q3은 Q2=Q1=Q0=1일 때)
Carry_out = Q3·Q2·Q1·Q0  (캐스케이드용)
```

| 장점 | 단점 |
|------|------|
| 동시 전이, 글리치 없음 | 조합 논리 증가(AND 체인) |
| 고속 동작 가능 | 회로 면적 증가 |

---

## 5. Modulo-N 카운터

0에서 N-1까지 계수하고 N에서 0으로 리셋.

### 설계 방법 1: 리셋 방식 (비동기 클리어)

```
예) Mod-6 카운터 (0~5):
4비트 카운터 + NAND 게이트 감지: Q2·Q1 = 1 (6 = 0110)
이 조건 발생 시 CLR(비동기 리셋) 활성 → 0000으로 복귀
단점: 6이 극히 짧게 나타났다 사라지는 글리치
```

### 설계 방법 2: 상태 할당 (동기 로드)

```
카운터가 N-1 상태에서 다음 클록에 0을 로드(LOAD=1).
글리치 없음. 선호 방법.
```

### 주요 Modulo-N 응용

| N | 용도 |
|---|------|
| 60 | 초·분 카운터 |
| 24 | 시간 카운터 |
| 10 | BCD 카운터 |
| 12 | 시간 (12시간제) |
| 2^n | PWM 분해능 레지스터 |

---

## 6. 계산 예제

**예제 1.** 3비트 리플 카운터에서 000→111 전환까지 걸리는 클록 사이클과 최악 전파 지연.

```
3비트 카운터 = 8개 상태(0~7)
000→001: 1 CLK
...
111→000(overflow): 1 CLK
최악 지연: 111→000 전환 시 FF0 → FF1 → FF2 순 전파
최악 전파 지연 = 3 × t_FF  (단, t_FF는 각 FF의 전파 지연)
```

**예제 2.** Mod-10 BCD 카운터를 4비트 동기 카운터 + 동기 로드로 구현.

```
상태 1001(=9)에서:
  감지 조건: Q3·Q0 = 1 (9 = 1001, Q3=1, Q0=1)
  다음 CLK에서 LOAD=1, 데이터 입력 = 0000
→ 0000으로 동기 복귀
중간 글리치 없음
```

---

## 메모

3비트 리플 카운터는 상태가 8개라 000에서 111까지 7클록, 한 바퀴는 8클록이고, `111→000`에서 지연이 $3t_{FF}$로 가장 길다. Mod-10 예제는 `1001`에서 $Q_3Q_0=1$을 보고 다음 클록에 `0000`을 동기 로드한다.

---

## 참고자료

- [MIT 6.004 — Registers and Counters](https://ocw.mit.edu/courses/6-004-computation-structures-spring-2017/) — 레지스터·카운터 강의
- [nandland — Shift Register Tutorial](https://nandland.com/shift-register/) — FPGA Verilog 예제 포함
- [HDLBits — Shift Registers](https://hdlbits.01xz.net/wiki/Shift4) — 코딩 연습
- [All About Circuits — Counters](https://www.allaboutcircuits.com/textbook/digital/chpt-11/binary-count-sequence/) — 카운터 설계 단계별 설명
- Mano & Ciletti, *Digital Design* 6판, Chapter 6 — 레지스터·카운터 기준 교재
