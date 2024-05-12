%function clfcbf_planner_runPlotTest()
%Show the results of potential_planner_runPlot for one combination of @boxIvory2
%repulsiveWeight and @boxIvory2 epsilon that makes the planner work reliably.
function clfcbf_planner_runPlotTest(xEval,xGoal)
load('sphereworld.mat');
potential =struct;
plannerParameters = struct;
potential.repulsiveWeight = 0.1;
potential.epslion = 1e-2;
potential.shape = 'conic';
potential.xGoal = xGoal;
plannerParameters.control = @clfcbf_control;
plannerParameters.Nsteps = 20;
plannerParameters.U = @potential_attractive;
potential_planner_runPlot(potential,plannerParameters)


   % % 1) Load the sphere world in the variable world
   %  load('sphereworld.mat','xGoal','xStart','world')
   % 
   %  % 2) Create the struct potential
   %  potential.shape = 'conic';
   %  xEval = [7.25; 0];
   %  potential.xGoal = xGoal;
   %  % 3) Create the plannerParameters struct
   %  plannerParameters.U = potential_attractive(xEval,potential);
   %  plannerParameters.control = @clfcbf_control;
   %  plannerParameters.NSteps = 20; % You can adjust this value if necessary
   % 
   %  % 4) Call potential_planner_runPlot()
   %  potential_planner_runPlot(potential, plannerParameters);

end
%For the argument @boxIvory2 plannerParameters.U, use potential_attractive, for
%the argument @boxIvory2 plannerParameters.control, use @boxIvory2
%@clfcbf_control, for @boxIvory2 plannerParameters.NSteps, use @boxIvory2 20 (but
%increase to @boxIvory2 25 if necessary), and for @boxIvory2 potential.shape, use
%@boxIvory2 'quadratic'.
