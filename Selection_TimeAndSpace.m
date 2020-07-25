% - - SCORE LATENCY, DISTANCE, AND SEARCH SPEED INDICES(1) ON THE 
% - - OCS-PLUS SELECTION TASK(2)

% - - Valeska Kozik, 15.05.2020
% - - valeskakozik@gmail.com

function [LatencyIndex, DistanceIndex, SearchSpeedIndex] = Selection_TimeAndSpace(taps)
[time{1:length(taps), 1}]  = taps.time;
[x{1:length(taps), 1}]     = taps.y;
[y{1:length(taps), 1}]     = taps.x;

%... Latency
Latency         = zeros(length(taps) - 1, 1);
    
for i = 1:length(taps)-1
    t1          = time{i};
    t2          = time{i+1};
    diff        = t2 - t1;
    Latency(i)  = diff;
end

%... Distance
Distance = zeros(length(x) - 1, 2);

for i = 2:length(x) 
    Distance(i-1, :) = abs([x{i} y{i}] - [x{i-1} y{i-1}]);
end

Distance    = sum(Distance, 2) / 2;
noInf       = ~isinf(Distance);
Distance    = Distance(noInf);
noNaN       = ~isnan(Distance);
Distance    = Distance(noNaN);
    
%... Search Speed
SearchSpeed = Latency ./ Distance;
noInf       = ~isinf(SearchSpeed);
SearchSpeed = SearchSpeed(noInf);
noNaN       = ~isnan(SearchSpeed);
SearchSpeed = SearchSpeed(noNaN);

%... LIndex, DIndex, SIndex
LatencyIndex        = median(Latency);
DistanceIndex       = median(Distance);
SearchSpeedIndex    = median(SearchSpeed);
end

% (1) Rabuffetti et al.(2012). Spatio-Temporal
% Features of Visual Exploration in Unilaterally Brain-Damaged Subjects with
% or without Neglect: Results from a Touchscreen Test. PLoS ONE, 7(2),
% e31511. doi:10.1371/journal.pone.0031511
% (2) Demeyere, N., Haupt, M., Webb, S. S., Strobel, L., Milosevich, E., 
% Moore, M. J., . . . Duta, M. (2020). The Oxford Cognitive Screen–Plus 
% (OCS-Plus): a tablet based short cognitive screening tool for milder 
% cognitive impairment.