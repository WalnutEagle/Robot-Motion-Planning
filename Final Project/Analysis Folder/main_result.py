import numpy as np
import random
import matplotlib.pyplot as plt

# Define constants
REWARD_OBSTACLE = -100
REWARD_GOAL = 100
REWARD_MOVE = -1
GRID_SIZE = 10
NUM_OBSTACLES = 20

# Actions: up, down, left, right
actions = np.array([[0, -1], [0, 1], [-1, 0], [1, 0]])

# Initialize grid
grid = np.zeros((GRID_SIZE, GRID_SIZE))

# Place robot and goal
robot_pos = np.array([0, 0])  # Python uses 0-indexing
goal_pos = np.array([9, 9])  # Adjusted for 0-indexing
grid[tuple(robot_pos)] = -1  # Robot
grid[tuple(goal_pos)] = -2  # Goal

# Place obstacles
for _ in range(NUM_OBSTACLES):
    while True:
        obstacle_pos = np.random.randint(0, GRID_SIZE, size=2)
        if not (np.array_equal(obstacle_pos, robot_pos) or np.array_equal(obstacle_pos, goal_pos)):
            grid[tuple(obstacle_pos)] = 1
            break

# Q-learning parameters
alpha = 1.0  # Learning rate
gamma = 0.9  # Discount factor
epsilon = 0.1  # Exploration rate
q_table = np.zeros((GRID_SIZE, GRID_SIZE, 4))  # 4 actions
# #Function to move obstacles
# def move_obstacles(grid):
#     obstacle_positions = np.argwhere(grid == 1)
#     for pos in obstacle_positions:
#         while True:
#             move = actions[random.randint(0, 3)]
#             new_pos = pos + move
#             if 0 <= new_pos[0] < GRID_SIZE and 0 <= new_pos[1] < GRID_SIZE and grid[tuple(new_pos)] <= 0:
#                 grid[tuple(pos)] = 0
#                 grid[tuple(new_pos)] = 1
#                 break

# # Visualization function
# def visualize_grid(grid, robot_pos, goal_pos):
#     plt.imshow(grid, cmap='gray')
#     plt.scatter(robot_pos[1], robot_pos[0], c='blue', label='Robot')
#     plt.scatter(goal_pos[1], goal_pos[0], c='green', label='Goal')
#     obstacles = np.argwhere(grid == 1)
#     for obstacle in obstacles:
#         plt.scatter(obstacle[1], obstacle[0], c='red', marker='x')
#     plt.legend()
#     plt.pause(0.1)
#     plt.clf()
# Function to move obstacles
def move_obstacles(grid):
    global GRID_SIZE  # Use the global GRID_SIZE
    obstacle_positions = np.argwhere(grid == 1)
    for pos in obstacle_positions:
        grid[tuple(pos)] = 0  # Clear the current obstacle position
        while True:
            move = actions[random.randint(0, 3)]
            new_pos = pos + move
            if 0 <= new_pos[0] < GRID_SIZE and 0 <= new_pos[1] < GRID_SIZE and grid[tuple(new_pos)] == 0:
                grid[tuple(new_pos)] = 1
                break

# Visualization function
def visualize_grid(grid, robot_pos, goal_pos):
    plt.imshow(grid, cmap='gray', vmin=-2, vmax=1)
    plt.scatter(robot_pos[1], robot_pos[0], c='blue', label='Robot', marker='s')
    plt.scatter(goal_pos[1], goal_pos[0], c='green', label='Goal', marker='o')
    plt.title('Grid World')
    plt.xlabel('X-axis')
    plt.ylabel('Y-axis')
    plt.legend(loc='upper right')
    plt.pause(0.1)
    plt.clf()

for episode in range(10):  # 10 episodes
    move_obstacles(grid)
    step_count = 0
    current_state = np.copy(robot_pos)
    is_goal_reached = False

    while not is_goal_reached and step_count < 100:  # Max steps
        # Exploration or exploitation
        if random.random() < epsilon:
            action = random.randint(0, 3)
        else:
            action = np.argmax(q_table[tuple(current_state)])

        # Take action
        new_state = current_state + actions[action]

        # Check if new state is valid
        if not (0 <= new_state[0] < GRID_SIZE and 0 <= new_state[1] < GRID_SIZE):
            continue

        # Reward assignment
        if np.array_equal(new_state, goal_pos):
            reward = REWARD_GOAL
            is_goal_reached = True
        elif grid[tuple(new_state)] == 1:
            reward = REWARD_OBSTACLE
        else:
            reward = REWARD_MOVE

        # Q-table update
        old_q_value = q_table[tuple(current_state)][action]
        max_future_q = np.max(q_table[tuple(new_state)])
        new_q_value = (1 - alpha) * old_q_value + alpha * (reward + gamma * max_future_q)
        q_table[tuple(current_state)][action] = new_q_value

        # Update current state
        current_state = new_state
        step_count += 1

        # Visualization
        visualize_grid(grid, current_state, goal_pos)
        

    # End of episode
    print(f'Episode {episode + 1}: Goal Reached!' if is_goal_reached else 'Goal Not Reached')

plt.show()


