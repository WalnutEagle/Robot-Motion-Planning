%function sphere_plot(sphere,color)
%This function draws the sphere (i.e., a circle) with radius  sphere.r and the
%specified color, and another circle with radius  sphere.rInfluence in gray.
function varargout = sphere_plot(spheres, color)
    if isempty(spheres)
        plotHandle1 = [];
        plotHandle2 = [];
    else
        % Initialize arrays to store plot handles
        plotHandle1 = gobjects(size(spheres));
        plotHandle2 = gobjects(size(spheres));
        
        for i = 1:numel(spheres)
            % Extract the current sphere struct
            sphere = spheres(i);

            % Geometrical radius
            radius = abs(sphere.radius);

            % Filled-in or hollow
            radiusSign = sign(sphere.radius);
            if radiusSign > 0
                faceColor = [0.8 0.8 0.8];
            else
                faceColor = [1 1 1];
            end

            % Geometry radius of influence
            radiusInfluence = radius + radiusSign * sphere.distInfluence;

            % Plotting of the sphere and sphere of influence
            plotHandle1(i) = plotCircle(sphere.xCenter(1), sphere.xCenter(2), radius, 'EdgeColor', color, 'FaceColor', faceColor);
            plotHandle2(i) = plotCircle(sphere.xCenter(1), sphere.xCenter(2), radiusInfluence, 'EdgeColor', [0.5 0.5 0.5]);
        end
    end

    if nargout > 0
        varargout{1} = [plotHandle1; plotHandle2];
    end
end

function plotHandle = plotCircle(xCenter, yCenter, radius, varargin)
    diameter = radius * 2;
    xCorner = xCenter - radius;
    yCorner = yCenter - radius;
    plotHandle = rectangle('Position', [xCorner, yCorner, diameter, diameter], 'Curvature', [1, 1], varargin{:});
end

