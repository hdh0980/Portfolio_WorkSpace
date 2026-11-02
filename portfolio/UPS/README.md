# UPS · 무정전전원장치

병렬 UPS에서 정상상태 전류 분담, 부하 투입, 운전 중 모듈 분리 때 출력이 끊기지 않는지 시험한 사례입니다.

![UPS 제품 예시 (Schneider Electric Galaxy 300)](./assets/product/ups-schneider-galaxy-300.jpg)

*제품 예시 사진(Schneider Electric). 실제 업무 제품과는 무관합니다.*

## 대표 캡처

![병렬운전 전류 분담과 출력 파형](./assets/evidence/ups_parallel_waveform.png)

2대 병렬 정상상태 파형입니다. 모듈 전류 5.31 A / 4.81 A로, 평균 대비 약 ±5 % 안에서 분담합니다. 부하 투입과 모듈 분리 파형은 [사례 문서](./CASE_STUDY.md)에 있습니다.

## 시스템 경계

`상용 AC 입력 → 정류·충전 → DC Link·배터리 → 인버터 → 중요 부하`를 기본 경로로 봅니다. 병렬 구성에서는 모듈별 출력 전류와 공통 부하 전압을 같이 봅니다.

## 문서

- [사례 문서](./CASE_STUDY.md) · [화면형 문서](./index.html)
- 제어 설계 기록: [3레벨 UPS 출력전압 제어와 부하전류 보상](../../studies/전공학습/02_제어시스템_설계/04_업무_설계기록/01_3레벨_UPS_출력전압제어.md) · [UPS 병렬운전과 순환전류 억제](../../studies/전공학습/02_제어시스템_설계/04_업무_설계기록/02_UPS_병렬운전_제어.md)

참고: [Eaton — UPS 유형](https://www.eaton.com/us/en-us/products/backup-power-ups-surge-it-power-distribution/backup-power-ups/types-of-ups-systems.html)
