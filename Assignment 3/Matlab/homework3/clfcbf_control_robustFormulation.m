%function [uOpt]=clfcbf_control(xEval,world,potential)
%Compute $u^*$ according to    @  (  eq:clfcbf-qp \@@italiccorr ), where $m$ is
%given by the variable @boxIvory2 potential.repulsiveWeight
function [uOpt]=clfcbf_control(xEval,world,potential)

AAttr=potential_attractiveGrad(xEval,potential)';
bAttr=potential_attractive(xEval,potential);
nbObstacles=numel(world);
ARep=NaN(nbObstacles,2);
bRep=NaN(nbObstacles,1);
for iObstacle=1:nbObstacles
    ARep(iObstacle,:)=-sphere_distanceGrad(world(iObstacle),xEval);
    bRep(iObstacle,:)=-sphere_distance(world(iObstacle),xEval);
end
uOpt=qp_minEffortFix(AAttr,bAttr,ARep,bRep,potential.repulsiveWeight);
