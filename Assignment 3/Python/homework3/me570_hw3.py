import matplotlib.pyplot as plt
import numpy as np
from me570_geometry import Sphere
import me570_geometry
import me570_potential


def sphere_test_collision():
    """
    Generates one figure with a sphere (with arbitrary parameters) and
    nb_points=100 random points that are colored according to the sign of
    their distance from the sphere (red for negative, green for positive).
    Generates a second figure in the same way (and the same set of points)
    but flipping the sign of the radius  r of the sphere. For each sampled
    point, plot also the result of the output  pointsSphere.
    """
    # Create a random set of 2-D points
    nb_points = 100
    points = np.random.rand(2, nb_points) * 10  # Adjust the range as needed

    # Create a sphere with arbitrary parameters
    center = [5, 5]
    radius = 2
    distance_influence = 10
    sphere = Sphere(center, radius, distance_influence)

    # Calculate the distances of points to the sphere
    distances = sphere.distance(points)

    # Create a figure with points colored based on distance (red for negative, green for positive)
    plt.figure(figsize=(8, 4))
    plt.subplot(1, 2, 1)
    plt.scatter(points[0], points[1], c=np.where(distances < 0, 'red', 'green'))
    plt.title("Original Sphere")

    # Create a sphere with the opposite sign of the radius
    opposite_sphere = Sphere(center, -radius, distance_influence)

    # Calculate the distances to the opposite-signed sphere
    opposite_distances = opposite_sphere.distance(points)

    # Create a figure with points colored based on distance to the opposite-signed sphere
    plt.subplot(1, 2, 2)
    plt.scatter(points[0], points[1], c=np.where(opposite_distances < 0, 'red', 'green'))
    plt.title("Opposite-signed Sphere")

    plt.show()


def clfcbf_control_test_singlesphere():
    """
    Use the provided function Grid.plot_threshold ( ) to visualize the CLF-CBF control field for a single filled-in sphere
    """
    # A single sphere whose edge intersects the origin
    world = me570_potential.SphereWorld()
    world.world = [
        me570_geometry.Sphere(center=np.array([[0], [-2]]),
                              radius=2,
                              distance_influence=1)
    ]
    world.x_goal = np.array([[0], [-6]])
    pars = {
        'repulsive_weight': 0.1,
        'x_goal': np.array([[0], [-6]]),
        'shape': 'conic'
    }

    xx_ticks = np.linspace(-10, 10, 23)
    grid = me570_geometry.Grid(xx_ticks, xx_ticks)

    clfcbf = me570_potential.Clfcbf_Control(world, pars)
    plt.figure()
    world.plot()
    grid.plot_threshold(clfcbf.control, 1)


def planner_run_plot_test():
    """
    Show the results of Planner.run_plot for each goal location in
    world.xGoal, and for different interesting combinations of
    potential['repulsive_weight'],  potential['shape'],  epsilon, and
    nb_steps. In each case, for the object of class  Planner should have the
    attribute  function set to  Total.eval, and the attribute  control set
    to the negative of  Total.grad.
    """
    pass  # Substitute with your code


def clfcbf_run_plot_test():
    """
    Use the function Planner.run_plot to run the planner based on the
    CLF-CBF framework, and show the results for one combination of
    repulsive_weight and  epsilon that makes the planner work reliably.
    """
    pass  # Substitute with your code

if __name__ == "__main__":
    sphere_test_collision()