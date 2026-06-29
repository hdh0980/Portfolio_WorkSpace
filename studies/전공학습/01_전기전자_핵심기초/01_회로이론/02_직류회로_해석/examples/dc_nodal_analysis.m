function result = dc_nodal_analysis(outputFile)
%DC_NODAL_ANALYSIS Solve a two-node resistive circuit and draw the circuit.

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
branchCurrent = [(Vs-v(1))/R1; v(1)/R2; (v(1)-v(2))/R3; v(2)/R4];

assert(residual < 1e-12, "KCL residual is too large.");
assert(norm(v - [6; 3], inf) < 1e-10, "Unexpected node-voltage solution.");
assert(norm(branchCurrent - [6; 3; 3; 3]*1e-3, inf) < 1e-12, ...
    "Unexpected branch-current solution.");

data = struct(Vs=Vs, R=[R1 R2 R3 R4], NodeVoltage=v, ...
    BranchCurrent=branchCurrent, Residual=residual);
render_dc_circuit("nodal", data, outputFile);

result = struct(NodeVoltage=v, BranchCurrent=branchCurrent, ...
    KCLResidual=residual, OutputFile=outputFile);
fprintf("DC nodal: V1=%.6f V, V2=%.6f V, residual=%.3e A\n", ...
    v(1), v(2), residual);
end

function ensureOutputFolder(outputFile)
folder = fileparts(outputFile);
if ~isfolder(folder)
    mkdir(folder);
end
end
