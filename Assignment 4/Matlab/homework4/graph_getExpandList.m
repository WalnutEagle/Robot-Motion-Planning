%function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)
%Finds the neighbors of element  @x   idxNBest that are not in  @x   idxClosed
%(line  it:expansion in Algorithm  alg:astar).
function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)
% Extract the neighbors of the current node
    neighbors = graphVector(idxNBest).neighbors;

% Find the neighbors that are not in the closed list
% setdiff simplifies the process and returns the required output that is
% the elements that are not in the idxClosed.
    idxExpand = setdiff(neighbors, idxClosed);
end

%Ensure that the vector  @x   idxBest is not included in the list of neighbors
%(i.e., avoid self-loop edges in the graph).
