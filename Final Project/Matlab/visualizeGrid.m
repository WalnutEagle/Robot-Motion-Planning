function visualizeGrid(state, agentPos, goalPos)
    imagesc(state); % Display the grid as an image
    hold on;
    colormap('gray'); % Set color map for better visibility
    % Plot agent position
    plot(agentPos(2), agentPos(1), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b'); 
    % Plot goal position
    plot(goalPos(2), goalPos(1), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g'); 
    hold off;
    axis square;
    grid on;
    set(gca,'YDir','reverse'); % Adjust the Y-axis direction
    drawnow;
end
