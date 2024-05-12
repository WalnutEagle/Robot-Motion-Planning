function [xPath, graphVector] = sampleTree_search(world, xStart, xEnd, goalDistThreshold)
    % Initialize graphVector with start node
    graphVector = newNode(xStart, 0);
    
    for i = 1:1000  % NTrials
        [graphVector, xSample] = sampleTree_extend(graphVector, goalDistThreshold, world);
        if isempty(xSample)
            continue;
        end
        
        % Check if new sample is close to the goal
        if norm(xSample - xEnd) < goalDistThreshold
            % Attempt to connect to goal
            if ~prm_localPlannerIsCollision(world, xSample, xEnd, goalDistThreshold)
                graphVector(end+1) = newNode(xEnd, find(graphVector == xSample));
                xPath = graph_path(graphVector, xStart, xEnd);
                return;
            end
        end
    end
    xPath = [];
end
