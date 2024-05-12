%function [hVal]=graph_heuristic(graphVector,idxX,idxGoal)
%Computes the heuristic  @x   h given by the Euclidean distance between the nodes
%with indexes  @x   idxX and  @x   idxGoal.
function [hVal]=graph_heuristic(graphVector,idxX,idxGoal)
% Test 1 on local then on autograder    
% Extract the co-ordinates for the nodes with indexes idxX and idxGoal
% F need to extract x and y coordinates according to autograder LOL

    nodeX = graphVector(idxX);
    nodeGoal = graphVector(idxGoal);

    xcdx = nodeX.x(1);
    ycdx = nodeX.x(2);
    % Do same for the goal
    xgdx = nodeGoal.x(1);
    ygdx = nodeGoal.x(2);

% Compute the Euclidean distance between the two nodes
    hVal = sqrt((xcdx-xgdx).^2 + (ycdx-ygdx).^2);
end
