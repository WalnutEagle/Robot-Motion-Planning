function clfcbf_control_fieldTest
load('sphereworld.mat')
potential=struct('shape','conic','xGoal',xGoal(:,1),'repulsiveWeight',10);
fHandleGrad=@(xInput) clfcbf_control(xInput,world,potential);
grid.xx=linspace(7,8,4);
grid.yy=linspace(-1,1,4);
sphereworld_plot(world,xGoal(:,1))
hold on
field_plotThreshold(fHandleGrad,5,grid)
hold off


