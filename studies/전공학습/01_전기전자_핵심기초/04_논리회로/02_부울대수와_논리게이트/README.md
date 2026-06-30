# 부울대수와 논리게이트

## 학습 목표
- 부울 공리와 주요 정리(드모르간 포함)를 나열하고 증명할 수 있다.
- AND·OR·NOT·NAND·NOR·XOR 게이트의 진리표와 기호를 그릴 수 있다.
- 부울 식을 공리·정리를 이용해 간소화할 수 있다.
- NAND/NOR 만으로 임의 함수를 구현하는 원리(범용성)를 설명할 수 있다.
- 쌍원리(Duality)를 이용해 새 항등식을 유도할 수 있다.

---

## 1. 부울 공리 (Huntington's Postulates)

| 번호 | 덧셈(OR) 형식 | 곱셈(AND) 형식 |
|------|--------------|----------------|
| P1 | X + 0 = X | X · 1 = X |
| P2 | X + X' = 1 | X · X' = 0 |
| P3 (교환) | X + Y = Y + X | X · Y = Y · X |
| P4 (결합) | (X+Y)+Z = X+(Y+Z) | (XY)Z = X(YZ) |
| P5 (분배) | X(Y+Z) = XY + XZ | X+YZ = (X+Y)(X+Z) |

---

## 2. 주요 부울 정리

| 정리 | 내용 |
|------|------|
| 멱등(Idempotent) | X + X = X, X · X = X |
| 보원(Complement) | (X')' = X |
| 흡수(Absorption) | X + XY = X, X(X+Y) = X |
| 0/1 지배 | X + 1 = 1, X · 0 = 0 |
| **드모르간 1** | (X + Y)' = X' · Y' |
| **드모르간 2** | (X · Y)' = X' + Y' |

### 쌍원리 (Duality)

부울 식에서 **·↔+ , 0↔1** 을 치환하면 동등한 식(쌍대)이 성립한다.
예) X + 0 = X  →  쌍대:  X · 1 = X

---

## 3. 기본 논리 게이트

### 3.1 AND

| A | B | Y = A·B |
|---|---|---------|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

> 참고 도식: Mano & Ciletti, *Digital Design* 6판, Fig. 1.12.

### 3.2 OR

| A | B | Y = A+B |
|---|---|---------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

### 3.3 NOT (Inverter)

| A | Y = A' |
|---|--------|
| 0 | 1 |
| 1 | 0 |

### 3.4 NAND (범용 게이트)

Y = (A·B)' — AND 뒤에 NOT

| A | B | Y |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

**범용성**: NAND 게이트 단독으로 AND·OR·NOT 구현 가능.

```
NOT A  = NAND(A, A)
A AND B = NAND(NAND(A,B), NAND(A,B))
A OR B  = NAND(NAND(A,A), NAND(B,B))
```

### 3.5 NOR (범용 게이트)

Y = (A+B)' — OR 뒤에 NOT

| A | B | Y |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 0 |

### 3.6 XOR (배타적 OR)

Y = A ⊕ B = A'B + AB'

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

특성:
- A ⊕ 0 = A
- A ⊕ 1 = A'  (비트 반전)
- A ⊕ A = 0
- A ⊕ A' = 1

### 3.7 XNOR

Y = (A ⊕ B)' = AB + A'B'  — 동치 검출기

| A | B | Y |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

---

## 4. 드모르간 정리 활용 — NAND/NOR 변환

드모르간에 따라:
- NAND = (AB)' = A' + B' → 입력에 버블(NOT)을 붙인 OR 게이트와 동치
- NOR  = (A+B)' = A'·B' → 입력에 버블을 붙인 AND 게이트와 동치

> 참고 도식: Mano & Ciletti, *Digital Design* 6판, Fig. 2.24.

---

## 5. 부울 식 간소화 예제

**예제 1.** Y = ABC + AB'C + ABC' + A'BC 간소화

```
= AC(B + B') + AB'C + A'BC
= AC + AB'C + A'BC
= AC(1 + B') + A'BC
= AC + A'BC
= A(C) + A'BC        ← 흡수 더 이상 안 됨
→ 최종: AC + A'BC = C(A + A'B) = C(A + B)
```

**예제 2.** 드모르간 적용

```
Y' = (A + B)(C + D)
Y  = [(A + B)(C + D)]'
   = (A + B)' + (C + D)'
   = A'B' + C'D'
```

---

## 학습·검증 기록

- **핵심 정리:** 논리식과 게이트 회로의 등가는 모든 입력 조합의 진리표가 같을 때 성립하며, 드모르간 정리를 이용하면 AND·OR·NOT을 NAND 또는 NOR만으로 바꿀 수 있다.
- **확인 근거:** AND·OR·NAND·NOR·XOR·XNOR의 입력 조합별 진리표를 작성했고, NAND만으로 `NOT A`, `A AND B`, `A OR B`를 구성한 식과 드모르간 변환 $[(A+B)(C+D)]'=A'B'+C'D'$를 전개했다.
- **다음 탐구:** $[(A+B)(C+D)]'$와 $A'B'+C'D'$의 16개 입력 진리표를 나란히 작성하고, 한쪽을 NAND 전용 게이트 식으로 다시 표현해 등가성을 확인한다.

---

## 참고자료

- [MIT 6.004 Computation Structures — Boolean Algebra](https://ocw.mit.edu/courses/6-004-computation-structures-spring-2017/) — 부울 공리 강의
- [nandland — Logic Gates Tutorial](https://nandland.com/logic-gates/) — 게이트 기호·진리표·FPGA 구현
- [HDLBits — Verilog Practice (Gates)](https://hdlbits.01xz.net/wiki/Gates4) — 게이트 코딩 연습
- [All About Circuits — Boolean Algebra](https://www.allaboutcircuits.com/textbook/digital/chpt-7/boolean-algebra/) — 심화 정리 설명
- Mano & Ciletti, *Digital Design* 6판, Chapter 2 — 부울 대수 및 게이트 기준 교재
