%function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)
%Implements the  @x   A* algorithm, as described by the pseudo-code in Algorithm 
%alg:astar.
function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)
    idx = zeros(0,1);
    pqOpen = priority_prepare();
    graphVector(idxStart).g=graph_heuristic(graphVector,idxStart,idxGoal);
    graphVector(idxStart).backpointer=[];
    cost=graphVector(idxStart).g;
    pqOpen=priority_insert(pqOpen,idxStart,cost);

    % implement the same while loop 
    while ~isempty(pqOpen)
        [pqOpen,idxNBest,~]=priority_minExtract(pqOpen);
        idx(end+1,1)=idxNBest;
        if idxNBest==idxGoal
            break;
        end
        [idxExpand]=graph_getExpandList(graphVector,idxNBest,idx);
        % errors in local running for the size need to change that
        for idxX=1:numel(idxExpand)
            [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxExpand(idxX),idxGoal,pqOpen);
        end
        [xPath]=graph_path(graphVector,idxStart,idxGoal);
    end
% Set a maximum limit of iterations in the main  @x   A* loop on line 
%it:astar-main-loop of Algorithm  alg:astar. This will prevent the algorithm from
%remaining stuck on malformed graphs (e.g., graphs containing a node as a
%neighbor of itself), or if you make some mistake during development.
