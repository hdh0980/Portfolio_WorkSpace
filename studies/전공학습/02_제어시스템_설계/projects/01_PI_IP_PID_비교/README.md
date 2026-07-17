# PI·IP·PID 응답 비교

같은 1차 플랜트에 PI와 IP를 적용해 지령 응답만 비교한 작은 MATLAB 예제다. 두
구조는 특성방정식이 같아도 목표값 경로의 분자가 달라, PI 쪽이 먼저 반응하고 IP는
상대적으로 완만하게 따라간다. 실제 적용에서 IP 구조를 검토한 이유도 지령 변화 때
비례항이 한 번에 튀는 현상을 줄이기 위해서였다.

## 확인할 내용

- 같은 $K_p$, $K_i$에서 PI와 IP의 지령 추종 응답 비교
- 오버슈트와 초기 제어입력 변화 확인
- 실제 적용 시 anti-windup, 출력 제한, 센서 잡음이 추가되면 무엇이 달라지는지 검토

## 실행 파일

- [`../../examples/pi_ip_first_order_demo.m`](../../examples/pi_ip_first_order_demo.m):
  1차 플랜트의 PI·IP 응답을 계산하고 아래 PNG를 다시 생성한다.

![MATLAB으로 다시 생성한 PI·IP 지령 응답](../../assets/pi_ip_reference_response.png)

*동일한 플랜트와 gain에서 실행한 결과. 이번 조건에서는 PI의 상승시간이 약 0.56 s,
IP가 약 0.99 s로 나타났고, 오버슈트는 각각 약 2.03%, 0.26%였다. 이 수치는 예제
파라미터의 결과이며 제품 제어기의 tuning 값은 아니다.*

이 예제는 구조 차이를 보기 위한 시작점이다. 실제 전력변환기 제어기로 옮길 때는
샘플링 주기, PWM 지연, 출력 포화, 모드 전환을 모델에 포함해 다시 확인해야 한다.

## 참고

- https://blog.naver.com/lagrange0115/221157947738
- https://embeddedchallenge.tistory.com/491
- https://setoo0922.tistory.com/259
