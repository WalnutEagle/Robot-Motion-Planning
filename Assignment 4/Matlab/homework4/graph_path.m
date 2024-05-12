%function [xPath]=graph_path(graphVector,idxStart,idxGoal)
%This function follows the backpointers from the node with index  @x   idxGoal in
% @x   graphVector to the one with index  @x   idxStart node, and returns the 
%coordinates (not indexes) of the sequence of traversed elements.
function [xPath]=graph_path(graphVector,idxStart,idxGoal)
    latest_Idx = idxGoal;
    xPath = graphVector(latest_Idx).x;
    while latest_Idx~=idxStart
        % basically if the while statement is applicable
        latest_Idx = graphVector(latest_Idx).backpointer;
        %This will take teh backpointer to the at present node
        xPath = [graphVector(latest_Idx).x,xPath];
    end
    %Locally running there comes error for output is not 2xN
    %making sure that happens
    xPath = reshape(xPath,2,[]);
end
