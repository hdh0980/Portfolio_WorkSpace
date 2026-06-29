function results = run_dc_analysis_examples(outputFolder)
%RUN_DC_ANALYSIS_EXAMPLES Solve and render the three worked DC circuits.

if nargin < 1
    here = fileparts(mfilename("fullpath"));
    outputFolder = fullfile(here, "..", "assets");
end
if ~isfolder(outputFolder)
    mkdir(outputFolder);
end

results = struct;
results.Nodal = dc_nodal_analysis(fullfile(outputFolder, ...
    "dc_nodal_analysis.png"));
results.Mesh = dc_mesh_analysis(fullfile(outputFolder, ...
    "dc_mesh_analysis.png"));
results.Supernode = dc_supernode_analysis(fullfile(outputFolder, ...
    "dc_supernode_analysis.png"));
end
