function [accuracyShapes1_2, accS1, accS2, accuracyMixed] = Trails_Accuracy(data, data_proc)
%...Accuracy for the OCS+ Trails task performance
%...Input: data AND data_proc! --> the different version have the relevant information
%...stored differently!
format long


if length(data.trails) == 9
     
    accS1               = data_proc.scores.shape1.consecutive_score;
    accS2               = data_proc.scores.shape2.consecutive_score;
    accuracyShapes1_2   = (accS1 + accS2);% / 14 * 100;
    accuracyMixed       = data_proc.scores.mixed.consecutive_score;% / 14 * 100;
    
    
elseif length(data.trails) == 12    
    
    accS1               = data.trails{1, 4}.scores.ideal;
    accS2               = data.trails{1, 8}.scores.ideal;
    accuracyShapes1_2   = (accS1 + accS2);% / 14 * 100;
    accuracyMixed       = data.trails{1, 12}.scores.ideal;% / 14 * 100;
    
end
end

