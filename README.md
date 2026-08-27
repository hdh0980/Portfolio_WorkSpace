# 전력변환 포트폴리오

UPS, ESS, OBC 개발·검증 경험과 전력전자 학습 기록을 공개 가능한 범위에서 정리한 저장소입니다. 각 문서는 시스템 구성, 전력 흐름, 운전 조건, 검증 관점을 중심으로 읽을 수 있으며 고객·제품 식별 정보, 제어 파라미터, 원본 시험 데이터는 포함하지 않습니다.

<table>
  <tr>
    <td width="50%" valign="top">
      <a href="./portfolio/UPS/README.md"><img src="./assets/products/ups-schneider-galaxy-300.jpg" alt="UPS 제품 예시" width="100%"></a><br>
      <strong><a href="./portfolio/UPS/README.md">UPS</a></strong><br>
      정전 시 부하를 유지하기 위한 오프라인·라인 인터랙티브·온라인 UPS의 구성과 운전 방식, 절체·정류·인버터 검증 관점
    </td>
    <td width="50%" valign="top">
      <a href="./portfolio/ESS/README.md"><img src="./assets/products/ess-tesla-megapack.jpg" alt="ESS 제품 예시" width="100%"></a><br>
      <strong><a href="./portfolio/ESS/README.md">ESS</a></strong><br>
      배터리, BMS, PCS, 계통 연계가 연결된 에너지저장시스템의 전력 흐름과 보호·운전 상태 검토
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <a href="./portfolio/OBC/README.md"><img src="./assets/products/obc-borgwarner.jpg" alt="OBC 제품 예시" width="100%"></a><br>
      <strong><a href="./portfolio/OBC/README.md">OBC</a></strong><br>
      차량 탑재 충전기의 AC-DC·절연 DC-DC 구조와 G2V·V2L·V2G·ESS 전력 흐름 검토
    </td>
    <td width="50%" valign="top">
      <a href="./AI_Engineering/README.md"><img src="./assets/labs/control-algorithm-overview.png" alt="전력전자 랩 제어 알고리즘 화면" width="100%"></a><br>
      <strong><a href="./AI_Engineering/README.md">전력전자 랩</a></strong><br>
      제어 이론과 전력변환 토폴로지를 수식, 파형, 시뮬레이션 관점에서 정리한 학습 기록과 작업 환경
    </td>
  </tr>
</table>

## 페이지별 내용

| 구분 | GitHub에서 읽을 내용 | 문서 |
| --- | --- | --- |
| UPS | 전원 이상 시 전력 경로, UPS 방식별 차이, 검증 시 확인할 입력·출력·절체 조건 | [README](./portfolio/UPS/README.md) · [HTML 문서](./portfolio/UPS/index.html) |
| ESS | 배터리·BMS·PCS·계통의 역할, 충·방전 전력 흐름, 보호와 상태 전이 관점 | [README](./portfolio/ESS/README.md) · [HTML 문서](./portfolio/ESS/index.html) |
| OBC | PFC와 절연형 DC-DC 단계, V2G·V2L·ESS 연계 시 양방향 전력 흐름 | [README](./portfolio/OBC/README.md) · [HTML 문서](./portfolio/OBC/index.html) |
| 전력전자 랩 | 제어 알고리즘, DC-DC, PFC, DAB, SRDAB, LLC/CLLC 학습 화면과 공개 오픈소스 설정 출처 | [README](./AI_Engineering/README.md) |

## 읽는 기준

- 폴더를 열면 먼저 각 폴더의 `README.md`에서 구조와 범위를 확인할 수 있습니다.
- `index.html`은 다이어그램과 이미지를 포함한 페이지 원본입니다.
- 제품 이미지는 공개 제품 이해를 돕기 위한 예시이며, 업무 수행 제품 또는 고객 정보를 의미하지 않습니다.
- 포트폴리오에는 일반화한 구조와 검증 관점만 수록합니다. 내부 회로, 보정값, 시험 로그, 고객·제품 식별 정보는 제외합니다.

## 저장소 구조

```text
Portfolio_WorkSpace/
├─ portfolio/
│  ├─ UPS/                 # 무정전전원장치
│  ├─ ESS/                 # 에너지저장시스템
│  └─ OBC/                 # 차량 탑재 충전기
├─ AI_Engineering/         # 전력전자 랩과 공개 스킬·설정 출처
├─ assets/                 # 공개 제품 이미지와 학습 화면
└─ studies/                # 전공학습 기록
```
