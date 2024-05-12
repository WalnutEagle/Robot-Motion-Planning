function twolink_jacobianMatrix_test
theta=randn(2,1);
thetaDot=randn(2,1);

disp([twolink_jacobian(theta,thetaDot) twolink_jacobianMatrix(theta)*thetaDot])

