import numpy as np
import matplotlib.pyplot as plt
grid_size = 10
start_point = (1, 1)
max_steps = 50
n_obstacles = 20
n_trials = 100  # HERE I AM VARYING THE NUMBER OF MAX STEPS WHILE KEEPING THE TRAILS SAME

def is_valid_move(point, grid):
    x, y = point
    return 0 < x <= grid_size and 0 < y <= grid_size and grid[x-1, y-1] == 0

def move_robot(robot_pos, grid):
    moves = [(0, 1), (1, 0), (0, -1), (-1, 0)]  
    np.random.shuffle(moves)
    for dx, dy in moves:
        new_pos = (robot_pos[0] + dx, robot_pos[1] + dy)
        if is_valid_move(new_pos, grid):
            return new_pos  
    return robot_pos 

def run_trial(goal_point):

    grid = np.zeros((grid_size, grid_size))
    robot_pos = start_point
    steps = 0

    while steps < max_steps:
        grid.fill(0)
        obstacles = np.random.choice(grid_size * grid_size, n_obstacles, replace=False)
        for obs in obstacles:
            grid[obs // grid_size, obs % grid_size] = 1
        prev_pos = robot_pos
        robot_pos = move_robot(robot_pos, grid)
        if grid[robot_pos[0]-1, robot_pos[1]-1] == 1:
            robot_pos = prev_pos  # Robot returns to previous position
        if robot_pos == goal_point:
            return True
        steps += 1
    return False  # If Goal not reached within step limit

# Calculate probabilities for each goal point
probabilities = {}
for x in range(1, grid_size + 1):
    for y in range(1, grid_size + 1):
        if (x, y) != start_point:
            success_count = sum(run_trial((x, y)) for _ in range(n_trials))
            probabilities[(x, y)] = success_count / n_trials

goal_points = list(probabilities.keys())
success_probabilities = list(probabilities.values())
plt.figure(figsize=(12, 8))
plt.scatter(*zip(*goal_points), c=success_probabilities, cmap='rainbow',marker='o')
plt.colorbar(label='Probability of Reaching Goal')
plt.xlabel('Goal Point X Coordinate')
plt.ylabel('Goal Point Y Coordinate')
plt.title('Probability of Reaching Various Goal Points in a 10x10 Grid')
plt.grid(True)
plt.show()