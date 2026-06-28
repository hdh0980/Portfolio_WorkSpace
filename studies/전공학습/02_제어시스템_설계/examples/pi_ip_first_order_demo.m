%% PI and IP reference-response comparison for a first-order plant
% Learning example based on the PI/IP topic below. The equations and code
% structure are independently reconstructed for this repository.
% Reference: https://blog.naver.com/lagrange0115/221157947738
%
% Requirement: MATLAB Control System Toolbox

clear;
close all;
clc;

%% Plant and controller parameters
plantGain = 1.0;
timeConstant = 0.5;  % [s]

kp = 1.5;
ki = 4.0;

s = tf('s');
plant = plantGain / (timeConstant * s + 1);

%% Closed-loop transfer functions
% PI: u = Kp*(r-y) + Ki/s*(r-y)
piController = kp + ki / s;
piClosedLoop = minreal(feedback(piController * plant, 1));

% IP: u = Ki/s*(r-y) - Kp*y
% The characteristic denominator is the same as the PI controller, while
% the proportional term is removed from the reference numerator.
ipClosedLoop = minreal((plant * ki / s) / (1 + plant * (kp + ki / s)));

%% Simulate identical unit-step commands
simulationTime = linspace(0, 4, 1001);
[piOutput, piTime] = step(piClosedLoop, simulationTime);
[ipOutput, ipTime] = step(ipClosedLoop, simulationTime);

piInfo = stepinfo(piOutput, piTime);
ipInfo = stepinfo(ipOutput, ipTime);

fprintf('PI: rise %.4f s, settling %.4f s, overshoot %.2f %%\n', ...
    piInfo.RiseTime, piInfo.SettlingTime, piInfo.Overshoot);
fprintf('IP: rise %.4f s, settling %.4f s, overshoot %.2f %%\n', ...
    ipInfo.RiseTime, ipInfo.SettlingTime, ipInfo.Overshoot);

%% Plot
figure('Color', 'w');
plot(piTime, piOutput, 'LineWidth', 1.8);
hold on;
plot(ipTime, ipOutput, '--', 'LineWidth', 1.8);
yline(1.0, ':', 'Reference', 'LineWidth', 1.2);
grid on;
xlabel('Time [s]');
ylabel('Normalized output');
title('PI vs. IP reference response');
legend('PI', 'IP', 'Location', 'southeast');

%% Review questions
% 1. Why do PI and IP have the same characteristic denominator?
% 2. Which numerator creates the different reference response?
% 3. How do actuator saturation and anti-windup change this comparison?
% 4. Does the conclusion remain valid when delay and measurement filters
%    are added to the plant model?
