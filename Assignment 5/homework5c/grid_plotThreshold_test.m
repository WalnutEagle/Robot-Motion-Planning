function grid_plotThreshold_test
load('sphereworld.mat')
potential=struct('shape','conic','xGoal',xGoal(:,1),'repulsiveWeight',10);
fHandle=@(xInput) potential_total(xInput,world,potential);
%cost
subplot(1,2,1)
sphereworld_plot(world,xGoal(:,1))
hold on
grid_plotThreshold(fHandle,20)
hold off
%gradient
fHandleGrad=@(xInput) potential_totalGrad(xInput,world,potential);
subplot(1,2,2)
sphereworld_plot(world,xGoal(:,1))
hold on
grid_plotThreshold(fHandleGrad,5)
hold off
