function [newPos, reward, done] = takeAction(pos, action, state, goalPos)
    % Initialize default values
    newPos = pos;
    reward = -0.1; % Small negative reward for each move
    done = false;

    % Define movement based on action
    switch action
        case 1 % Move up
            newPos(1) = max(pos(1) - 1, 1);
        case 2 % Move down
            newPos(1) = min(pos(1) + 1, size(state, 1));
        case 3 % Move left
            newPos(2) = max(pos(2) - 1, 1);
        case 4 % Move right
            newPos(2) = min(pos(2) + 1, size(state, 2));
    end

    % Check for obstacles and goal
    if state(newPos(1), newPos(2)) == 1
        reward = -1; % Negative reward for hitting an obstacle
        newPos = pos; % Reset position
    elseif all(newPos == goalPos)
        reward = 1; % Positive reward for reaching the goal
        done = true;
    end
end
