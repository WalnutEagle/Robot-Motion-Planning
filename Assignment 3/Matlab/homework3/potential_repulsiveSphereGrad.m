%function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)
%Compute the gradient of $U_ rep$ for a single sphere, as given by    @  ( 
%eq:repulsive-gradient \@@italiccorr ).
function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)

dPointSphere = sphere_distance(sphere,xEval); %get distance and point on sphere
d_influence = sphere.distInfluence; % get d_influence

flagInfluence=dPointSphere > 0 & dPointSphere < d_influence;
flagInside = dPointSphere <=0;
if flagInfluence %if point is in region of influence calculate U
    gradURep = -(1/dPointSphere-1/d_influence)*(1/dPointSphere^2)*sphere_distanceGrad(sphere,xEval);
elseif flagInside
    gradURep=NaN(2,1);
else
    gradURep = [0;0];
end

%This function must use the outputs of sphere_distanceSphere.
