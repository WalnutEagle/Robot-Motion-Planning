%function [Jtheta]=twolink_jacobianMatrix(theta)
%Compute the matrix representation of the Jacobian of the position of the end
%effector with respect to the joint angles as derived in Question 
%q:jacobian-matrix.
function [Jtheta]=twolink_jacobianMatrix(theta)
hatUnitary=[0 -1;1 0];
Jtheta=[hatUnitary*rot2d(theta(1))*(rot2d(theta(2))*[5;0]+[5;0])...
    rot2d(theta(1))*hatUnitary*rot2d(theta(2))*[5;0]];

