function [timeShapes1_2, timeShape1, timeShape2, timeMixed] = Trails_Time(data)
%... Completion time for the OCS+ Trails task
%... Input: data.trails field


if length(data.trails) == 9
    if isfield(data.trails{1, 3}.cont_lines, 'points')
        trailsS1        = data.trails{1, 3}.cont_lines.points;
        trailsS2        = data.trails{1, 6}.cont_lines.points;
        trailsM         = data.trails{1, 9}.cont_lines.points;
        
        timeS1_first    = trailsS1{1, 1};
        timeS1_last     = trailsS1{1, end};
        timeShape1      = timeS1_last(end, 3) - timeS1_first(1,3);
        
        timeS2_first    = trailsS2{1, 1};
        timeS2_last     = trailsS2{1, end};
        timeShape2      = timeS2_last(end, 3) - timeS2_first(1, 3);
        
        timeM_first     = trailsM{1, 1};
        timeM_last      = trailsM{1, end};
        timeMixed       = timeM_last(end, 3) - timeM_first(1, 3);
    else
        trailsS1        = data.trails{1, 3}.cont_lines;
        trailsS2        = data.trails{1, 6}.cont_lines;
        trailsM         = data.trails{1, 9}.cont_lines;
        
        timeS1_first    = trailsS1{1, 1};
        timeS1_last     = trailsS1{1, end};
        timeShape1      = timeS1_last(end, 3) - timeS1_first(1,3);
        
        timeS2_first    = trailsS2{1, 1};
        timeS2_last     = trailsS2{1, end};
        timeShape2      = timeS2_last(end, 3) - timeS2_first(1, 3);
        
        timeM_first     = trailsM{1, 1};
        timeM_last      = trailsM{1, end};
        timeMixed       = timeM_last(end, 3) - timeM_first(1, 3);
    end
    timeShapes1_2       = timeShape1 + timeShape2;
elseif length(data.trails) == 12
    timeShape1      = data.trails{1, 4}.task_duration;
    timeShape2      = data.trails{1, 8}.task_duration;
    timeShapes1_2   = timeShape1 + timeShape2;
    timeMixed       = data.trails{1, 12}.task_duration;
end


% if length(data.trails) == 9
%     if isfield(data.trails{1, 3}.cont_lines, 'points')
%         trailsS1        = data.trails{1, 3}.cont_lines.points;
%         trailsS2        = data.trails{1, 6}.cont_lines.points;
%         trailsM         = data.trails{1, 9}.cont_lines.points;
%         
%         timeS1_first    = trailsS1{1, 1};
%         timeS1_last     = trailsS1{1, end};
%         timeShape1      = timeS1_last(end, 3) - timeS1_first(1,3);
%         
%         timeS2_first    = trailsS2{1, 1};
%         timeS2_last     = trailsS2{1, end};
%         timeShape2      = timeS2_last(end, 3) - timeS2_first(1, 3);
%         
%         timeM_first     = trailsM{1, 1};
%         timeM_last      = trailsM{1, end};
%         timeMixed       = timeM_last(end, 3) - timeM_first(1, 3);
%     else
%         trailsS1        = data.trails{1, 3}.cont_lines;
%         trailsS2        = data.trails{1, 6}.cont_lines;
%         trailsM         = data.trails{1, 9}.cont_lines;
%         
%         timeS1_first    = trailsS1{1, 1};
%         timeS1_last     = trailsS1{1, end};
%         timeShape1      = timeS1_last(end, 3) - timeS1_first(1,3);
%         
%         timeS2_first    = trailsS2{1, 1};
%         timeS2_last     = trailsS2{1, end};
%         timeShape2      = timeS2_last(end, 3) - timeS2_first(1, 3);
%         
%         timeM_first     = trailsM{1, 1};
%         timeM_last      = trailsM{1, end};
%         timeMixed       = timeM_last(end, 3) - timeM_first(1, 3);
%     end
%        
% elseif length(data.trails) == 12
%     if isfield(data.trails{1, 4}.cont_lines, 'points')
%         trailsS1        = data.trails{1, 4}.cont_lines.points;
%         trailsS2        = data.trails{1, 8}.cont_lines.points;
%         trailsM         = data.trails{1, 12}.cont_lines.points;
%         
%         trailS1_first   = trailsS1{1, 1};
%         trailS1_last    = trailsS1{1, end};
%         timeShape1      = trailS1_last(end, 3) - trailS1_first(1, 3);
%         
%         trailS2_first   = trailsS2{1, 1};
%         trailS2_last    = trailsS2{1, end};
%         timeShape2      = trailS2_last(end, 3) - trailS2_first(1, 3);
%         
%         trailM_first    = trailsM{1, 1};
%         trailM_last     = trailsM{1, end};
%         timeMixed       = trailM_last(end, 3) - trailM_first(1, 3);
%     else
%         trailsS1        = data.trails{1, 4}.cont_lines;
%         trailsS2        = data.trails{1, 8}.cont_lines;
%         trailsM         = data.trails{1, 12}.cont_lines;
%         
%         trailS1_first   = trailsS1{1, 1};
%         trailS1_last    = trailsS1{1, end};
%         timeShape1      = trailS1_last(end, 3) - trailS1_first(1, 3);
%         
%         trailS2_first   = trailsS2{1, 1};
%         trailS2_last    = trailsS2{1, end};
%         timeShape2      = trailS2_last(end, 3) - trailS2_first(1, 3);
%         
%         trailM_first    = trailsM{1, 1};
%         trailM_last     = trailsM{1, end};
%         timeMixed       = trailM_last(end, 3) - trailM_first(1, 3);
%    end
%     
%end

% timeShapes1_2       = timeShape1 + timeShape2;
%timeTotal           = timeShapes1_2 + timeMixed;
end

