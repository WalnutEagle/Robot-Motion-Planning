numEpisodes = 1000;
learningRate = 0.01;
gamma = 0.9; % Discount factor
epsilon = 0.1; % Exploration rate

Q = zeros(gridSize, gridSize, 4); % 4 actions: up, down, left, right

for episode = 1:numEpisodes
    % Initialize state
    state = zeros(gridSize, gridSize);
    for i = 1:size(obstacle, 1)
        state(obstacle(i,1), obstacle(i,2)) = 1;
    end
    agentPos = [1, 1]; % Reset agent position at the start of each episode
    state(agentPos(1), agentPos(2)) = 2;
    state(goalPos(1), goalPos(2)) = 3;

    done = false;
    
    while ~done
        % Epsilon-greedy strategy for action selection
        if rand() < epsilon
            action = randi(4); % Random action (1: up, 2: down, 3: left, 4: right)
        else
            [~, action] = max(Q(agentPos(1), agentPos(2), :));
        end

        % Take action and observe new state and reward
        [newAgentPos, reward, done] = takeAction(agentPos, action, state, goalPos);

        % Q-learning update rule
        oldQ = Q(agentPos(1), agentPos(2), action);
        [maxQNewState, ~] = max(Q(newAgentPos(1), newAgentPos(2), :));
        Q(agentPos(1), agentPos(2), action) = oldQ + learningRate * (reward + gamma * maxQNewState - oldQ);

        % Update state
        state(agentPos(1), agentPos(2)) = 0; % Clear old position
        agentPos = newAgentPos; % Update agent position
        state(agentPos(1), agentPos(2)) = 2; % Set new position

        % Check if goal is reached
        if all(agentPos == goalPos)
            done = true;
        end
    end
end
