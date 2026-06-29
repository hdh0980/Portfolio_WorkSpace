function results = run_all_circuit_examples()
%RUN_ALL_CIRCUIT_EXAMPLES Execute and verify every circuit-theory example.

courseRoot = fileparts(fileparts(mfilename("fullpath")));
units = ["02_직류회로_해석", "04_1차_2차_과도응답", ...
    "06_교류전력과_3상회로", "07_공진과_주파수응답", "09_결합회로와_2포트망"];
for k = 1:numel(units)
    addpath(fullfile(courseRoot, units(k), "examples"));
end
cleanup = onCleanup(@() removeExamplePaths(courseRoot, units)); %#ok<NASGU>

results = struct;
results.DCNodal = dc_nodal_analysis(fullfile(courseRoot, ...
    "02_직류회로_해석", "assets", "dc_nodal_analysis.png"));
results.RLCTransient = rlc_transient_response(fullfile(courseRoot, ...
    "04_1차_2차_과도응답", "assets", "rlc_transient_response.png"));
results.ThreePhase = three_phase_power(fullfile(courseRoot, ...
    "06_교류전력과_3상회로", "assets", "three_phase_power.png"));
results.RLCResonance = series_rlc_frequency_response(fullfile(courseRoot, ...
    "07_공진과_주파수응답", "assets", "series_rlc_frequency_response.png"));
results.TwoPort = two_port_abcd_cascade(fullfile(courseRoot, ...
    "09_결합회로와_2포트망", "assets", "two_port_abcd_cascade.png"));

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
    rmpath(fullfile(courseRoot, units(k), "examples"));
end
end
