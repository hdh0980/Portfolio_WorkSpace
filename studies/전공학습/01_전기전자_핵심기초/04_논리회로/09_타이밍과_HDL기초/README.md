# 타이밍과 HDL 기초

## 학습 목표
- 전파 지연·셋업 홀드 위반·클록 스큐의 개념을 설명하고 타이밍 여유(Slack)를 계산할 수 있다.
- 타이밍 다이어그램을 읽고 신호 간 관계를 분석할 수 있다.
- Verilog의 always 블록과 VHDL의 process 블록을 작성할 수 있다.
- 구조적(Structural)·동작적(Behavioral) 모델링의 차이를 설명할 수 있다.
- 합성 가능(Synthesizable) 코드와 시뮬레이션 전용(Simulation-only) 코드를 구분할 수 있다.

---

## 1. 전파 지연 (Propagation Delay)

게이트나 FF의 입력 변화 후 출력이 안정화되는 데 걸리는 시간.

| 파라미터 | 기호 | 의미 |
|---------|------|------|
| 전파 지연 (high→low) | t_pHL | 출력이 HIGH → LOW로 바뀌는 시간 |
| 전파 지연 (low→high) | t_pLH | 출력이 LOW → HIGH로 바뀌는 시간 |
| 전파 지연 (평균) | t_pd | (t_pHL + t_pLH) / 2 |
| 오염 지연 | t_cd | 입력 변화 후 출력이 처음 변하기 시작하는 시간 |

**Critical Path**: 조합 논리 경로 중 전파 지연 합산이 가장 큰 경로 → 최대 클록 주파수 결정.

```
f_max = 1 / (t_p_FF + t_critical_path + t_su_FF)
```

---

## 2. 셋업/홀드 위반

### 셋업 위반 (Setup Violation)

```
조건: 데이터 도착 시간 > CLK 엣지 - t_su
결과: FF가 안정된 값을 래치하지 못할 위험
해결: 조합 경로 단축, 클록 주파수 감소, 파이프라인 삽입
```

### 홀드 위반 (Hold Violation)

```
조건: 데이터 유지 시간 < CLK 엣지 + t_h
결과: FF가 엣지 직후 새 값을 오래된 값으로 덮어쓸 위험
해결: 데이터 경로에 지연 버퍼 삽입 (클록 주파수 낮춤으로는 해결 불가)
```

---

## 3. 클록 스큐 (Clock Skew)

동일 클록이 서로 다른 FF에 다른 시점에 도달하는 현상.

```
스큐 = t_CLK(FF2) - t_CLK(FF1)

긍정적 스큐(Positive Skew): FF2가 FF1보다 나중에 CLK 수신
  → Setup 여유 증가, Hold 여유 감소

부정적 스큐(Negative Skew): FF2가 FF1보다 먼저 CLK 수신
  → Setup 여유 감소, Hold 여유 증가
```

스큐 최소화: 클록 트리 합성(CTS), H-Tree/Fish-Bone 배선.

---

## 4. 타이밍 다이어그램

```
CLK : ‾‾|___|‾‾‾|___|‾‾‾|___
         ↑       ↑       ↑   ← 상승 엣지

D   : ─────┐ 1  └───────────── 0 ──
           └──(t_su 전에 안정)──┘

Q   : ─────────────────────────────
                   └─(t_p 후)─→ 1 ─

표기:
  ↑ = 상승 엣지 (Positive Edge Trigger)
  ↓ = 하강 엣지 (Negative Edge Trigger)
  X = 불정 (Don't Care / Unknown)
  Z = 하이 임피던스
```

---

## 5. Verilog 기초

### 5.1 모듈 구조

```verilog
module module_name (
    input  wire clk,
    input  wire rst_n,
    input  wire [7:0] data_in,
    output reg  [7:0] data_out
);

// 내부 신호
wire [7:0] intermediate;

// 구조적 인스턴스
and_gate u0 (.a(data_in[0]), .b(data_in[1]), .y(intermediate[0]));

// 동작적 모델링
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        data_out <= 8'h00;
    else
        data_out <= data_in;
end

endmodule
```

### 5.2 always 블록

| 감도 목록 | 용도 | 합성 결과 |
|----------|------|----------|
| `always @(*)` | 조합 논리 | 게이트 |
| `always @(posedge clk)` | 동기 FF | D-FF (상승 엣지) |
| `always @(negedge clk)` | 동기 FF | D-FF (하강 엣지) |
| `always @(posedge clk or negedge rst_n)` | 비동기 리셋 FF | D-FF + 비동기 CLR |

### 5.3 할당 연산자

| 연산자 | 이름 | 사용 위치 |
|--------|------|----------|
| `=` | 블로킹 할당 | always 내 조합 논리 |
| `<=` | 논블로킹 할당 | always 내 순차 논리 (FF) |
| `assign` | 연속 할당 | always 외부, wire |

```verilog
// 조합 논리 (블로킹)
always @(*) begin
    y = a & b;    // = 사용
end

// 순차 논리 (논블로킹) - FF
always @(posedge clk) begin
    q <= d;       // <= 사용
end
```

### 5.4 합성 가능 vs 시뮬레이션 전용

| 구분 | 합성 가능 | 시뮬레이션 전용 |
|------|----------|----------------|
| 딜레이 | 금지 (`#10`) | 허용 (`#10 a = 1;`) |
| initial 블록 | 일부 제한 (FF 초기값) | 항상 허용 |
| `$display/$monitor` | 금지 | 허용 |
| `force/release` | 금지 | 허용 |
| `fork/join` | 금지 | 허용 |

---

## 6. VHDL 기초

### 6.1 엔티티와 아키텍처

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
    Port (
        clk   : in  std_logic;
        rst_n : in  std_logic;
        d     : in  std_logic;
        q     : out std_logic
    );
end dff;

architecture Behavioral of dff is
begin
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            q <= '0';
        elsif rising_edge(clk) then
            q <= d;
        end if;
    end process;
end Behavioral;
```

### 6.2 process 블록

```
process(감도 목록)
begin
    -- 순차 실행 코드
end process;
```

- 감도 목록에 clk만 있고 if-else로 엣지 조건 → FF (순차 논리)
- 감도 목록에 모든 입력 → 조합 논리 (또는 `process(all)`)

### 6.3 구조적 vs 동작적 모델링

| 구분 | 설명 | 예 |
|------|------|-----|
| 구조적(Structural) | 게이트/컴포넌트 인스턴스 직접 연결 | `and_gate port map(...)` |
| 동작적(Behavioral) | 원하는 동작을 알고리즘으로 기술 | `if-then-else`, `case` |
| 데이터플로우(Dataflow) | concurrent 신호 할당 | `y <= a and b;` |

---

## 7. 계산 예제

**예제 1.** 타이밍 여유 계산.

```
조건:
  FF 전파 지연 t_p = 0.4 ns
  조합 논리 최장 경로 t_comb = 3.1 ns
  셋업 타임 t_su = 0.2 ns
  클록 스큐 t_skew = 0.1 ns (부정적)
  클록 주기 T = 4.0 ns

셋업 여유 = T - (t_p + t_comb + t_su + t_skew)
         = 4.0 - (0.4 + 3.1 + 0.2 + 0.1)
         = 4.0 - 3.8
         = 0.2 ns  (양수 → 타이밍 만족)

홀드 여유: t_p + t_comb_min - t_h - t_skew
  (t_comb_min은 최단 경로, 별도 분석 필요)
```

**예제 2.** Verilog로 D-FF 기반 4비트 카운터 작성.

```verilog
module counter4bit (
    input  wire clk,
    input  wire rst_n,
    output reg  [3:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b0000;
        else
            count <= count + 4'b0001;
    end
endmodule
```

합성 결과: 4개의 D-FF + 4비트 가산기(올림 체인).

---

## 학습·검증 기록

- **핵심 정리:** 순차 HDL은 클록 에지와 논블로킹 할당으로 FF 동작을 표현하고, 기능식이 맞더라도 전파 지연·셋업·홀드·클록 스큐를 포함한 타이밍 여유가 양수여야 한다.
- **확인 근거:** $T=4.0$ ns 경로에 $t_p=0.4$ ns, $t_{comb}=3.1$ ns, $t_{su}=0.2$ ns, 불리한 스큐 0.1 ns를 합산해 셋업 여유 0.2 ns를 얻었고, 4비트 카운터 예제는 `posedge clk` 블록에서 `<=`로 상태를 갱신한다.
- **다음 탐구:** 최단 조합 지연과 홀드 타임을 정해 같은 경로의 홀드 여유를 계산하고, Verilog의 블로킹·논블로킹 할당을 바꿨을 때 기술되는 회로 동작을 비교한다.

---

## 참고자료

- [MIT 6.004 — Timing and Clocking](https://ocw.mit.edu/courses/6-004-computation-structures-spring-2017/) — 타이밍 분석 강의
- [HDLBits — Verilog Learning](https://hdlbits.01xz.net/wiki/Main_Page) — 체계적 Verilog 실습 (무료)
- [nandland — Verilog Tutorial](https://nandland.com/introduction-to-verilog/) — 합성 가능 코딩 가이드
- [OpenCores.org](https://opencores.org/) — 오픈소스 HDL 예제 저장소
- [Clifford Cummings — Nonblocking Assignments in Verilog Synthesis](http://www.sunburst-design.com/papers/CummingsSNUG2000SJ_NBA.pdf) — 논블로킹 할당 전문 자료
- Mano & Ciletti, *Digital Design* 6판, Appendix — HDL 기초 기준 교재
