function result = dc_mesh_analysis(outputFile)
%DC_MESH_ANALYSIS Solve a two-mesh circuit and draw the circuit.

if nargin < 1
    here = fileparts(mfilename("fullpath"));
    outputFile = fullfile(here, "..", "assets", "dc_mesh_analysis.png");
end
ensureOutputFolder(outputFile);

Vs = 12;
R1 = 2e3;
R2 = 3e3;
R3 = 1e3;

A = [R1+R3, -R3; -R3, R2+R3];
b = [Vs; 0];
meshCurrent = A \ b;
sharedBranchCurrent = meshCurrent(1) - meshCurrent(2);
residual = norm(A*meshCurrent - b, inf);

assert(residual < 1e-12, "KVL residual is too large.");
assert(norm(meshCurrent - [48; 12]/11*1e-3, inf) < 1e-12, ...
    "Unexpected mesh-current solution.");
assert(abs(sharedBranchCurrent - 36/11*1e-3) < 1e-12, ...
    "Unexpected shared-branch current.");

data = struct(Vs=Vs, R=[R1 R2 R3], MeshCurrent=meshCurrent, ...
    SharedBranchCurrent=sharedBranchCurrent, Residual=residual);
render_dc_circuit("mesh", data, outputFile);

result = struct(MeshCurrent=meshCurrent, ...
    SharedBranchCurrent=sharedBranchCurrent, KVLResidual=residual, ...
    OutputFile=outputFile);
fprintf("DC mesh: i1=%.6f mA, i2=%.6f mA, shared=%.6f mA, residual=%.3e V\n", ...
    meshCurrent(1)*1e3, meshCurrent(2)*1e3, ...
    sharedBranchCurrent*1e3, residual);
end

function ensureOutputFolder(outputFile)
folder = fileparts(outputFile);
if ~isfolder(folder)
    mkdir(folder);
end
end
