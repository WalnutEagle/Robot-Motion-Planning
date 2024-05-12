%function [xPath,graphVector]=sampleTree_search(world,xStart,xEnd,goalDistThreshold)
%Implement a tree-based sampling search algorithm. The function performs the
%following steps: enumerate  a @boxIvory2 graphVector containing only a vertex at
%@boxIvory2 xStart. it:extend Call sampleTree_extend to grow the tree with a new
%sample with location @boxIvory2 xSample.  the distance between @boxIvory2
%xSample and @boxIvory2 xEnd is less then @boxIvory2 goalDistThreshold, call
%prm_localPlannerIsCollision to try to connect the goal to the tree: enumerate 
%the connection does  not succeed, repeat from step  it:extend, up to @boxIvory2
%NTrials=1000 times.  the connection succeeds, add @boxIvory2 xEnd to @boxIvory2
%graphVector (with the correct backpointer), and then use graph_path to return
%the path from @boxIvory2 xStart to @boxIvory2 xEnd. enumerate enumerate
function [xPath, graphVector] = sampleTree_search(world, xStart, xEnd, goalDistThreshold, radius)
    NTrials = 1000;
    xPath = [];
    graphVector = struct('position', xStart, 'backpointer', 0);
    
    for i = 1:NTrials
        [graphVector, xSample] = sampleTree_extend(graphVector, radius, world);
        if isempty(xSample)
            continue;
        end
        
        if norm(xSample - xEnd) < goalDistThreshold
            if ~prm_localPlannerIsCollision(world, xSample, xEnd, radius)
                newNode.position = xEnd;
                newNode.backpointer = length(graphVector);
                graphVector = [graphVector; newNode];
                xPath = graph_path(graphVector, length(graphVector));
                return;
            end
        end
    end
end


