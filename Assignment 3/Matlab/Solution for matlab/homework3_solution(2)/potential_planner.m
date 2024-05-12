%function [xPath,UPath]=potential_planner(xStart,world,potential,plannerParameters)
%This function uses potential_totalGrad to implement the gradient-descent-based
%planner with step size  @x   epsilon, and evaluates the cost along the returned
%path. The planner must stop after  @x   NSteps=1000 steps
function [xPath,UPath]=potential_planner(xStart,world,potential,plannerParameters)

xPath = zeros(2,plannerParameters.NSteps); % initialize xPath
UPath = zeros(1,plannerParameters.NSteps); % initialize UPath
xPath(:,1) = xStart; % fill in first xPath value
UPath(1) = plannerParameters.U(xStart,world,potential); % fill in first UPath value

%if 1000 steps haven't been taken and the magnitude of gradient is > 10^-3,
%take a step
for iStep=1:plannerParameters.NSteps-1
    current_control = plannerParameters.control(xPath(:,iStep),world,potential);
    xPath(:,iStep+1) = xPath(:,iStep)+plannerParameters.epsilon*current_control;
    UPath(iStep+1) = plannerParameters.U(xPath(:,iStep+1),world,potential);
end

