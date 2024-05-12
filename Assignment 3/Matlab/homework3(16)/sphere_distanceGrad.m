%function [gradDPointsSphere]=sphere_distanceGrad(sphere,points)
%Computes the gradient of the signed distance between points and the sphere,
%consistently with the definition of sphere_distance.
function [gradDPointsSphere]=sphere_distanceGrad(sphere,points)
    % Extract sphere properties
    xCenter = sphere.xCenter;
    radius = sphere.radius;
    
    % Ensure that points is a 2xNPoints array
    if size(points, 1) ~= 2
        error('points must be a 2xNPoints array.');
    end

    % Calculate the coordinates of the points relative to the sphere's center
    relativePoints = points - xCenter(:);

    % Calculate the distance from each point to the center of the sphere
    distances = sqrt(sum(relativePoints.^2, 1));

    % Initialize the gradient matrix with zeros
    gradDPointsSphere = zeros(2, size(points, 2));

    % Calculate the gradient based on whether the sphere is filled-in or hollow
    for ipoints = 1:size(points, 2)
        if distances(ipoints) > 0
            if radius > 0
                % Filled-in sphere
                gradDPointsSphere(:, ipoints) = relativePoints(:, ipoints) / distances(ipoints);
            else
                % Hollow sphere
                gradDPointsSphere(:, ipoints) = -relativePoints(:, ipoints) / distances(ipoints);
            end
        end
    end
end
