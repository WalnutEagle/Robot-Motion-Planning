%function [uOpt]=clfcbf_control(xEval,world,potential)
%Compute $u^*$ according to (5)
function [uOpt]=clfcbf_control(xEval,world,potential)

uRef=-potential_attractiveGrad(xEval,potential);
nbObstacles=numel(world);
ARep=NaN(nbObstacles,2);
bRep=NaN(nbObstacles,1);
for iObstacle=1:nbObstacles
    ARep(iObstacle,:)=-sphere_distanceGrad(world(iObstacle),xEval);
    bRep(iObstacle,:)=-0.1*sphere_distance(world(iObstacle),xEval);
end
uOpt=qp_supervisor(ARep,bRep,uRef);
