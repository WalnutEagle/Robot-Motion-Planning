function [flag] = prm_localPlannerIsCollision(world, xEdge1, xEdge2, maxDistEdgeCheck)
    % Generate NPoints equispaced points on the line
    NPoints = ceil(norm(xEdge2 - xEdge1) / maxDistEdgeCheck);
    lineSamples = linspace(xEdge1, xEdge2, NPoints);
    
    % Check for collision at each point
    flag = false;
    for i = 1:NPoints
        if sphereworld_isCollision(world, lineSamples(:,i))
            flag = true;
            break;
        end
    end
end
