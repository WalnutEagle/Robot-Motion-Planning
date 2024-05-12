numTestEpisodes = 10; % Reduced for quicker visualization
pauseTime = 0.1; % Pause time for visualization

for episode = 1:numTestEpisodes
    % Initialize state for testing
    state = zeros(gridSize, gridSize);
    for i = 1:size(obstacle, 1)
        state(obstacle(i,1), obstacle(i,2)) = 1;
    end
    agentPos = [1, 1];
    state(agentPos(1), agentPos(2)) = 2;
    state(goalPos(1), goalPos(2)) = 3;

    done = false;
    
    figure; % Open a new figure window
    while ~done
        visualizeGrid(state, agentPos, goalPos); % Visualize the grid
        pause(pauseTime); % Pause for a short duration

        % Choose the best action from Q-table
        [~, action] = max(Q(agentPos(1), agentPos(2), :));

        % Take action and observe new state and reward
        [newAgentPos, ~, done] = takeAction(agentPos, action, state, goalPos);

        % Update state
        state(agentPos(1), agentPos(2)) = 0;
        agentPos = newAgentPos;
        state(agentPos(1), agentPos(2)) = 2;
    end
end
