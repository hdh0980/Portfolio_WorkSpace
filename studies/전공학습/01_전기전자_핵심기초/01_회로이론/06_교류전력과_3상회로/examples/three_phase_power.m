function result = three_phase_power(outputFile)
%THREE_PHASE_POWER Verify balanced three-phase power in time and phasor forms.

if nargin < 1
    here = fileparts(mfilename("fullpath"));
    outputFile = fullfile(here, "..", "assets", "three_phase_power.png");
end
ensureOutputFolder(outputFile);

f = 60;
VlineRms = 380;
IlineRms = 10;
powerFactor = 0.9;
phi = acos(powerFactor);
VphaseRms = VlineRms/sqrt(3);
t = linspace(0, 2/f, 4001);
phase = [0; -2*pi/3; 2*pi/3];
v = sqrt(2)*VphaseRms*cos(2*pi*f*t + phase);
i = sqrt(2)*IlineRms*cos(2*pi*f*t + phase - phi);
pTotal = sum(v.*i, 1);

apparentPower = sqrt(3)*VlineRms*IlineRms;
activePower = apparentPower*powerFactor;
reactivePower = apparentPower*sin(phi);
activePowerTime = trapz(t, pTotal)/(t(end)-t(1));
relativeError = abs(activePowerTime-activePower)/activePower;

assert(relativeError < 1e-10, "Time-domain and phasor active power disagree.");
assert((max(pTotal)-min(pTotal))/activePower < 1e-10, ...
    "Balanced total instantaneous power should be constant.");

fig = figure(Visible="off", Color="white", Position=[100 100 980 760]);
tiledlayout(3,1, TileSpacing="compact", Padding="compact");
nexttile;
plot(t*1e3, v, LineWidth=1.2); grid on;
ylabel("Phase voltage (V)"); title("Balanced Three-Phase Power");
legend("v_a", "v_b", "v_c", Location="eastoutside");
nexttile;
plot(t*1e3, i, LineWidth=1.2); grid on;
ylabel("Line current (A)");
legend("i_a", "i_b", "i_c", Location="eastoutside");
nexttile;
plot(t*1e3, pTotal/1e3, LineWidth=1.8, Color=[0.49 0.18 0.56]); grid on;
xlabel("Time (ms)"); ylabel("Total p(t) (kW)");
subtitle(sprintf("P=%.3f kW, Q=%.3f kvar, PF=%.2f lagging", ...
    activePower/1e3, reactivePower/1e3, powerFactor));
exportgraphics(fig, outputFile, Resolution=180, BackgroundColor="white");
close(fig);

result = struct(ActivePower=activePower, ReactivePower=reactivePower, ...
    ApparentPower=apparentPower, RelativeError=relativeError, OutputFile=outputFile);
fprintf("Three-phase: P=%.6f W, Q=%.6f var, S=%.6f VA, error=%.3e\n", ...
    activePower, reactivePower, apparentPower, relativeError);
end
function ensureOutputFolder(outputFile)
folder = fileparts(outputFile);
if ~isfolder(folder)
    mkdir(folder);
end
end
