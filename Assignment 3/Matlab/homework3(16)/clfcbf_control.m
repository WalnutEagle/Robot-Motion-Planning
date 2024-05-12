%function [uOpt]=clfcbf_control(xEval,world,potential)
%Compute $u^*$ according to    @  (  eq:clfcbf-qp \@@italiccorr ), where $m$ is
%given by the variable @boxIvory2 potential.repulsiveWeight
function [uOpt]=clfcbf_control(xEval,world,potential)
Inum = size(world,2);
Uref = -(potential_attractiveGrad(xEval,potential));
% prealocation as the matlab suggests that the value keeps changing and the
% variable must be preassigned before
Abarrier = zeros(Inum,2);
Bbarrier = zeros(Inum,1);

for iCell = 1:Inum
    sphere = world(iCell);
    di_x = sphere_distance(sphere,xEval);
    del_di_x = sphere_distanceGrad(sphere,xEval);
    Abarrier(iCell,1) = del_di_x(1,1);
    Abarrier(iCell,2) = del_di_x(2,1);
    Bbarrier(iCell,1) = di_x(1,1);
    Bbarrier(iCell) = potential.repulsiveWeight*di_x;
end
% need to fix something in this as the qp_supervisor exits in the loop and
% gives the errors in the autograder.
uOpt = qp_supervisor(-Abarrier,-Bbarrier,Uref);
end
%This function should use qp_minEffortFix from Question~ q:minEffortFix, by
%building $A_ attr$, $b_ attr$ according to $ $ in    @  (  eq:CLF \@@italiccorr
%), $A_ barrier$, $b_ barrier$ according to $ $ in    @  (  eq:CBF \@@italiccorr
%).
