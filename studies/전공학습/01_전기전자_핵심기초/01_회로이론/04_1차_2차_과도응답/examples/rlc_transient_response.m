function result = rlc_transient_response(outputFile)
%RLC_TRANSIENT_RESPONSE Simulate a series-RLC step response with ode45.

if nargin < 1
    here = fileparts(mfilename("fullpath"));
    outputFile = fullfile(here, "..", "assets", "rlc_transient_response.png");
end
ensureOutputFolder(outputFile);

Vs = 10;
R = 20;
L = 50e-3;
C = 100e-6;
tEval = linspace(0, 0.10, 1200);
x0 = [0; 0]; % [inductor current; capacitor voltage]
odefun = @(~, x) [(Vs - R*x(1) - x(2))/L; x(1)/C];
options = odeset(RelTol=1e-9, AbsTol=1e-11);
[t, x] = ode45(odefun, tEval, x0, options);

iL = x(:,1);
vC = x(:,2);
alpha = R/(2*L);
omega0 = 1/sqrt(L*C);
zeta = alpha/omega0;
overshoot = (max(vC)/Vs - 1)*100;
finalError = abs(vC(end) - Vs);

assert(zeta < 1, "Chosen example must be underdamped.");
assert(finalError < 1e-3, "Capacitor voltage did not reach DC steady state.");
assert(abs(iL(end)) < 1e-3, "Inductor current did not approach zero.");

fig = figure(Visible="off", Color="white", Position=[100 100 960 680]);
tiledlayout(2,1, TileSpacing="compact", Padding="compact");
nexttile;
plot(t*1e3, vC, LineWidth=1.8, Color=[0.12 0.47 0.71]);
yline(Vs, "--", "Final value", Color=[0.25 0.25 0.25]);
ylabel("v_C (V)"); grid on;
title("Series RLC Step Response");
subtitle(sprintf("R=%.0f ohm, L=%.0f mH, C=%.0f uF, zeta=%.3f", ...
    R, L*1e3, C*1e6, zeta));
nexttile;
plot(t*1e3, iL, LineWidth=1.8, Color=[0.85 0.33 0.10]);
xlabel("Time (ms)"); ylabel("i_L (A)"); grid on;
exportgraphics(fig, outputFile, Resolution=180, BackgroundColor="white");
close(fig);

result = struct(DampingRatio=zeta, OvershootPercent=overshoot, ...
    FinalVoltageError=finalError, OutputFile=outputFile);
fprintf("RLC transient: zeta=%.6f, overshoot=%.3f%%, final error=%.3e V\n", ...
    zeta, overshoot, finalError);
end
function ensureOutputFolder(outputFile)
folder = fileparts(outputFile);
if ~isfolder(folder)
    mkdir(folder);
end
end
