% function [graphVector, xSample] = sampleTree_extend(graphVector, radius, world)
%     % Compute degrees and sampling distribution
%     deg = graph_degree(graphVector);
%     fDistr = 1 ./ (deg + 1);
% 
%     % Sample a node
%     idxSample = rand_discrete(fDistr);
%     xNode = graphVector(idxSample).location;
% 
%     % Sample a location around the node
%     xSample = sphereworld_sample(world, 'distribution', 'Gaussian', 'size', radius, 'mean', xNode);
% 
%     % Find the nearest neighbor and attempt to connect
%     idxNear = graph_nearestNeighbors(graphVector, xSample, 1);
%     if ~prm_localPlannerIsCollision(world, graphVector(idxNear).location, xSample, radius)
%         % Update graphVector with new node
%         graphVector(end+1) = newNode(xSample, idxNear);
%     else
%         xSample = [];
%     end
% end

function [graphVector, xSample] = sampleTree_extend(graphVector, radius, world)

    % Compute degrees of nodes in graphVector
    deg = graph_degree(graphVector);
    
    % Compute an array for sampling probabilities
    numNodes = numel(deg);  % Using numel instead of length
    samplingProbabilities = zeros(numNodes, 1);
    for i = 1:numNodes
        samplingProbabilities(i) = 1 / (deg(i) + 1);
    end
    % Normalize the probabilities
    samplingProbabilities = samplingProbabilities / sum(samplingProbabilities);

    % Sample a node index based on the computed probabilities
    idxSample = rand_discrete(samplingProbabilities);
    xNode = graphVector(idxSample).location;

    % Sample a location using Gaussian distribution
    xSample = sphereworld_sample(world, 'distribution', 'Gaussian', 'size', radius, 'mean', xNode);

    % Find the nearest neighbor
    idxNear = graph_nearestNeighbors(graphVector, xSample, 1);

    % Check for collision
    if ~prm_localPlannerIsCollision(world, graphVector(idxNear).location, xSample, radius)
        % Add the new sample to graphVector
        graphVector(end+1) = newNode(xSample, idxNear);
    else
        % If there is a collision, return an empty sample
        xSample = [];
    end
end

