function twolink_planner_test_getStarts
flagSave=false;
shape='quadratic';
repulsiveWeight=0.01;
epsilon=5e-4;
thetaStart=[0.1;-0.1];


%load world data
problemData=load('sphereworld.mat');
%shorthand for variables
world=problemData.world;
xGoal=problemData.xStart; %we are trying to find the starting locations to insert in sphereworld.mat
thetaStart=zeros(size(xGoal));
%setup potential struct
potential.shape = shape;
potential.world = problemData.world;
potential.repulsiveWeight = repulsiveWeight;
%setup fHandles struct
fHandles.U=@twolink_potential_total;
fHandles.gradU=@twolink_potential_totalGrad;

for iGoal=1:size(xGoal,2)
    potential.xGoal = xGoal(:,iGoal);
    [xPath, UPath] = potential_planner([-0.1;0], world, potential, epsilon, fHandles);
    figure(iGoal)
    subplot(1,2,1)
    sphereworld_plot(world, xGoal(:,iGoal));
    hold on
    twolink_plot(xPath(:,1:20:end),'r')
    plotPoints(xGoal(:,iGoal),'gx')
    hold off
    subplot(1,2,2)
    hold on
    plot(1:size(UPath,2), UPath);
    hold off
    thetaStart(:,iGoal)=xPath(:,end);
    pause(0.1)
end
if flagSave
    disp('Appending thetaStart to sphereworld.mat')
    save('sphereworld.mat','thetaStart','-append')
else
    disp('Results not saved')
end

