%function [U]=twolink_potential_total(thetaEval,world,potential)
%Compute the function $U=U_ attr+  @ @ _iU_ rep,i$, where $ $ is given by the
%variable  @x   potential.repulsiveWeight
function [UEvalTheta]=twolink_potential_total(thetaEval,world,potential)
UEvalTheta=potential_total(twolink_kinematicMap(thetaEval),world,potential);
