function tests = test_dc_analysis_examples
%TEST_DC_ANALYSIS_EXAMPLES Verify the worked circuits and circuit captures.
tests = functiontests(localfunctions);
end

function testNodalCircuit(testCase)
outputFile = tempPng();
cleanup = onCleanup(@() deleteIfPresent(outputFile)); %#ok<NASGU>

result = dc_nodal_analysis(outputFile);

verifyEqual(testCase, result.NodeVoltage, [6; 3], AbsTol=1e-10);
verifyEqual(testCase, result.BranchCurrent, ...
    [6; 3; 3; 3]*1e-3, AbsTol=1e-12);
verifyLessThan(testCase, result.KCLResidual, 1e-12);
verifyCircuitCapture(testCase, outputFile);
end

function testMeshCircuit(testCase)
outputFile = tempPng();
cleanup = onCleanup(@() deleteIfPresent(outputFile)); %#ok<NASGU>

result = dc_mesh_analysis(outputFile);

verifyEqual(testCase, result.MeshCurrent, [48; 12]/11*1e-3, ...
    AbsTol=1e-12);
verifyEqual(testCase, result.SharedBranchCurrent, 36/11*1e-3, ...
    AbsTol=1e-12);
verifyLessThan(testCase, result.KVLResidual, 1e-12);
verifyCircuitCapture(testCase, outputFile);
end

function testSupernodeCircuit(testCase)
outputFile = tempPng();
cleanup = onCleanup(@() deleteIfPresent(outputFile)); %#ok<NASGU>

result = dc_supernode_analysis(outputFile);

verifyEqual(testCase, result.NodeVoltage, [6.8; 1.8], AbsTol=1e-10);
verifyLessThan(testCase, result.KCLResidual, 1e-12);
verifyLessThan(testCase, result.ConstraintResidual, 1e-12);
verifyCircuitCapture(testCase, outputFile);
end

function testDcExampleRunner(testCase)
outputFolder = string(tempname);
mkdir(outputFolder);
cleanup = onCleanup(@() removeFolderIfPresent(outputFolder)); %#ok<NASGU>

results = run_dc_analysis_examples(outputFolder);

verifyEqual(testCase, sort(string(fieldnames(results))), ...
    sort(["Nodal"; "Mesh"; "Supernode"]));
verifyEqual(testCase, numel(dir(fullfile(outputFolder, "*.png"))), 3);
verifyEqual(testCase, results.Nodal.NodeVoltage, [6; 3], AbsTol=1e-10);
verifyEqual(testCase, results.Mesh.MeshCurrent, [48; 12]/11*1e-3, ...
    AbsTol=1e-12);
verifyEqual(testCase, results.Supernode.NodeVoltage, [6.8; 1.8], ...
    AbsTol=1e-10);
end

function verifyCircuitCapture(testCase, outputFile)
verifyTrue(testCase, isfile(outputFile));
info = imfinfo(outputFile);
verifyGreaterThanOrEqual(testCase, info.Width, 1000);
verifyGreaterThanOrEqual(testCase, info.Height, 600);
end

function outputFile = tempPng()
outputFile = string(tempname) + ".png";
end

function deleteIfPresent(outputFile)
if isfile(outputFile)
    delete(outputFile);
end
end

function removeFolderIfPresent(folder)
if isfolder(folder)
    rmdir(folder, "s");
end
end
