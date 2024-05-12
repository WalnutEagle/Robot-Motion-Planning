%function [flag]=prm_localPlannerIsCollision(world,x1,x2,maxDistEdgeCheck)
%Generates @boxIvory2 NPoints equispaced points on the line between @boxIvory2 x1
%and @boxIvory2 x2, such that the maximum distance between two consecutive
%samples is less than @boxIvory2 maxDistEdgeCheck. Note that the value of
%@boxIvory2 NPoints is determined by the distance between the two points and
%@boxIvory2 maxDistEdgeCheck.

%This function returns an ``all-or-nothing'' result, meaning that the edge
%between @boxIvory2 x1 and @boxIvory2 x2 even if only one of the samples is in
%collision.
function flag = prm_localPlannerIsCollision(world, xEdge1, xEdge2, maxDistEdgeCheck)
    % Calculate the number of points to sample
    dist = norm(xEdge2 - xEdge1);
    NPoints = ceil(dist / maxDistEdgeCheck);

    % Generate points along the line
    for i = 0:NPoints
        t = i / NPoints;
        point = (1 - t) * xEdge1 + t * xEdge2;

        % Check for collision at each point
        if sphereworld_isCollision(world, point)
            flag = true;
            return;
        end
    end

    % If no collision is detected
    flag = false;
end
