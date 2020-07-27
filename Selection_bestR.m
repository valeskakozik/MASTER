% - - CALCULATE BEST R(1) FOR OCS-PLUS SELECTION TASK(2)

% - - Valeska Kozik, 15.05.2020
% - - valeskakozik@gmail.com

function bestR = Selection_bestR(taps)

%... to set in relation to order of markings:
z = 1:length(taps);
z = z';

%... Linear regression of the x-coordinates
[X{1:length(taps),1}] = taps.y;
X = cell2mat(X);

[Y{1:length(taps),1}] = taps.x;
Y = cell2mat(Y);


%... R & best r 
rX = corrcoef(z,X);
rY = corrcoef(z,Y);

R = [abs(rX(2)), abs(rY(2))];
bestR = max(R);

% (1) Mark, V. W., Woods, A., Ball, K., Roth, D. L., & Mennemeier, M. (2004). 
% Disorganized search on cancellation is not a consequence of neglect. 
% Neurology, 63(1), 78-84. 
% (2) Demeyere, N., Haupt, M., Webb, S. S., Strobel, L., Milosevich, E., 
% Moore, M. J., . . . Duta, M. (2020). The Oxford Cognitive Screen–Plus 
% (OCS-Plus): a tablet based short cognitive screening tool for milder 
% cognitive impairment.
