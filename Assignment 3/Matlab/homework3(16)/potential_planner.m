%function [xPath,UPath]=potential_planner(xStart,world,potential,plannerParameters)
%This function uses a given control field (@boxIvory2 plannerParameters.control)
%to implement a generic potential-based planner with step size @boxIvory2
%plannerParameters.epsilon, and evaluates the cost along the returned path. The
%planner must stop when either the number of steps given by @boxIvory2
%plannerParameters.NSteps is reached, or when the norm of the vector given by
%@boxIvory2 plannerParameters.control is less than $10^-3$ (equivalently,
%@boxIvory2 1e-3).
function [xPath,UPath]=potential_planner(xStart,world,potential,plannerParameters)
%Below this all is for report till the last comment
total_steps = 400;
plannerParameters.epsilon = 1e-2;
potential.shape = 'quadratic';
% Upto this all is for report and all other images
% total_steps = plannerParameters.NSteps;
step_size = plannerParameters.epsilon;
xPath = NaN(2,total_steps);
UPath = NaN(1,total_steps);
xPath(:,1) = xStart;
UPath(:,1) = plannerParameters.U(xStart,world,potential);
% Now implementing the condition/description of this function
steps = 1;
while steps<total_steps
    controlCurrent = plannerParameters.control(xPath(:,steps),world,potential);
    step = min(step_size,step_size/norm(controlCurrent));
    xPath(:,steps+1) = xPath(:,steps)+step*controlCurrent;
    UPath(:,steps+1) = plannerParameters.U(xPath(:,steps+1),world,potential);
    %Also checking if the controlcurrent norm goes less than 5e-3
    if norm(controlCurrent)<5e-3
        break;
    end
    steps = steps+1;
end