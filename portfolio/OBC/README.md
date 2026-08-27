# OBC · 차량 탑재 충전기

이 사례는 차량 탑재 충전기의 AC-DC·절연 DC-DC 전력 경로와 G2V·V2L·V2G 운전 조건을 시스템 관점에서 검토합니다. 특정 차량 또는 고객 프로젝트의 상세 설계를 공개하지 않습니다.

![OBC 제품 예시](./assets/product/obc-borgwarner.jpg)

## 연계 학습 화면

![PFC 전류 제어 학습 화면](../../studies/전공학습/02_제어시스템_설계/lab-assets/labs/pfc-lab.png)

OBC 전력단의 PFC·DC/DC·제어 알고리즘을 이해하기 위해 정리한 공개용 학습 화면입니다. 실제 차량 OBC의 회로·제어소프트웨어·시험 캡처가 아니며, [사례 문서](./CASE_STUDY.md)에서 화면의 사용 범위를 명확히 표시했습니다.

## 사례 문서

- [OBC 사례 읽기](./CASE_STUDY.md)
- [화면형 문서](./index.html)

## 시스템 경계

`AC 입력 → EMI 필터 → PFC → DC Link → 절연형 DC-DC → 고전압 배터리`를 기본 전력 경로로 봅니다. 양방향 조건에서는 배터리, 외부 부하, 계통 사이의 전력 방향과 보호 조건을 함께 확인합니다.

## 공개 범위

차량·고객 식별 정보, 회로 구현, 제어 게인, 통신 데이터, 시험 파형·로그는 포함하지 않습니다. 제품 이미지는 공개 제품 이해를 위한 예시입니다.

공개 기술 참고: [Texas Instruments — HEV/EV OBC·DC/DC 설계 자료](https://www.ti.com/applications/automotive/hev-ev-powertrain/hevev-obc-dc-dc-converter/overview.html?subsystemid=18546&variantid=18502)
