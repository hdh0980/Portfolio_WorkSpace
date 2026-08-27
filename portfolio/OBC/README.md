# OBC · 차량 탑재 충전기

![OBC 제품 예시](../../assets/products/obc-borgwarner.jpg)

OBC(On-Board Charger)는 외부 AC 전원을 차량의 고전압 배터리에 맞는 DC 전력으로 변환하는 충전기입니다. 단방향 충전뿐 아니라 설계 목적에 따라 V2L, V2G, ESS 연계처럼 전력 방향이 바뀌는 조건까지 함께 검토할 수 있습니다.

## 시스템을 보는 방법

기본 구조는 `AC 입력 → EMI 필터 → PFC → DC Link → 절연형 DC-DC → 고전압 배터리`입니다. PFC 단계는 입력 전류와 DC Link를 제어하고, 절연형 DC-DC 단계는 절연·전압 변환·배터리 충전 전류 제어를 담당합니다.

- G2V(Grid to Vehicle): 계통 AC 전력을 차량 배터리에 저장하는 기본 충전 경로
- V2L(Vehicle to Load): 배터리 전력을 외부 부하에 공급하는 경로
- V2G(Vehicle to Grid): 차량 배터리와 계통 사이에서 전력이 양방향으로 흐르는 경로
- ESS 연계: 배터리·PCS·계통의 상태와 충전기 전력 방향을 함께 고려하는 응용 조건

## 검증 관점

- AC 입력 전압·주파수 범위에서 PFC 입력 전류, 역률, DC Link 전압이 제어 목표를 만족하는지 확인
- 절연형 DC-DC의 입력·출력 전압 범위와 배터리 충전 전류 지령이 보호 한계 안에서 동작하는지 확인
- 충전 시작·정지, 통신 이상, 과전압·과전류·과온 조건에서 전력 변환 단계가 안전하게 전이하는지 확인
- 양방향 운전에서는 전력 방향, 계통 연계 조건, 배터리 제한 조건이 서로 일관되게 적용되는지 확인

## 공개 범위

여기에는 차량·고객 식별 정보, 회로 구현, 제어 게인, 통신 데이터, 시험 파형·로그를 포함하지 않습니다. 제품 이미지는 공개 제품 이해를 위한 예시입니다.

공개 기술 참고: [Texas Instruments — HEV/EV OBC·DC/DC 설계 자료](https://www.ti.com/applications/automotive/hev-ev-powertrain/hevev-obc-dc-dc-converter/overview.html?subsystemid=18546&variantid=18502) · [BorgWarner — Power Electronics](https://www.borgwarner.com/technologies/power-electronics)

[구성도와 추가 설명이 있는 HTML 문서 보기](./index.html)
