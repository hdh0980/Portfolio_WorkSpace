# ESS 사례 · 계통연계 운전과 보호 조건 검토

## 목적

ESS가 충전·대기·방전 지령에 따라 전력 방향을 바꾸고, 계통 전압·주파수 이상이나 계통 분리 조건에서 요구된 운전 상태로 전이하는지를 확인합니다.

## 확인한 시험 범위

| 항목 | 확인 관점 | 공개 자료 |
| --- | --- | --- |
| ESS Power Control | 충전·대기·방전 상태 전환과 전력 방향 | [자료](./assets/evidence/ul1741_ess_power_control.png) |
| Ramp Rate | 기동·소프트스타트에서 지령 변화율과 출력 변화 | [자료](./assets/evidence/ul1741_ramp_rate.png) |
| Voltage Ride-Through | 전압 이상 영역에서 운전 유지·출력 정지·복귀 조건 | [자료](./assets/evidence/ul1741_voltage_ride_through.png) |
| Frequency Ride-Through | 주파수 이상 영역에서 상태 전이와 전력 회복 조건 | [자료](./assets/evidence/ul1741_frequency_ride_through.png) |
| Anti-Islanding | 계통 분리 검출과 출력 정지 조건 | [자료](./assets/evidence/ul1741_anti_islanding.png) |

## 시스템 관점

PCS의 전력 방향만 보지 않고 배터리 상태, 보호 장치, 계통 조건이 함께 맞아야 안전한 상태 전이가 가능합니다. 각 시험은 입력 조건, 허용 운전 영역, 출력 정지 조건, 정상 복귀 조건을 분리해 읽습니다.

## 공개 자료를 읽는 방법

이미지는 시험 케이스와 해석 관점을 보여 주는 공개용 자료입니다. 측정 파형과 세부 시험 조건은 필요한 범위만 남겼으며, 이미지의 수치·시간을 일반적인 최신 표준 요구값 또는 인증 결과로 해석하지 않습니다.
