function potential_repulsiveSphereGrad_test()
load('sphereworld.mat','world')
sphere=world(2);
repulsiveField=@(xEval) potential_repulsiveSphereGrad(xEval,sphere);
grid_plotThreshold(repulsiveField,0.1)
hold on
sphere_plot(sphere,'k')
hold off
axis equal

