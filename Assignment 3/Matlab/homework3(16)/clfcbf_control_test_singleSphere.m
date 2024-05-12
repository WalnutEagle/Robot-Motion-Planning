function clfcbf_control_test_singleSphere
xGoal=[0;-6];
world=struct('xCenter',[0;-2],'radius',2,'distInfluence',1);
potential=struct('shape','conic','xGoal',xGoal,'repulsiveWeight',10);
fHandleGrad=@(xInput) clfcbf_control(xInput,world,potential);
grid.xx=linspace(-10,10,23);
grid.yy=linspace(-10,10,23);
sphereworld_plot(world,xGoal)
hold on
grid_plotThreshold(fHandleGrad,5,grid)
hold off
