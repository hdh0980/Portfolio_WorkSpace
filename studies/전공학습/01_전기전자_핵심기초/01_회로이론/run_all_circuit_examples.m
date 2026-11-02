function results = run_all_circuit_examples()
%RUN_ALL_CIRCUIT_EXAMPLES Execute and verify every circuit-theory example.

courseRoot = fileparts(mfilename("fullpath"));
units = ["02_직류회로_해석", "04_1차_2차_과도응답", ...
    "06_교류전력과_3상회로", "07_공진과_주파수응답", "09_결합회로와_2포트망"];
for k = 1:numel(units)
    addpath(fullfile(courseRoot, units(k), "01_MATLAB_코드"));
end
cleanup = onCleanup(@() removeExamplePaths(courseRoot, units)); %#ok<NASGU>

results = struct;
dcResults = run_dc_analysis_examples(fullfile(courseRoot, ...
    "02_직류회로_해석", "02_결과_그림"));
results.DCNodal = dcResults.Nodal;
results.DCMesh = dcResults.Mesh;
results.DCSupernode = dcResults.Supernode;
results.RLCTransient = rlc_transient_response(fullfile(courseRoot, ...
    "04_1차_2차_과도응답", "02_결과_그림", "rlc_transient_response.png"));
results.ThreePhase = three_phase_power(fullfile(courseRoot, ...
    "06_교류전력과_3상회로", "02_결과_그림", "three_phase_power.png"));
results.RLCResonance = series_rlc_frequency_response(fullfile(courseRoot, ...
    "07_공진과_주파수응답", "02_결과_그림", "series_rlc_frequency_response.png"));
results.TwoPort = two_port_abcd_cascade(fullfile(courseRoot, ...
    "09_결합회로와_2포트망", "02_결과_그림", "two_port_abcd_cascade.png"));

names = fieldnames(results);
for k = 1:numel(names)
    fileInfo = dir(results.(names{k}).OutputFile);
    assert(~isempty(fileInfo) && fileInfo.bytes > 10e3, ...
        "Capture was not generated or is unexpectedly small: %s", names{k});
end
fprintf("ALL CIRCUIT EXAMPLES PASSED: %d simulations and %d captures\n", ...
    numel(names), numel(names));
end

function removeExamplePaths(courseRoot, units)
for k = 1:numel(units)
    rmpath(fullfile(courseRoot, units(k), "01_MATLAB_코드"));
end
end
