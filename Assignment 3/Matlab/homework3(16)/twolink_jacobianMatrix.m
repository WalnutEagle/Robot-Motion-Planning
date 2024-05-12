%function [Jtheta]=twolink_jacobianMatrix(theta)
%Compute the matrix representation of the Jacobian of the position of the end
%effector with respect to the joint angles as derived in Question 
%q:jacobian-matrix.
function [Jtheta]=twolink_jacobianMatrix(theta)
position1 = 5;

%using the formula i calculated now not using the formula from the last
%assignment.  
J11 = -position1 * sin(theta(1,1)) - position1 * sin(theta(1,1) + theta(2,1));
J12 = -position1 * sin(theta(1,1) + theta(2,1)); 
J21 = position1 * cos(theta(1,1)) + position1 * cos(theta(1,1) + theta(2,1));
J22 = position1 * cos(theta(1,1) + theta(2,1));
Jtheta = [J11 J12;J21 J22];
end