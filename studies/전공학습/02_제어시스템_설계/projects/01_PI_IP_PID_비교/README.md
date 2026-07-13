# PI·IP·PID 응답 비교

같은 1차 플랜트에 PI와 IP를 적용했을 때, 폐루프 극점은 같아도 목표값 응답이
달라지는 점을 확인하기 위한 간단한 예제다. PI는 목표값 변화에 비례항이 바로
반응하고, IP는 그 반응을 줄여 지령 변경 시의 kick을 완화하는 구조다.

## 확인할 내용

- 같은 $K_p$, $K_i$에서 PI와 IP의 지령 추종 응답 비교
- 오버슈트와 초기 제어입력 변화 확인
- 실제 적용 시 anti-windup, 출력 제한, 센서 잡음이 추가되면 무엇이 달라지는지 검토

## 실행 파일

- [`../../examples/pi_ip_first_order_demo.m`](../../examples/pi_ip_first_order_demo.m):
  1차 플랜트의 PI·IP 응답을 계산하고 비교 그래프를 생성한다.

이 예제는 구조 차이를 보기 위한 시작점이다. 실제 전력변환기 제어기로 옮길 때는
샘플링 주기, PWM 지연, 출력 포화, 모드 전환을 모델에 포함해 다시 확인해야 한다.

## 참고

- https://blog.naver.com/lagrange0115/221157947738
- https://embeddedchallenge.tistory.com/491
- https://setoo0922.tistory.com/259
