function result = series_rlc_frequency_response(outputFile)
%SERIES_RLC_FREQUENCY_RESPONSE Sweep the resistor-voltage response of a series RLC.

if nargin < 1
    here = fileparts(mfilename("fullpath"));
    outputFile = fullfile(here, "..", "assets", "series_rlc_frequency_response.png");
end
ensureOutputFolder(outputFile);

R = 20;
L = 10e-3;
C = 10e-6;
f = logspace(1, 5, 5001);
w = 2*pi*f;
H = R ./ (R + 1i*(w*L - 1./(w*C)));
[peakMagnitude, peakIndex] = max(abs(H));
peakFrequency = f(peakIndex);
theoreticalFrequency = 1/(2*pi*sqrt(L*C));
frequencyError = abs(peakFrequency-theoreticalFrequency)/theoreticalFrequency;
qualityFactor = 2*pi*theoreticalFrequency*L/R;
bandwidth = R/(2*pi*L);

assert(frequencyError < 2e-3, "Frequency sweep did not resolve resonance.");
assert(abs(peakMagnitude-1) < 1e-4, "Resistor voltage should equal input at resonance.");

fig = figure(Visible="off", Color="white", Position=[100 100 960 680]);
tiledlayout(2,1, TileSpacing="compact", Padding="compact");
nexttile;
semilogx(f, 20*log10(abs(H)), LineWidth=1.8, Color=[0.12 0.47 0.71]);
xline(theoreticalFrequency, "--", "f_0", Color=[0.2 0.2 0.2]);
ylabel("Magnitude (dB)"); grid on;
title("Series RLC Frequency Response (V_R / V_{in})");
subtitle(sprintf("f_0=%.2f Hz, Q=%.3f, BW=%.2f Hz", ...
    theoreticalFrequency, qualityFactor, bandwidth));
nexttile;
semilogx(f, rad2deg(angle(H)), LineWidth=1.8, Color=[0.85 0.33 0.10]);
xline(theoreticalFrequency, "--", "f_0", Color=[0.2 0.2 0.2]);
xlabel("Frequency (Hz)"); ylabel("Phase (deg)"); grid on;
exportgraphics(fig, outputFile, Resolution=180, BackgroundColor="white");
close(fig);

result = struct(TheoreticalFrequency=theoreticalFrequency, ...
    PeakFrequency=peakFrequency, FrequencyError=frequencyError, ...
    QualityFactor=qualityFactor, Bandwidth=bandwidth, OutputFile=outputFile);
fprintf("RLC resonance: theory=%.6f Hz, sweep=%.6f Hz, error=%.3e\n", ...
    theoreticalFrequency, peakFrequency, frequencyError);
end
function ensureOutputFolder(outputFile)
folder = fileparts(outputFile);
if ~isfolder(folder)
    mkdir(folder);
end
end
