function twolink_planner_test
potential=struct('shape','quadratic','repulsiveWeight',0.5);
plannerParameters=struct('epsilon',1e-3,...
    'NSteps',400);
twolink_planner_runPlot(potential,plannerParameters)
