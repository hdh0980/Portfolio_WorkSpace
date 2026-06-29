# 메모리와 프로그램가능논리

## 학습 목표
- ROM·PROM·EEPROM·Flash의 구조적 차이와 쓰기 메커니즘을 비교할 수 있다.
- SRAM과 DRAM의 셀 구조 및 리프레시 필요성을 설명할 수 있다.
- PLD·GAL·CPLD의 프로그래밍 원리를 이해하고 AND-OR 평면 구조를 설명할 수 있다.
- FPGA의 LUT·CLB·IOB 기본 구조와 구성 방법을 설명할 수 있다.
- 재구성 가능성(Reconfigurability)의 실무 장점과 제한을 설명할 수 있다.

---

## 1. 반도체 메모리 분류

```
메모리
├── 휘발성 (Volatile)
│   ├── SRAM (Static RAM)
│   └── DRAM (Dynamic RAM)
└── 비휘발성 (Non-Volatile)
    ├── ROM (Mask ROM)
    ├── PROM (1회 프로그래밍)
    ├── EPROM (UV 소거)
    ├── EEPROM (전기 소거, 바이트 단위)
    └── Flash (전기 소거, 블록/섹터 단위)
```

---

## 2. ROM 계열

### 2.1 특성 비교

| 종류 | 프로그래밍 | 소거 | 반복 | 용도 |
|------|-----------|------|------|------|
| Mask ROM | 제조 공정 | 불가 | 없음 | 대량 생산 부트코드 |
| PROM | 전기(퓨즈) | 불가 | 없음 | 소량 고정 코드 |
| EPROM | 전기 | UV 광 | 수백 회 | 개발 샘플 |
| EEPROM | 전기 | 전기(바이트) | 10만~100만 회 | 설정값 NvM |
| **Flash** | 전기 | 전기(블록) | 10만~100만 회 | MCU 코드 플래시, SSD |

### 2.2 Flash 구조

- **NOR Flash**: 랜덤 읽기 빠름, XIP(Execute In Place) 가능. MCU 코드 저장.
- **NAND Flash**: 순차 읽기·쓰기 빠름, 용량 대비 저렴. SSD, eMMC.

셀 당 비트: SLC(1비트) > MLC(2비트) > TLC(3비트) — 비트수 증가 시 속도·수명 감소.

---

## 3. SRAM

6-트랜지스터(6T) 셀: 교차결합 인버터 2개 + 액세스 트랜지스터 2개.

```
WL (Word Line) ─┬─ M5 ─┬─ Q ─┬─ M6 ─┬─ BL (Bit Line)
                │      │     │      │
               M1  ───M2   M3───  M4
                (인버터 쌍)
BLB (Bit Line Bar) ──────────────────────
```

- 읽기/쓰기: 단순, 고속
- 전력: 대기 상태에서도 6T가 전류 소비
- 리프레시 불필요

---

## 4. DRAM

1-트랜지스터 + 1-커패시터(1T1C) 셀.

```
WL ─ M(액세스 트랜지스터) ─ 커패시터(C) ─ GND
              │
             BL
```

- 커패시터 전하 손실 → **리프레시 필요** (수 ms 주기)
- 집적도 높음, 대용량, 저렴
- DRAM Controller가 자동 리프레시 관리

---

## 5. PLD / GAL

### 5.1 PLD 구조 (AND-OR 평면)

```
입력 변수 + 보수 ──┬──[ AND 평면 (프로그래밍 가능) ]──► 곱항(Product Term)
                  │                                       │
                  └──────────────────────────────────────►[ OR 평면 ]──► 출력
```

| 종류 | AND 평면 | OR 평면 |
|------|---------|---------|
| ROM | 고정(디코더) | 프로그래밍 가능 |
| PLA | 프로그래밍 가능 | 프로그래밍 가능 |
| PAL | 프로그래밍 가능 | 고정 |
| GAL | 재프로그래밍 가능 AND | 고정 |

PAL/GAL이 가장 많이 사용됨 (AND만 프로그램, OR 고정 = 구현 단순).

---

## 6. CPLD (Complex PLD)

여러 개의 PLD 블록 + 프로그래밍 가능한 인터커넥트.

```
[PLD 블록 1] ─┐
[PLD 블록 2] ─┤─ [Global Interconnect] ─► I/O 블록
[PLD 블록 3] ─┘
...
```

- 비휘발성(플래시/EEPROM 기반) → 전원 ON 즉시 동작
- 예측 가능한 타이밍 (인터커넥트 지연 고정)
- 소규모 제어 논리, 글루 로직, 인터페이스 브리지

---

## 7. FPGA 기본 구조

### 7.1 세 가지 기본 요소

| 블록 | 약어 | 역할 |
|------|------|------|
| Look-Up Table | LUT | n입력 임의 조합 논리 구현 (진리표 저장) |
| Configurable Logic Block | CLB | LUT + FF + MUX 묶음 |
| Input/Output Block | IOB | 외부 핀 인터페이스 (전압 레벨, 드라이브 강도) |

### 7.2 LUT 동작 원리

4입력 LUT = 2^4 = 16비트 SRAM 배열.
임의 4변수 부울 함수를 진리표 값으로 저장 → SRAM 주소 = 입력, 출력 = 저장 값.

```
예) F = A XOR B XOR C XOR D
LUT 내용: 0110 1001 1001 0110  (각 입력 조합의 F 값)
```

### 7.3 CLB 구조

```
CLB
├── LUT×4 (또는 6입력 LUT×2, 제품마다 다름)
├── D-FF
├── MUX (조합 출력 / 등록 출력 선택)
└── 캐리 체인 (빠른 가산기용)
```

### 7.4 재구성 가능성 (Reconfigurability)

- 전원 OFF 시 설정 손실(SRAM 기반) → 부팅 시 외부 플래시에서 비트스트림 로드
- Flash 기반 FPGA(Microsemi SmartFusion 등): 비휘발성, 전원 ON 즉시 동작
- 부분 재구성(Partial Reconfiguration): 일부 영역만 런타임 변경 가능

---

## 8. 계산 예제

**예제 1.** 256×8비트 ROM의 주소 핀·데이터 핀·총 용량을 구하라.

```
용량: 256 × 8 = 2048 bits = 256 Bytes = 0.25 KB
주소 핀: log₂(256) = 8핀 (A7~A0)
데이터 핀: 8핀 (D7~D0)
```

**예제 2.** 4입력 LUT로 F = AB + C'D를 구현할 때, LUT에 저장될 16비트 진리표를 구하라.

```
입력 순서: A(bit3) B(bit2) C(bit1) D(bit0)

주소 | A B C D | F=AB+C'D
  0  | 0 0 0 0 | 0+1=1
  1  | 0 0 0 1 | 0+1=1
  2  | 0 0 1 0 | 0+0=0
  3  | 0 0 1 1 | 0+0=0
  4  | 0 1 0 0 | 0+1=1
  5  | 0 1 0 1 | 0+1=1
  6  | 0 1 1 0 | 0+0=0
  7  | 0 1 1 1 | 0+0=0
  8  | 1 0 0 0 | 0+1=1
  9  | 1 0 0 1 | 0+1=1
 10  | 1 0 1 0 | 0+0=0
 11  | 1 0 1 1 | 0+0=0
 12  | 1 1 0 0 | 1+1=1
 13  | 1 1 0 1 | 1+1=1
 14  | 1 1 1 0 | 1+0=1
 15  | 1 1 1 1 | 1+0=1
LUT 내용 (주소 0→15): 1 1 0 0 1 1 0 0 1 1 0 0 1 1 1 1
```

---

## 9. 실무 연결과 주의점

- **AURIX TC365 플래시**: 코드 플래시(최대 16MB NOR) + 데이터 플래시(EEPROM 에뮬레이션). AUTOSAR NvM이 데이터 플래시를 섹터 단위 소거+재기록 관리. 쓰기 수명(10만 사이클) 초과 방지를 위해 웨어 레벨링 고려.
- **OBC CPLD 글루 로직**: PWM 신호 선택·보호 회로 트립 신호 래치 등 단순 조합 논리를 CPLD로 구현 → 전원 즉시 동작 필요(비휘발성 CPLD).
- **FPGA 프로토타이핑**: A-SPICE SWE.4 단위 테스트 전, 제어 알고리즘을 FPGA로 HIL 구성. SRAM 기반 FPGA는 보드 전원 후 비트스트림 로드 시간(수백 ms) 고려.
- **EEPROM 쓰기 시간**: 일반 EEPROM 바이트 쓰기 = 수 ms. AUTOSAR NvM 쓰기 요청 후 완료 확인(콜백) 없이 즉시 재읽기 시 오래된 데이터 반환 주의.
- **Flash 배드 블록**: NAND 플래시는 출하 시 배드 블록 존재 가능 → BBM(Bad Block Management) 필수. NOR는 배드 블록 없음.

---

## 10. 자가 점검

1. SRAM과 DRAM의 셀 구조 차이와 리프레시 필요 여부를 비교하라.
2. NOR 플래시와 NAND 플래시의 사용 용도 차이를 설명하라.
3. FPGA의 4입력 LUT로 구현 가능한 최대 함수 수는?
4. CPLD가 FPGA보다 유리한 상황을 2가지 들어라.
5. PLA와 PAL의 차이점은 무엇인가?

<details><summary>정답</summary>

1. SRAM: 6T(인버터 교차결합) → 전원 공급 시 데이터 유지, 리프레시 불필요. DRAM: 1T1C → 커패시터 누설로 수 ms 내 전하 손실, 주기적 리프레시 필요.
2. NOR: 랜덤 읽기 고속, XIP 가능 → MCU 코드 플래시. NAND: 순차 쓰기/읽기 고속, 대용량 저렴 → SSD, eMMC, 스마트폰 저장장치.
3. 4입력 LUT = 2^(2^4) = 2^16 = 65,536가지. (16비트 SRAM에 저장 가능한 모든 패턴)
4. ① 전원 ON 즉시 동작 필요(비휘발성, 비트스트림 로드 시간 없음). ② 타이밍 예측이 쉬움(인터커넥트 지연 고정).
5. PLA: AND 평면과 OR 평면 모두 프로그래밍 가능 → 유연하나 복잡. PAL: AND 평면만 프로그래밍, OR 평면 고정 → 단순, 빠름, 실제 많이 사용.

</details>

---

## 참고자료

- [MIT 6.004 — Memory Technologies](https://ocw.mit.edu/courses/6-004-computation-structures-spring-2017/) — 메모리 구조 강의
- [nandland — FPGA Fundamentals](https://nandland.com/fpga-101/) — LUT·CLB·IOB 시각 설명
- [HDLBits — FPGA Practice](https://hdlbits.01xz.net/wiki/Main_Page) — Verilog 합성 실습
- [Xilinx UG474 — 7 Series CLB User Guide](https://docs.xilinx.com/r/en-US/ug474_7Series_CLB) — CLB 구조 공식 문서
- Mano & Ciletti, *Digital Design* 6판, Chapter 7 — 메모리·PLD·FPGA 기준 교재
