function result = dc_supernode_analysis(outputFile)
%DC_SUPERNODE_ANALYSIS Solve a two-node supernode circuit and draw it.

if nargin < 1
    here = fileparts(mfilename("fullpath"));
    outputFile = fullfile(here, "..", "assets", "dc_supernode_analysis.png");
end
ensureOutputFolder(outputFile);

Is = 4e-3;
Vs = 5;
R1 = 2e3;
R2 = 3e3;

A = [1/R1, 1/R2; 1, -1];
b = [Is; Vs];
nodeVoltage = A \ b;
kclResidual = abs(nodeVoltage(1)/R1 + nodeVoltage(2)/R2 - Is);
constraintResidual = abs(nodeVoltage(1) - nodeVoltage(2) - Vs);
branchCurrent = [nodeVoltage(1)/R1; nodeVoltage(2)/R2];

assert(kclResidual < 1e-12, "Supernode KCL residual is too large.");
assert(constraintResidual < 1e-12, ...
    "Voltage-source constraint residual is too large.");
assert(norm(nodeVoltage - [6.8; 1.8], inf) < 1e-10, ...
    "Unexpected supernode voltage solution.");

data = struct(Is=Is, Vs=Vs, R=[R1 R2], NodeVoltage=nodeVoltage, ...
    BranchCurrent=branchCurrent, Residual=max(kclResidual, constraintResidual));
render_dc_circuit("supernode", data, outputFile);

result = struct(NodeVoltage=nodeVoltage, BranchCurrent=branchCurrent, ...
    KCLResidual=kclResidual, ConstraintResidual=constraintResidual, ...
    OutputFile=outputFile);
fprintf("DC supernode: Va=%.6f V, Vb=%.6f V, KCL=%.3e A, constraint=%.3e V\n", ...
    nodeVoltage(1), nodeVoltage(2), kclResidual, constraintResidual);
end

function ensureOutputFolder(outputFile)
folder = fileparts(outputFile);
if ~isfolder(folder)
    mkdir(folder);
end
end
