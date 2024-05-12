actions = [0 -1; 0 1; -1 0; 1 0];
rewardObstacle = -100;
rewardGoal = 100;
rewardMove = -1;
gridSize = 10;
numObstacles = 20;

% Initialize grid
grid = zeros(gridSize);

% Place robot (1,1) and goal (10,10)
robotPos = [1 1];
goalPos = [10 10];
grid(robotPos(1), robotPos(2)) = -1; % Robot
grid(goalPos(1), goalPos(2)) = -2; % Goal

% Place obstacles
for i = 1:numObstacles
    obstaclePos = ceil(rand(1, 2) * gridSize);
    while isequal(obstaclePos, robotPos) || isequal(obstaclePos, goalPos)
        obstaclePos = ceil(rand(1, 2) * gridSize);
    end
    grid(obstaclePos(1), obstaclePos(2)) = 1;
end
% Q-learning parameters
alpha = 0.001; 
gamma = 0.9; 
epsilon = 0.1; 
qTable = zeros(gridSize, gridSize, 4);
% %% 

%% 

for episode = 1:10 
    grid = moveObstacles(grid, gridSize); 
    stepCount = 0;
    currentState = robotPos;
    isGoalReached = false;
    maxEpisodes = 10;
    maxSteps = 100;
    for episode = 1:maxEpisodes
        stepCount = 0;
        currentState = robotPos;
        isGoalReached = false;
        while ~isGoalReached && stepCount < maxSteps
            if rand < epsilon
                action = ceil(rand * 4);
            else
                [~, action] = max(qTable(currentState(1), currentState(2), :));
            end
            newState = currentState + actions(action, :);
            % Check if new state is valid
            if newState(1) < 1 || newState(1) > gridSize || ...
                    newState(2) < 1 || newState(2) > gridSize
                continue;
            end
            if isequal(newState, goalPos)
                reward = rewardGoal;
                isGoalReached = true;
            elseif grid(newState(1), newState(2)) == 1
                reward = rewardObstacle;
            else
                reward = rewardMove;
            end
            oldQValue = qTable(currentState(1), currentState(2), action);
            maxFutureQ = max(qTable(newState(1), newState(2), :));
            newQValue = (1 - alpha) * oldQValue + alpha * (reward + gamma * maxFutureQ);
            qTable(currentState(1), currentState(2), action) = newQValue;
            currentState = newState;
            stepCount = stepCount + 1;
            % Check for goal reached and display message
            if isGoalReached
                disp('Goal Reached!');
                break;
            end
        end
    end

    disp(['Training Episode ', num2str(episode)]);
    visualizeGrid(grid, robotPos, goalPos);
    pause(1); 
end
%% 

for episode = 1:maxEpisodes
    stepCount = 0;
    currentState = robotPos;
    isGoalReached = false;
    while ~isGoalReached && stepCount < maxSteps
        grid = moveObstacles(grid, gridSize);
        if rand > epsilon
            action = ceil(rand * 4);
        else
            [~, action] = max(qTable(currentState(1), currentState(2), :));
        end
        newState = currentState + actions(action, :);
        if newState(1) < 1 || newState(1) > gridSize || ...
                newState(2) < 1 || newState(2) > gridSize
            continue; 
        end
        if isequal(newState, goalPos)
            reward = rewardGoal;
            isGoalReached = true;
        elseif grid(newState(1), newState(2)) == 1
            reward = rewardObstacle;
        else
            reward = rewardMove;
        end
        currentState = newState;
        stepCount = stepCount + 1;
        visualizeGrid(grid, currentState, goalPos);
        pause(0.1);
        if isGoalReached
            disp('Goal Reached!');
            break; 
        end
    end
    disp([' Testing Episode ', num2str(episode)]);
    visualizeGrid(grid, robotPos, goalPos);
    pause(1);
end
%% 

function grid = moveObstacles(grid, gridSize)
    [obstacleRows, obstacleCols] = find(grid == 1);
    numObstacles = length(obstacleRows);
    for i = 1:numObstacles
        currentPos = [obstacleRows(i), obstacleCols(i)];
        possibleMoves = [0 -1; 0 1; -1 0; 1 0];
        move = possibleMoves(randi(4), :);
        newPos = currentPos + move;
        % Check for grid boundaries and overlap with robot (-1) or goal (-2)
        if newPos(1) >= 1 && newPos(1) <= gridSize && ...
           newPos(2) >= 1 && newPos(2) <= gridSize && ...
           grid(newPos(1), newPos(2)) <= 0
            grid(currentPos(1), currentPos(2)) = 0;
            grid(newPos(1), newPos(2)) = 1;
        end
    end
end
%% 

function visualizeGrid(Environmentgrid, robotPos, goalPos)
    clf;
    hold on; 
    greyGrid = ones(size(Environmentgrid)) * 0.5; 
    imagesc(greyGrid);
    [obstacleRows, obstacleCols] = find(Environmentgrid == 1);
    plot(obstacleCols, obstacleRows, 'ws', 'MarkerSize', 10, 'MarkerFaceColor', 'white'); % White squares for obstacles
    robotMarkerSize = 5; 
    plot(robotPos(2), robotPos(1), 'ko', 'MarkerSize', robotMarkerSize, 'MarkerFaceColor', 'black'); % Black circle for robot
    plot(goalPos(2), goalPos(1), 'g*', 'MarkerSize', 10); % Green star for goal
    axis equal;
    grid on;
    hold off;
end