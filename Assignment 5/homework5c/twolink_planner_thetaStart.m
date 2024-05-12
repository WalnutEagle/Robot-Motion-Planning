function twolink_planner_thetaStart
load('sphereworld.mat')
figure(1)
sphereworld_plot(world,xGoal)
plotPoints(xStart,'bx')

thetaStart=[2.5 1.2]';
twolink_plot(thetaStart,'r')

