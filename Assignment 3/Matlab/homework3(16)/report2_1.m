%This code for the visulization for Report 2.1
% sphere = world;
% potential.repulsiveWeight = 0.1;
% potential.epsilon = 1e-2;
% potential.shape = 'conic';
% xEval = [7.25; 0];
% fHandle = @potential_totalGrad;
% result = fHandle(xEval,world,potential);
% figure;
% grid_plotThreshold(fHandle,10);
% sphere_plot(sphere, 'b');
xEval = [7.25;0];
fHandle = @clfcbf_control;
potential.epsilon = 1e-2;
potential.shape = 'conic';
potential.xGoal = xGoal;
potential.repulsiveWeight = 0.1;
result = fHandle(xEval,world,potential);
figure;
grid_plotThreshold(fHandle,10);
sphere_plot(world, 'b');