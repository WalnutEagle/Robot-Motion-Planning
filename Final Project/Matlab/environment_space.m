% This is the code for a simple environment
% I will first try to run Q-Learning for a static Environment

% Envirnoment Space
gridSize = 10;
obstacle = randi([1 gridSize], 10, 2); 
agentPos = [1, 1]; 
goalPos = [gridSize, gridSize]; 

state = zeros(gridSize, gridSize);

for i = 1:size(obstacle, 1)
    state(obstacle(i,1), obstacle(i,2)) = 1;
end
state(agentPos(1), agentPos(2)) = 2;
state(goalPos(1), goalPos(2)) = 3;
