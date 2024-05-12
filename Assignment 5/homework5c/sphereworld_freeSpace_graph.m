%function [graphVector]=sphereworld_freeSpace_graph(NCells)
%The function performs the following steps: enumerate  the file      Marker
%file_provided [sphereworld.mat]  @x   sphereworld.mat.  a structure  @x   grid
%with fields  @x   xx and  @x   yy, each one containing  @x   NCells values
%linearly spaced values from  @x   -10 to  @x   10.  the field  @x   grid.F
%following the format expected by grid2graph in Question  q:gridgraph, i.e., with
%a  @x   true if the space is free, and a  @x   false if the space is occupied by
%a sphere at the corresponding coordinates. The best way to manipulate the output
%of potential_total (for checking collisions with the spheres) while using it in
%conjunction with grid_eval (to evaluate the collisions along all the points on
%the grid); note that the choice of the attractive potential here does not
%matter.  grid2graph.  the resulting  @x   graphVector structure. enumerate
function [graphVector]=sphereworld_freeSpace_graph(NCells)
% Locally xGoal ran because it was loaded in the system
% Lets just load the sphereworld file
    load("sphereworld.mat");
    grid = struct('xx', linspace(-10, 10, NCells),'yy', linspace(-10, 10, NCells));
    % A struct for Collision Potential
    potential_collision = struct('xGoal', xGoal, 'repulsiveWeight', 0.01, 'shape', 'conic');
    %  To check Collision
    collision_true = @(xEval) checkCollision(xEval, world, potential_collision);
    grid = grid_eval(grid, collision_true);
    graphVector = grid2graph(grid);
    %Changing to Graph or converting to graph
end

function isFree = checkCollision(xEval, world, potential)
    
    isFree = ~isnan(potential_total(xEval, world, potential)); 
end

