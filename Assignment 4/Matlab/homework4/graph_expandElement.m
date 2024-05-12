%function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
%This function expands the vertex with index  @x   idxX (which is a neighbor of
%the one with index  @x   idxNBest) and returns the updated versions of  @x  
%graphVector and  @x   pqOpen.
function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
    node_b = graphVector(idxNBest);
    %Need a Flag 
    [flag]=priority_isMember(pqOpen,idxX);
    G_new = node_b.g+graph_heuristic(graphVector,idxNBest,idxX);

    %Implement the flag
    if flag==0
        graphVector(idxX).g=G_new;
        graphVector(idxX).backpointer = idxNBest;
        cost = G_new+graph_heuristic(graphVector,idxX,idxGoal);
        pqOpen = priority_insert(pqOpen,idxX,cost);

    elseif node_b.g + graph_heuristic(graphVector,idxNBest,idxX)<graphVector(idxX).g
        graphVector(idxX).g = node_b.g+graph_heuristic(graphVector,idxNBest,idxX);
        graphVector(idxX).backpointer = idxNBest;
        %Local run succesfull lets try on the autograder
    
    end


end