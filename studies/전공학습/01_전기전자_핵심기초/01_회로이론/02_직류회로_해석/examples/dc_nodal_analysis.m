function result = dc_nodal_analysis(outputFile)
%DC_NODAL_ANALYSIS Solve a two-node resistive circuit and export a capture.

if nargin < 1
    here = fileparts(mfilename("fullpath"));
    outputFile = fullfile(here, "..", "assets", "dc_nodal_analysis.png");
end
ensureOutputFolder(outputFile);

Vs = 12;
R1 = 1e3;
R2 = 2e3;
R3 = 1e3;
R4 = 1e3;

G = [1/R1 + 1/R2 + 1/R3, -1/R3; ...
     -1/R3,                    1/R3 + 1/R4];
b = [Vs/R1; 0];
v = G \ b;
residual = norm(G*v - b, inf);

assert(residual < 1e-12, "KCL residual is too large.");
assert(norm(v - [6; 3], inf) < 1e-10, "Unexpected node-voltage solution.");

fig = figure(Visible="off", Color="white", Position=[100 100 900 520]);
bar(categorical(["V1", "V2"]), v, 0.55, FaceColor=[0.16 0.45 0.72]);
ylabel("Node voltage (V)");
title("DC Nodal Analysis");
subtitle(sprintf("V_1 = %.3f V, V_2 = %.3f V, KCL residual = %.2e A", ...
    v(1), v(2), residual));
grid on;
ylim([0, 1.2*max(v)]);
exportgraphics(fig, outputFile, Resolution=180, BackgroundColor="white");
close(fig);

result = struct(NodeVoltage=v, KCLResidual=residual, OutputFile=outputFile);
fprintf("DC nodal: V1=%.6f V, V2=%.6f V, residual=%.3e A\n", ...
    v(1), v(2), residual);
end
function ensureOutputFolder(outputFile)
folder = fileparts(outputFile);
if ~isfolder(folder)
    mkdir(folder);
end
end
