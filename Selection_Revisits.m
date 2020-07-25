% - - REVISITS ON THE OCS-PLUS SELECTION TASK(1)

% - - Valeska Kozik, 15.05.2020
% - - valeskakozik@gmail.com

function [falsepositives, correct_revisits, falsepos_revisits, ...
    total_revisits, consecutive_revisits, ...
    nonconsecutive_revisits] = Selection_Revisits(marked)

%... Input field: data_fb.marked.obj_inds/ data_nfb.marked.obj_inds   
    v                       = 1:length(marked) - 1;
    targets                 = marked(marked < 31);
    distractors             = marked(marked > 30);

    %... correct revisits
    alltargets              = targets == targets';
    uniquetargets           = unique(targets == targets', 'rows');
    cAll                    = size(alltargets);
    cUn                     = size(uniquetargets);
    correct_revisits        = cAll(1) - cUn(1);
    
    %... false postives & false positive revisits
    alldistractors          = distractors == distractors';
    uniquedistractors       = unique(distractors == distractors', 'rows');
    fpAll                   = size(alldistractors);
    fpUn                    = size(uniquedistractors);
    falsepositives          = fpUn(1);
    falsepos_revisits       = fpAll(1) - fpUn(1);
    
    %... total revisits
    total_revisits          = correct_revisits + falsepos_revisits;
    
    %... consecutivae & nonconsecutive revisits
    consecutive_revisits    = sum(marked(v) == marked(v + 1));
    nonconsecutive_revisits = total_revisits - consecutive_revisits;
end

% (1) Demeyere, N., Haupt, M., Webb, S. S., Strobel, L., Milosevich, E., 
% Moore, M. J., . . . Duta, M. (2020). The Oxford Cognitive Screen–Plus 
% (OCS-Plus): a tablet based short cognitive screening tool for milder 
% cognitive impairment. 