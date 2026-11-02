# ESS · 에너지저장시스템

계통연계 ESS PCS의 충·방전 전력 제어, Ramp Rate, 전압·주파수 Ride-Through, Anti-Islanding을 UL 1741 SA 항목 기준으로 HILS에서 시험한 사례입니다.

![ESS 제품 예시 (Tesla Megapack)](./assets/product/ess-tesla-megapack.jpg)

*제품 예시 사진(Tesla). 실제 업무 제품과는 무관합니다.*

## 대표 캡처

![충방전 전력 제어 HILS 결과](./assets/evidence/ul1741_ess_power_control.png)

충전·방전 정격 전력 제어와 모드 전환 파형입니다(R상 계통전압 200 V/div, 계통전류 50 A/div, 파형은 모자이크 처리). 나머지 네 항목은 [사례 문서](./CASE_STUDY.md)에 있습니다.

## 시스템 경계

`배터리 랙 ↔ BMS·보호 장치 ↔ DC Bus ↔ PCS ↔ 계통 또는 부하`를 기준으로 봅니다. PCS의 전력 방향과 계통 이상 때의 상태 전이를 나눠서 시험했습니다.

## 문서

- [사례 문서](./CASE_STUDY.md) · [화면형 문서](./index.html)
- 제어 설계 기록: [ESS HILS 기반 계통연계 기능 검증](../../studies/전공학습/02_제어시스템_설계/04_업무_설계기록/03_ESS_HILS_계통연계_기능검증.md)

참고: [U.S. DOE — BESS 구성요소와 기능](https://www.energy.gov/sites/default/files/2025-01/BESSIE_supply-chain-battery-report_111124_OPENRELEASE_SJ_1.pdf)
