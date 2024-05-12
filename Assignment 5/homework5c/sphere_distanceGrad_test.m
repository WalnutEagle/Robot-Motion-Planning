function sphere_distanceGrad_test
sphere=struct('xCenter',[0;0],'radius',5,'distInfluence',8);
subplot(1,2,1)
plot_case(sphere)
title('Filled-in')
sphere.radius=-5;
subplot(1,2,2)
plot_case(sphere)
title('Hollow')

function plot_case(sphere)
fHandle=@(x) sphere_distanceGrad(sphere,x);
sphere_plot(sphere,'k')
hold on
field_plotThreshold(fHandle);
hold off
