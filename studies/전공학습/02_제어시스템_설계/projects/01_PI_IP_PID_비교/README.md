# PI, IP, and PID Control Comparison

> Status: learning notes are available in the parent category. Simulation and
> verification artifacts will be added incrementally.

## Reference material

- https://blog.naver.com/lagrange0115/221157947738
- https://embeddedchallenge.tistory.com/491
- https://setoo0922.tistory.com/259

## Workspace map

- `docs/`: problem definition, theory, modeling, controller design, tuning, and validation notes.
- `models/`: MATLAB and Simulink artifacts.
- `src/`: implementation code.
- `tests/`: simulation and hardware verification artifacts.
- `assets/`: block diagrams, plots, and photos used in public documentation.
- `references/`: source list and attribution notes.

## Current example

- [`../../examples/pi_ip_first_order_demo.m`](../../examples/pi_ip_first_order_demo.m):
  compares PI and IP reference responses for the same first-order plant and gains.
