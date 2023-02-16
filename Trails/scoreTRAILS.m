function [TRAILS_SCORES] = scoreTRAILS(files)

for i = 1 : height(files)
    
    clearvars -except files i TRAILS_SCORES valid tasks
    data_proc = NaN; %safety
    
    [Trails.ID, ...
    Trails.Visit, ...
    Trails.Group]                = visit_group(files.ID{i});
    Trails.Untersuchungsdatum    = files.date(i);

    load(files.path{i});

    Trails.NTrails	= true;

    % Accuracy
    [Trails.STrailAAcc,          ...
        Trails.STrailsCircleAcc, ...
        Trails.STrailsSquareAcc, ...
        Trails.STrailsMixedAcc]     = Trails_Accuracy(data, data_proc);
    
    % Time
    [Trails.STrailATime, ...
        Trails.STrailsCircleTime, ...
        Trails.STrailsSquareTime, ...
        Trails.STrailsMixedTime]    = Trails_Time(data);

        
    if Trails.STrailsMixedAcc + Trails.STrailsCircleAcc + Trails.STrailsSquareAcc == 0
        [Trails.SExecScoreAcc, ...
        Trails.SExecScoreAcc_capped]    = deal(0);
    else
        [Trails.SExecScoreAcc, ...
         Trails.SExecScoreAcc_capped]   = deal(round((Trails.STrailsMixedAcc / Trails.STrailAAcc) * 100, 2 ));
    end
    
    Trails.SProcessingSpeed         = round( Trails.STrailATime / (Trails.STrailAAcc / 14), 2 );
    
    [Trails.SExecScoreTime, ...
     Trails.SExecScoreTime_capped]  = deal(round((Trails.STrailsMixedTime / Trails.STrailATime) * 100, 2 ));
    
    if i == 1
        TRAILS_SCORES = struct2table(Trails);
    else
        TRAILS_SCORES = [TRAILS_SCORES; struct2table(Trails)];
    end
    
end
TRAILS_SCORES.SProcessingSpeed(isinf(TRAILS_SCORES.SProcessingSpeed)) = NaN;
TRAILS_SCORES.SExecScoreAcc_capped(TRAILS_SCORES.SExecScoreAcc_capped > 100) = 100;
TRAILS_SCORES.SExecScoreTime_capped(TRAILS_SCORES.SExecScoreTime_capped > 100) = 100;
end