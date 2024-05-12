%running the code
numTestEpisodes = 100;
successCount = 0;
totalSteps = 0;
totalReward = 0;

for episode = 1:numTestEpisodes
    % Initialize state for testing
    state = zeros(gridSize, gridSize);
    for i = 1:size(obstacle, 1)
        state(obstacle(i,1), obstacle(i,2)) = 1;
    end
    agentPos = [1, 1]; % Reset agent position at the start of each episode
    state(agentPos(1), agentPos(2)) = 2;
    state(goalPos(1), goalPos(2)) = 3;

    done = false;
    steps = 0;
    episodeReward = 0;
    
    while ~done
        % Choose the best action from Q-table
        [~, action] = max(Q(agentPos(1), agentPos(2), :));

        % Take action and observe new state and reward
        [newAgentPos, reward, done] = takeAction(agentPos, action, state, goalPos);
        episodeReward = episodeReward + reward;

        % Update state
        state(agentPos(1), agentPos(2)) = 0; % Clear old position
        agentPos = newAgentPos; % Update agent position
        state(agentPos(1), agentPos(2)) = 2; % Set new position

        steps = steps + 1;

        % Check if goal is reached
        if all(agentPos == goalPos)
            successCount = successCount + 1;
        end
    end

    totalSteps = totalSteps + steps;
    totalReward = totalReward + episodeReward;
end

% Calculate evaluation metrics
successRate = successCount / numTestEpisodes;
averageSteps = totalSteps / numTestEpisodes;
averageReward = totalReward / numTestEpisodes;

% Display the results
fprintf('Success Rate: %.2f%%\n', successRate * 100);
fprintf('Average Steps per Episode: %.2f\n', averageSteps);
fprintf('Average Reward per Episode: %.2f\n', averageReward);