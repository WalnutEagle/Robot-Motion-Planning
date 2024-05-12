potential = struct('shape','conic','xGoal',[1.65;0],'repulsiveWeight',1);

figure
title('Plot of Potential Using Conic Shape')
sphereworld_plot(world,xGoal)
fhandle_potential = @(xEval)potential_total(xEval,world,potential);
field_plotThreshold(fhandle_potential)
xlim([-2 2])
ylim([-2 2])

figure
title('Plot of Potential Gradient Conic Shape')
sphereworld_plot(world,xGoal)
fhandle_potential = @(xEval)potential_totalGrad(xEval,world,potential);
field_plotThreshold(fhandle_potential)
xlim([-2 2])
ylim([-2 2])


potential = struct('shape','quadratic','xGoal',[1.65;0],'repulsiveWeight',1);
figure
title('Plot of Potential Using Quadratic Shape')
sphereworld_plot(world,xGoal)
fhandle_potential = @(xEval)potential_total(xEval,world,potential);
field_plotThreshold(fhandle_potential)
xlim([-2 2])
ylim([-2 2])


figure
title('Plot of Potential Gradient Using Quadratic Shape')
sphereworld_plot(world,xGoal)
fhandle_potential = @(xEval)potential_totalGrad(xEval,world,potential);
field_plotThreshold(fhandle_potential)
xlim([-2 2])
ylim([-2 2])