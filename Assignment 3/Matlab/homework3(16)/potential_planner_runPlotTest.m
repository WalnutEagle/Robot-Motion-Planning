% %function potential_planner_runPlotTest()
% %Show the results of potential_planner_runPlot for each goal location in
% %@boxIvory2 world.xGoal, and for different interesting combinations of @boxIvory2
% %potential.repulsiveWeight, @boxIvory2 potential.shape, @boxIvory2
% %plannerParameters.epsilon, and @boxIvory2 plannerParameters.NSteps. In each
% %case, for the structure @boxIvory2 plannerParameters should have the field
% %@boxIvory2 U set to @boxIvory2 @potential_total, and the field @boxIvory2
% %control set to the negative of @boxIvory2 @potential_totalGrad.
% function potential_planner_runPlotTest()
% s = load("sphereworld.mat");
% 
% %Plot the graphs
% for i=1:numel(s.xGoal)
%     for i=1:numel(s.xStart)
%         potential.xGoal =
%         potential.replusiveWeight = 0.01;
%         potential.shape = 
%     end
%     figure;
%     subplot(1, 2, 1);
%     title('World Plot');
% 
%     sphereworld_plot(s.world,s.xGoal);
%     subplot(1, 2, 2);
% end   
% 
% %Step 2-b
% 
% 
% 
% 
% 
% 
% 
% 
% 
% end
% 
% %For the @boxIvory2 plannerParameters.control argument, pass a function computing
% %the negative of the gradient. Start with $ $ in the inteval $@boxIvory2
% %0.01-@boxIvory2 0.1$, $ $ in the range $@boxIvory2 1e-3-@boxIvory2 1e-2$, for
% %@boxIvory2 plannerParameters.NSteps, use @boxIvory2 100, and explore from there.
% %Typically, adjustments in @boxIvory2 repulsiveWeight require subsequent
% %adjustments in @boxIvory2 epsilon. For  every case where the planner converges,
% %add a plot where you zoom in closely around the final equilibrium. Hints are
% %available for this question.
function potential_planner_runPlotTest()


load('sphereworld.mat');


repulsiveWeights = 0.01;
%repulsiveWeights = linspace(0.01, 0.1);
epsilons = 1e-3;
%epsilons = [1e-3, 1e-2];
NStepsValues = 100;  


for repulsiveWeight = repulsiveWeights
    for epsilon = epsilons
        for NSteps = NStepsValues
           
            % 2) For every goal location in xGoal:
            for g = 1:size(xGoal, 2)
               
                % 2(a) Create a new figure with two subplots
                figure;
                subplot(1, 2, 1);
                title('World Plot')
                sphereworld_plot(world, xGoal(:, g));
                hold on;
               
                % 2(b) For every start location in xStart:
                for s = 1:size(xStart, 2)
                   
                    % i. Prepare the potential structure
                    potential.xGoal = xGoal(:, g);
                    potential.repulsiveWeight = repulsiveWeight;
                    potential.shape = 'quadratic';  % Change based on requirements

                    % ii. Create function handles
                    potential_total_handle = @(x, w, p) potential_total(x, w, p);
                    potential_totalGrad_handle = @(x, w, p) potential_totalGrad(x, w, p);

                    % iii. Prepare the structure plannerParameters
                    plannerParameters.U = potential_total_handle;
                    plannerParameters.control = @(x, w, p) -potential_totalGrad_handle(x, w, p);
                    plannerParameters.epsilon = epsilon;
                    plannerParameters.NSteps = NSteps;
                   
                    % iv. Call the potential_planner
                    [xPath, UPath] = potential_planner(xStart(:, s), world, potential, plannerParameters);
                   
                    % v. Plot the resulting trajectory
                    plot(xPath(1, :), xPath(2, :));
                   
                    % vi. Plot UPath in second subplot
                    subplot(1, 2, 2);
                    title('Trajectory')
                    semilogy(UPath);
                    hold on;
                end
                % 2(d) Add another figure if required (based on convergence criteria)

            end
           
        end
    end
end
end