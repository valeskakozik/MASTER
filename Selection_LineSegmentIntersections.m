% - - INTERSECTIONS(1) ON THE OCS-PLUS SELECTION TASK(2)

% - - Valeska Kozik, 15.05.2020
% - - valeskakozik@gmail.com

function [intersections_b, intersections_b_adj] = Selection_LineSegmentIntersections(taps, marked)
%... Count the number of line segment intersections in OCS-Plus Selection
%... task.
%... <<intersections_b>> gives the sum of all lines, which have intersected
%... with any number of previously drawn lines.
%... The variable can be looked at adjusted to sequentially different
%... makings (*_adj).

%... Input: structure, which contains all x and y coordinates, such as
%... data_fb.taps or data_nfb.taps (SELECTION task).

%... If you want to visualise the participants search path and their
%... intersections, uncomment every section that is headed with 
%... "if wanted -- visualisation"

%... if wanted -- visualisation
% close all
% set(gcf,'units','points','position',[10,10,600,700]);
% xlim([0 1366]);
% ylim([0 768]);
% axis off;
% camroll(270);
% hold on

intersections       = 0;                        %counter variable, set to 0
intersections_bin   = false(length(taps), 1);   %set up binary representation of ...
                                                %wether a previous line has been intersected
for n = length(taps):-1:1
    if n > 1
        
    iBin1 = intersections;
    iBin2 = intersections;
    
    [x1, x2] = deal(taps(n).y, taps(n-1).y);
    [y1, y2] = deal(taps(n).x, taps(n-1).x);
  
    %... if wanted -- visualisation:
%     if n == 2
%         plot(x2, y2, 'o','MarkerfaceColor', '#77AC30', 'MarkerEdgeColor', '#77AC30', 'MarkerSize', 9);
%         plot([x1 x2], [y1 y2], 'k-o')
%     elseif n == length(taps)
%         plot(x1, y1, 'o', 'MarkerfaceColor', '#D95319', 'MarkerEdgeColor', '#D95319', 'MarkerSize', 9);
%     else
%         plot([x1 x2], [y1 y2], 'k-o');
%     end

    end
    for m = n-1:-1:1
        if m > 1
        
            %... calculate point of intersection between the two _lines_
            [x3, x4] = deal(taps(m).y, taps(m+1).y);
            [y3, y4] = deal(taps(m).x, taps(m+1).x);
            
            %...Create line vectors
            AB = [(x1 - x2), (y1 - y2), 0];
            CD = [(x3 - x4), (y3 - y4), 0];
            
            %... if wanted -- visualisation:
%             plot([x3 x4], [y3 y4], 'k-o');
            
            t1  = ( ((x1-x3) * (y3-y4)) - ((y1-y3) * (x3-x4)) );
            t2  = ( ((x1-x2) * (y3-y4)) - ((y1-y2) * (x3-x4)) );
            t   = t1 / t2;
            
            if t2 ~= 0
            %... Point of _line_ intersection
            Px = x1 + t * (x2 - x1);
            Py = y1 + t * (y2 - y1);
            AP = [(x1 - Px), (y1 - Py), 0];
            CP = [(x3 - Px), (y3 - Py), 0];
            
            %... at this point, we have all intersections of the lines in
            %... question, however we want the line _segments_, not infinite
            %... _lines_!
            %... Check whether the point of intersection lies between the two
            %... endpoints of the first line segment:
        
               dAP = dot(AB, AP); 
               dAB = dot(AB, AB);
               dCP = dot(CD, CP);
               dCD = dot(CD, CD);
                if dAP > 0 && dAP < dAB && dCP > 0 && dCP < dCD
                   intersections = intersections + 1;
                   
                   %... if wanted -- visualisation:
%                    plot(Px, Py, 'ro', 'MarkerSize', 13);
                end

            end
        end
    end
    
    iBin2 = intersections;
    if iBin2 > iBin1
        intersections_bin(n) = true;
    end
end

v                   = 1:length(marked)-1;
temp_seq_diff       = sum((marked(v) ~= marked(v+1))) + 1; %+1 because the first is always different from 0
intersections_b     = sum(intersections_bin);
intersections_b_adj = intersections_b / temp_seq_diff; %* 100;

% (1) Mark, V. W., Woods, A., Ball, K., Roth, D. L., & Mennemeier, M. (2004). 
% Disorganized search on cancellation is not a consequence of neglect. 
% Neurology, 63(1), 78-84. 
% (2) Demeyere, N., Haupt, M., Webb, S. S., Strobel, L., Milosevich, E., 
% Moore, M. J., . . . Duta, M. (2020). The Oxford Cognitive Screen–Plus 
% (OCS-Plus): a tablet based short cognitive screening tool for milder 
% cognitive impairment.