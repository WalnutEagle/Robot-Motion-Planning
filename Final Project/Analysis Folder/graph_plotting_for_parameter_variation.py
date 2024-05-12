# this is for the dataset generation
import numpy as np
import pandas as pd

# Parameters for simulation
alpha_values = np.linspace(0.001, 1, 10)  # 10 values from 0.001 to 1
gamma_values = np.linspace(0.01, 1, 10)   # 10 values from 0.01 to 1
epsilon_values = np.linspace(0.1, 1, 10)  # 10 values from 0.1 to 1

# Placeholder for simulation results
results = []

# Function to simulate the grid and Q-learning process (simplified version)
def simulate_q_learning(alpha, gamma, epsilon):
    # Simulate the Q-learning process (details omitted for brevity)
    # Return a simulated "goal reached" count (randomly generated for this example)
    return np.random.randint(0, 10)  # Random count for demonstration

# Running the simulations
for alpha in alpha_values:
    for gamma in gamma_values:
        for epsilon in epsilon_values:
            goal_reached_count = simulate_q_learning(alpha, gamma, epsilon)
            results.append({'alpha': alpha, 'gamma': gamma, 'epsilon': epsilon, 'goal_reached_count': goal_reached_count})

# Creating a DataFrame from the results
results_df = pd.DataFrame(results)

# Display the first few rows of the DataFrame
results_df.head()
#
#
#
#

# Splitting the data into three separate DataFrames for each variable
df_alpha = results_df.groupby('alpha')['goal_reached_count'].mean().reset_index()
df_gamma = results_df.groupby('gamma')['goal_reached_count'].mean().reset_index()
df_epsilon = results_df.groupby('epsilon')['goal_reached_count'].mean().reset_index()

# Plotting
fig, axes = plt.subplots(3, 1, figsize=(10, 15))

# Plot for alpha
axes[0].plot(df_alpha['alpha'], df_alpha['goal_reached_count'], marker='o', color='b')
axes[0].set_title('Goal Reached Count vs Alpha')
axes[0].set_xlabel('Alpha')
axes[0].set_ylabel('Average Goal Reached Count')

# Plot for gamma
axes[1].plot(df_gamma['gamma'], df_gamma['goal_reached_count'], marker='o', color='r')
axes[1].set_title('Goal Reached Count vs Gamma')
axes[1].set_xlabel('Gamma')
axes[1].set_ylabel('Average Goal Reached Count')

# Plot for epsilon
axes[2].plot(df_epsilon['epsilon'], df_epsilon['goal_reached_count'], marker='o', color='g')
axes[2].set_title('Goal Reached Count vs Epsilon')
axes[2].set_xlabel('Epsilon')
axes[2].set_ylabel('Average Goal Reached Count')

plt.tight_layout()
plt.show()


#
#
#
#
#
#this is for all the analysis 
# For the first graph: Averaging the values of alpha, gamma, and epsilon for each row and plotting against goal reached count
results_df['average_parameter'] = results_df[['alpha', 'gamma', 'epsilon']].mean(axis=1)
df_average = results_df.groupby('average_parameter')['goal_reached_count'].mean().reset_index()

# For the second graph: Plotting each variable variation separately on the same graph
fig, axes = plt.subplots(2, 1, figsize=(10, 12))

# First Graph
axes[0].plot(df_average['average_parameter'], df_average['goal_reached_count'], marker='o', color='purple')
axes[0].set_title('Goal Reached Count vs Average of Parameters')
axes[0].set_xlabel('Average of Alpha, Gamma, Epsilon')
axes[0].set_ylabel('Average Goal Reached Count')

# Second Graph
axes[1].plot(df_alpha['alpha'], df_alpha['goal_reached_count'], label='Alpha', marker='o', color='blue')
axes[1].plot(df_gamma['gamma'], df_gamma['goal_reached_count'], label='Gamma', marker='o', color='red')
axes[1].plot(df_epsilon['epsilon'], df_epsilon['goal_reached_count'], label='Epsilon', marker='o', color='green')
axes[1].set_title('Goal Reached Count vs Individual Parameters')
axes[1].set_xlabel('Parameter Value')
axes[1].set_ylabel('Average Goal Reached Count')
axes[1].legend()

plt.tight_layout()
plt.show()