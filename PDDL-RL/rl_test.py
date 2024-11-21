import gymnasium as gym
from gymnasium.utils import seeding
import numpy as np
from stable_baselines3 import PPO 
from stable_baselines3.common.vec_env import DummyVecEnv
from stable_baselines3.common.monitor import Monitor

class PlanReorderEnv(gym.Env):
    def __init__(self, initial_plan):
        super(PlanReorderEnv, self).__init__()

        # Store a list of strings (actions)
        self.initial_plan = initial_plan
        self.current_plan = initial_plan.copy()

        # Observation space is now a discrete space of action indices
        self.action_space = gym.spaces.Discrete(len(initial_plan) * (len(initial_plan) - 1))  # Swap actions
        self.observation_space = gym.spaces.Box(low=0, high=len(initial_plan)-1, shape=(len(initial_plan),), dtype=np.int32)

        # Store a mapping from indices to action strings for easy reference
        self.action_to_string = {i: action for i, action in enumerate(initial_plan)}

    def reset(self, seed=None, **kwargs):
        # Handle seeding
        self.np_random, seed = seeding.np_random(seed)

        # Reset the plan to its initial state
        self.current_plan = self.initial_plan.copy()

        # Return the index-based state as a single numpy array and an info dictionary
        observation = np.array([i for i in range(len(self.current_plan))], dtype=np.int32)
        info = {}  # You can add any additional info here if needed
        return observation, info  # Return observation and info

    def step(self, action):
        # Decode action (swap two elements based on the action index)
        idx1, idx2 = action // len(self.current_plan), action % len(self.current_plan)
        self.current_plan[idx1], self.current_plan[idx2] = self.current_plan[idx2], self.current_plan[idx1]

        # Calculate reward (example logic)
        if self.is_valid():
            if self.is_goal_state():
                reward = 10  # High reward for achieving the goal
                done = True
                truncated = False  # No truncation, episode ends when goal is reached
            else:
                reward = -0.1  # Small penalty for each step
                done = False
                truncated = False  # No truncation, still progressing
        else:
            reward = -5  # Penalty for invalid sequence
            done = True
            truncated = False  # No truncation, but episode ends due to invalid state

        # Return a single numpy array as observation, and the reward, done, truncated, and info
        return np.array([i for i in range(len(self.current_plan))], dtype=np.int32), reward, done, truncated, {}

    def is_valid(self):
        # Example validity check: Ensure red_wire precedes blue_wire
        red_index = next((i for i, action in enumerate(self.current_plan) if "red_wire" in action), -1)
        blue_index = next((i for i, action in enumerate(self.current_plan) if "blue_wire" in action), -1)
        return red_index < blue_index if red_index != -1 and blue_index != -1 else True

    def is_goal_state(self):
        # Example: Check if the red_wire is installed before the blue_wire
        return self.is_valid()





# Define initial plan (action sequence)
initial_plan = [
    "(find blue_wire)", "(find red_wire)", "(pickup arm1 blue_wire table)",
    "(insert arm1 blue_wire power_supply_1)", "(lock arm2 blue_wire power_supply_1)",
    "(pickup arm1 red_wire table)", "(insert arm1 red_wire power_supply_2)",
    "(lock arm2 red_wire power_supply_2)"
]

# Test environment setup
env = PlanReorderEnv(initial_plan)
print("Initial state:", env.reset())
# Define the RL model
env = PlanReorderEnv(initial_plan)

# Wrap the environment with Monitor and DummyVecEnv
env = Monitor(env)
env = DummyVecEnv([lambda: env])

model = PPO("MlpPolicy", env, verbose=1)

# Train the model
model.learn(total_timesteps=10000)

# Test trained model
obs = env.reset()
done = False
while not done:
    print(f"Current state: {obs}")
    action, _ = model.predict(obs)
    obs, reward, done, info = env.step(action)
    
    print(f"Action taken: {action}")
    print(f"New state: {obs}")


print("Reordered Plan:", obs)
