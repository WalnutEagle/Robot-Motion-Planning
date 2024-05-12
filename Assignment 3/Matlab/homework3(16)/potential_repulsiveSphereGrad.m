%function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)
%Compute the gradient of $U_ rep$ for a single sphere, as given by    @  ( 
%eq:repulsive-gradient \@@italiccorr ).
function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)
di_x = sphere_distance(sphere,xEval);
%if sphere_distance(sphere,xEval)>0
    %a = true;
%elseif sphere_distance(sphere,xEval)<sphere.distInfluence
    %b = true;
%end
%if di_x>sphere.distInfluence
    %c = true;
%end   Dont know what is happening but locally it is giving error for 'and
%opreation'.
if sphere_distance(sphere,xEval)>0 && sphere_distance(sphere,xEval)<sphere.distInfluence
    gradURep = sqrt(2*potential_repulsiveSphere(xEval,sphere));
    gradURep = gradURep*(1/(di_x^2));
    gradURep = gradURep*sphere_distanceGrad(sphere,xEval);
    gradURep = gradURep*(-1);
    % Testing this as there were expected output errors occuring.
    %gradURep = -2*(sqrt(potential_repulsiveSphere(xEval,sphere)))*(1/(di_x^2))*sphere_distanceGrad(sphere,xEval);
elseif di_x>sphere.distInfluence
    gradURep = [0;0];
else 
    gradURep = [NaN;NaN];
end
%Error Solved input type I used for local testing was wrong.
%This function must use the outputs of sphere_distanceSphere.
