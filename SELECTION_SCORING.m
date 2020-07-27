% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
% - - OCS-PLUS SELECTION TASK(1) SCORING SCRIPT
% - - Valeska Kozik, 15.05.2020
% - - valeskakozik@gmail.com
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
function SELECTION_SCORING
%... This script produces a comma separated file (.csv) with participants
%... in rows and variables in columns.

format long;
waitfor(msgbox('Next, please choose the folder where all the .mat files are. The folder should contain subfolders named "Patients" and "Controls"'));
ddir = uigetdir; %choose the folder which contains the raw data in subfolders
fDir = Selection_CheckValid(ddir);

for i = 1:length(fDir)
ID                  = strfind(fDir(i).folder, filesep);
file                = fullfile(fDir(i).folder, fDir(i).name);
load(file);

for fb = 1:2 
    
    if fb == 1 %FEEDBACK condition
               
        if isfield(data_fb_proc.scores, 'selection')
            scores = data_fb_proc.scores.selection;
        else
            scores = data_fb_proc.scores;
        end
        
        marked = data_fb.marked.obj_inds;
        taps   = data_fb.taps; 
        
    else %NO FEEDBACK condition

        if isfield(data_nfb_proc.scores, 'selection')
            scores = data_nfb_proc.scores.selection;
        else
            scores = data_nfb_proc.scores;
        end
        
        marked = data_nfb.marked.obj_inds;
        taps   = data_nfb.taps;
    end
    
%... The structure 'S' temporarily stores all scoring information for the
%... current participant   
S.ID        = {fDir(i).folder( ID(end) + 1 : end )};
S.Group     = fDir(i).folder( ID(end - 1) + 1 : ID(end) - 1 );
    
if strcmpi(S.Group(1), 'p') %numerical expression of group (easier to work with in R)
  S.Group = 1; %Patients
else
  S.Group = 0; %Controls
end

%... Accuracy
S.Accuracy               = scores.total_correct / 30 * 100;

%... Time & Space
S.Time                   = taps(end).time - taps(1).time;
[S.Latency, ...
 S.Distance, ...
 S.SearchSpeed]          = Selection_TimeAndSpace(taps);                
[S.Intersections, ...
S.Intersections_adj]     = Selection_LineSegmentIntersections(taps, marked);  
S.BestR                  = Selection_bestR(taps);

%... Errors - false positives & revisits
[S.FalsePos, ...
 S.CorRevisits, ...
 S.IncorRevisits, ...
 S.Revisits_total, ...
 S.Revisits_consec, ...
 S.Revisits_nonconsec]   = Selection_Revisits(marked);

if fb == 1
    FB = struct2table(S);
else
    NFB = struct2table(S);
end
end

 S = join(FB, NFB, 'Keys', {'ID', 'Group'});
 if i == 1
     SELECTION_SCORED = S;
 else
     SELECTION_SCORED = [SELECTION_SCORED; S];
 end
 
 clearvars -except i fDir ddir SELECTION_SCORED

end

outDir = [ddir filesep '..' filesep 'output'];
if ~isfolder(outDir)
    mkdir(outDir)
end
writetable(SELECTION_SCORED, [outDir filesep 'SELECTION_SCORED.csv']);

% (1) Demeyere, N., Haupt, M., Webb, S. S., Strobel, L., Milosevich, E., 
% Moore, M. J., . . . Duta, M. (2020). The Oxford Cognitive Screen–Plus 
% (OCS-Plus): a tablet based short cognitive screening tool for milder 
% cognitive impairment.
