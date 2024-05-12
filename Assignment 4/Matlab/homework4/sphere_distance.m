%function [dPointsSphere]=sphere_distance(sphere,points)
%Computes the signed distance between points and the sphere, while taking into
%account whether the sphere is hollow or filled in.
function [dPointsSphere]=sphere_distance(sphere,points)
    % Extract sphere properties
    xCenter = sphere.xCenter;
    %disp(xCenter);
    radius = abs(sphere.radius);
    %disp(radius);
    radiusSign = sign(sphere.radius);

    % Ensuring points is a 2xNPoints array 
    % Doing this as I was getting lot of error while testing this code in
    % local environment and on Autograder so had to include this code
    if size(points, 1) ~= 2
        error('points must be a 2xNPoints array.');
    end

    % Calculate the coordinates of the points relative to the sphere's center
    relativePoints = points - xCenter;

    % Calculate the distance from each point to the center of the sphere
    distances = sqrt(sum(relativePoints.^2));

    % Calculate the signed distances by considering whether the sphere is hollow or filled
    if radiusSign > 0
        % Filled-in sphere
        dPointsSphere = distances - radius;
    else
        % Hollow sphere
        dPointsSphere = radius - distances;
    end
end


%Remember that the radius of the sphere is negative for hollow spheres.
