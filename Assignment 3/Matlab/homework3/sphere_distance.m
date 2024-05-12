%function [dPointsSphere]=sphere_distance(sphere,points)
%Computes the distance between points and the sphere, as well as the point on the
%sphere that realizes that distance, while taking into account if it is hollow or
%filled in.
function [dPointsSphere]=sphere_distance(sphere,points)

[~,num_points] = size(points); % find length of points matrix
dPointsSphere = zeros(1,num_points); % intialize dpointsSphere
%pointsSphere = zeros(2,num_points); %initialize pointsSphere

for iPoints = 1:num_points % for each point, find distance and point on sphere
    center_2_point = points(:,iPoints)-sphere.xCenter; % find center to point vector
    mag_center_2_point = sqrt(center_2_point(1)^2+center_2_point(2)^2); % find magnitude of the center to point vector
%    unit_center_point = center_2_point/mag_center_2_point; % find the unit vector pointing from circle center to point
%    nearest_circle_point = sphere.xCenter+abs(sphere.radius)*(unit_center_point); % find the point on the circle nearest to point
    if sphere.radius < 0 % if radius is negative, make magnitude center to point negative so that sphere to point will be positive if point is inside sphere
        mag_center_2_point = mag_center_2_point * -1;
    end
    mag_sphere_2_point = mag_center_2_point-sphere.radius;% find distance from sphere to point, positive if out of obstacle, negative if inside obstacle 
    dPointsSphere(iPoints) = mag_sphere_2_point;
%    pointsSphere(:,iPoints) = nearest_circle_point;
end
