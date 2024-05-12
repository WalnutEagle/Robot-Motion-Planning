
function sphere_testCollision(sphere)

    % Define sphere properties
    % Just for testing this data was used
    %sphere1.xCenter = [2; 3];    % Center of the sphere
    %sphere1.radius = 4;         % Geometric radius (positive for filled, negative for hollow)
    %sphere1.distInfluence = 1;  % Influence distance

    % Generate random points
    NPoints = 100;
    points = rand(2, NPoints) * 10; % Random points within a 10x10 region

    % Calculate signed distances for sphere1
    dPointsSphere = sphere_distance(sphere, points);

    % Create a figure for sphere1
    figure;
    scatter(points(1, :), points(2, :), 40, sign(dPointsSphere), 'filled');
    colormap([1 0 0; 0 1 0]); % Red for negative distances, green for positive distances
    title('Collision Check with Sphere (Positive r)');

    % Define sphere2 with the sign of the radius flipped
    sphere2 = sphere;
    sphere2.radius = -sphere2.radius;

    % Calculate signed distances for sphere2
    dPointsSphere2 = sphere_distance(sphere2, points);

    % Create a second figure for sphere2
    figure;
    scatter(points(1, :), points(2, :), 40, sign(dPointsSphere2), 'filled');
    colormap([1 0 0; 0 1 0]); % Red for negative distances, green for positive distances
    title('Collision Check with Sphere (Negative r)');

end
