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

## 8. 실무 연결과 주의점

- **AURIX TC365 타이밍 분석**: MCAL 드라이버 개발 시 SPI 클록 극성·위상(CPOL/CPHA)이 타이밍 다이어그램에서 직접 정의. 데이터시트 Figure를 반드시 확인.
- **OBC PWM 타이밍**: GTM 타이머 CLK = 200MHz. 전파 지연 수 ns가 PWM 엣지 정확도에 영향. 고주파(>100kHz) 스위칭 시 타이밍 여유 검토.
- **AUTOSAR SWC 코드생성(MBD)**: Simulink Coder가 생성한 C 코드는 HW 타이밍 제약 없음 → 타이밍 제약은 MCAL/BSW 레벨에서 관리. SW와 HW 타이밍 혼동 주의.
- **Verilog 논블로킹 vs 블로킹 혼용 금지**: 동일 always 블록에 `=`와 `<=` 혼용 → 합성 결과 불일치. 규칙: FF always = `<=`만, 조합 always = `=`만.
- **FPGA 타이밍 클로저**: Vivado 타이밍 리포트에서 WNS(Worst Negative Slack) < 0이면 합성 실패. hold violation은 hold slack이 음수. 두 가지 모두 확인.

---

## 9. 자가 점검

1. 전파 지연과 오염 지연의 차이를 설명하라.
2. 홀드 위반을 클록 주파수를 낮춰 해결할 수 없는 이유는?
3. Verilog에서 블로킹과 논블로킹 할당의 차이와 각각의 사용 상황은?
4. 합성 불가능한 Verilog 구문을 2가지 예시로 들어라.
5. 클록 스큐가 부정적(negative)일 때 셋업 여유와 홀드 여유에 미치는 영향은?

<details><summary>정답</summary>

1. 전파 지연(t_pd): 입력이 변한 후 출력이 최종 안정 값에 도달하는 시간 (50% 기준). 오염 지연(t_cd): 입력이 변한 후 출력이 처음 바뀌기 시작하는 최소 시간. t_cd ≤ t_pd.
2. 홀드 위반은 CLK 엣지 기준 전후의 데이터 안정 창 문제. 클록 주기를 늘려도 CLK 엣지 주변의 타이밍 창은 변하지 않음. 오직 데이터 경로에 지연 버퍼를 삽입해야 해결 가능.
3. 블로킹(=): 순차 실행, 앞 문장 완료 후 다음 문장. 조합 논리 always에서 사용. 논블로킹(<=): 모든 우변 평가 후 동시에 좌변에 할당. FF 동작 모델링. 순차 논리 always에서 사용.
4. ① 딜레이 지정: `#10 a = 1;` (시뮬레이션 전용). ② 시스템 함수: `$display("val=%d", x);` (시뮬레이션 전용).
5. 부정적 스큐(FF2가 FF1보다 먼저 CLK 수신): 수신 FF2가 이미 엣지를 받았는데 데이터가 아직 전파 중 → 셋업 여유 감소. 반면 데이터가 FF2에 도착하기 전에 엣지가 왔으므로 이전 사이클 데이터 유지 시간이 길어짐 → 홀드 여유 증가.

</details>

---

## 참고자료

- [MIT 6.004 — Timing and Clocking](https://ocw.mit.edu/courses/6-004-computation-structures-spring-2017/) — 타이밍 분석 강의
- [HDLBits — Verilog Learning](https://hdlbits.01xz.net/wiki/Main_Page) — 체계적 Verilog 실습 (무료)
- [nandland — Verilog Tutorial](https://nandland.com/introduction-to-verilog/) — 합성 가능 코딩 가이드
- [OpenCores.org](https://opencores.org/) — 오픈소스 HDL 예제 저장소
- [Clifford Cummings — Nonblocking Assignments in Verilog Synthesis](http://www.sunburst-design.com/papers/CummingsSNUG2000SJ_NBA.pdf) — 논블로킹 할당 전문 자료
- Mano & Ciletti, *Digital Design* 6판, Appendix — HDL 기초 기준 교재
