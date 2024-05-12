%Plot potential along a line in the configuration space
function potential_cost_test
shape='quadratic';
switch shape
    case 'conic'
        repulsiveWeight=0.01;
    case 'quadratic'
        repulsiveWeight=0.1;
end

problemData=load('sphereworld.mat');
%shorthand for variables
xGoal=problemData.xGoal(:,1);
world=problemData.world;
%setup potential struct (exept goal)
potential.shape = shape;
potential.world = problemData.world;
potential.repulsiveWeight = repulsiveWeight;
potential.xGoal=xGoal;

xParamt=@(t) (1-t)*[-1.5;0]+t*[1.65;0];
xParam=funEval(xParamt,linspace(0,1));

fEval=@(xEval) min(potential_total(xEval,world,potential),4);
UEval=funEvalVec(fEval,xParam);

fAttrEval=@(xEval) min(potential_attractive(xEval,potential),4);
UAttrEval=funEvalVec(fAttrEval,xParam);


figure(1)
subplot(1,2,1)
sphereworld_plot(world, xGoal);
hold on
plotPoints(xParam)
hold off
subplot(1,2,2)
plot(UEval)
hold on
plot(UAttrEval)
hold off
