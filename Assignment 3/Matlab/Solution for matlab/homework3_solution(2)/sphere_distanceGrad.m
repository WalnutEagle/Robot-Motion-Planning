%function [gradDPointsSphere]=sphere_distanceGrad(sphere,points)
%Computes the gradient of the signed distance between points and the sphere,
%consistently with the definition of sphere_distance.
function [gradDPointsSphere]=sphere_distanceGrad(sphere,points)
nbPoints=size(points,2);
%compute unnormalized gradient
pointsCenter=points-sphere.xCenter*ones(1,nbPoints);
%normalize gradient, handling the special case of points on the center
normPointsCenter=sqrt(sum(pointsCenter.^2,1));
flagCenter=normPointsCenter<1e-12;
gradDPointsSphere(:,~flagCenter)=pointsCenter(:,~flagCenter)./([1;1]*normPointsCenter(:,~flagCenter));
gradDPointsSphere(:,flagCenter)=zeros(2,sum(flagCenter));
%flip direction if sphere is hollow
if sphere.radius<0
    gradDPointsSphere=-gradDPointsSphere;
end