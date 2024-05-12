%function [xPath]=graph_search_startGoal(graphVector,xStart,xGoal)
%This function performs the following operations: enumerate  the two indexes  @x 
% idxStart,  @x   idxGoal in  @x   graphVector that are closest to  @x   xStart
%and  @x   xGoal (using graph_nearestNeighbors twice, see Question 
%q:graph-nearest).  graph_search to find a feasible sequence of points  @x  
%xPath from  @x   idxStart to  @x   idxGoal.   @x   xStart and  @x   xGoal,
%respectively, to the beginning and the end of the array  @x   xPath. enumerate
function [xPath]=graph_search_startGoal(graphVector,xStart,xGoal)
kCell=1;
    %Nearest Node
    idxStart=graph_nearestNeighbors(graphVector,xStart,kCell);
    idxGoal=graph_nearestNeighbors(graphVector,xGoal,kCell);
    [xPathIntermediate,~]=graph_search(graphVector,idxStart,idxGoal);
    xPath=[xStart,xPathIntermediate,xGoal];
end
