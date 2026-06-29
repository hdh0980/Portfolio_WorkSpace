function result = two_port_abcd_cascade(outputFile)
%TWO_PORT_ABCD_CASCADE Cascade two reciprocal RC sections and plot load response.

if nargin < 1
    here = fileparts(mfilename("fullpath"));
    outputFile = fullfile(here, "..", "assets", "two_port_abcd_cascade.png");
end
ensureOutputFolder(outputFile);

Rseries = 50;
Cshunt = 1e-6;
Zload = 1e3;
f = logspace(1, 6, 3001);
H = zeros(size(f));
normalizedReciprocityResidual = zeros(size(f));

for k = 1:numel(f)
    Z = Rseries;
    Y = 1i*2*pi*f(k)*Cshunt;
    Tseries = [1 Z; 0 1];
    Tshunt = [1 0; Y 1];
    Tstage = Tseries*Tshunt;
    Ttotal = Tstage*Tstage;
    A = Ttotal(1,1);
    B = Ttotal(1,2);
    H(k) = 1/(A + B/Zload);
    determinantError = abs(A*Ttotal(2,2) - B*Ttotal(2,1) - 1);
    cancellationScale = abs(A*Ttotal(2,2)) + abs(B*Ttotal(2,1)) + 1;
    normalizedReciprocityResidual(k) = determinantError/cancellationScale;
end

maxReciprocityResidual = max(normalizedReciprocityResidual);
dcExpected = 1/(1 + 2*Rseries/Zload);
lowFrequencyError = abs(abs(H(1))-dcExpected)/dcExpected;
assert(maxReciprocityResidual < 1e-12, "ABCD reciprocity invariant failed.");
assert(lowFrequencyError < 5e-3, "Low-frequency loading result is inconsistent.");

fig = figure(Visible="off", Color="white", Position=[100 100 960 680]);
tiledlayout(2,1, TileSpacing="compact", Padding="compact");
nexttile;
semilogx(f, 20*log10(abs(H)), LineWidth=1.8, Color=[0.12 0.47 0.71]);
ylabel("|V_L/V_1| (dB)"); grid on;
title("Cascaded RC Two-Port Response Using ABCD Matrices");
subtitle(sprintf("Two stages: R=%.0f ohm, C=%.1f uF, Z_L=%.0f ohm", ...
    Rseries, Cshunt*1e6, Zload));
nexttile;
semilogx(f, rad2deg(angle(H)), LineWidth=1.8, Color=[0.85 0.33 0.10]);
xlabel("Frequency (Hz)"); ylabel("Phase (deg)"); grid on;
exportgraphics(fig, outputFile, Resolution=180, BackgroundColor="white");
close(fig);

result = struct(MaxNormalizedReciprocityResidual=maxReciprocityResidual, ...
    LowFrequencyGain=abs(H(1)), LowFrequencyError=lowFrequencyError, ...
    OutputFile=outputFile);
fprintf("Two-port: low-frequency gain=%.6f, normalized reciprocity residual=%.3e\n", ...
    abs(H(1)), maxReciprocityResidual);
end

function ensureOutputFolder(outputFile)
folder = fileparts(outputFile);
if ~isfolder(folder)
    mkdir(folder);
end
end
