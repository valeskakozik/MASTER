% - - CHECK OCS-PLUS(1) FILES FOR VALIDITY

% - - Valeska Kozik, 15.05.2020
% - - valeskakozik@gmail.com

%... This script checks whether the files are valid and can be used for
%... further analysis
%... It moves invalid files to a new folder (._invalid_files)
%... and produces a directory structure only including valid files.

function directory = Selection_CheckValid(localDir)
%cd(localDir);
clc

directory   = dir([localDir filesep '**' filesep 'SELECTION_data*mat']);
emptyDir    = [localDir filesep '..' filesep '._invalid_files'];

if ~isfolder(emptyDir)
    mkdir(emptyDir)
end

moved = 0;

for i = 1:length(directory)
    clear data ...
          data_fb ...
          data_nfb ...
          scoring
    
    source = fullfile(directory(i).folder, directory(i).name);
    load(source);
    
    basiccheck = exist('scoring', 'var') && ...
                 scoring.notrun.value ~= 1 ||...
                 exist('data', 'var') && ...
                 isempty(data);
    extracheck = exist('data_fb', 'var') && ...
                 isfield(data_fb, 'taps') && ...
                 isempty(data_fb.taps) && ...
                 exist('data_nfb', 'var') && ...
                 isfield(data_nfb, 'taps') && ...
                 isempty(data_nfb.taps);
    
    if basiccheck || extracheck
        status = movefile(source, emptyDir, 'f');
        
        if ~status
            fprintf('Error moving file "%s"!\n', directory(i).name)
        else
            moved = moved + 1;
        end
    end
end

%... print what's happening to the command window
fprintf('Found %3.0f SELECTION file(s).\n', length(directory))
fprintf('%3.0f invalid SELECTION file(s) moved to "%s"!\n', moved, emptyDir)
fprintf('%3.0f valid SELECTION file(s) remaining.\n', length(directory) - moved)

%... new directory structure with valid files only
directory = dir([localDir filesep '**' filesep 'SELECTION_data*mat']);

% (1) Demeyere, N., Haupt, M., Webb, S. S., Strobel, L., Milosevich, E., 
% Moore, M. J., . . . Duta, M. (2020). The Oxford Cognitive Screen–Plus 
% (OCS-Plus): a tablet based short cognitive screening tool for milder 
% cognitive impairment.