

import numpy as np

import me570_geometry as gm


def polygons_add_x_reflection(vertices):
    """
    Given a sequence of vertices, adds other vertices by reflection
    along the x axis
    """
    vertices = np.hstack([vertices, np.fliplr(np.diag([1, -1]).dot(vertices))])
    return vertices


def polygons_generate():
    """
    Generate the polygons to be used for the two-link manipulator
    """
    vertices1 = np.array([[0, 5], [-1.11, -0.511]])
    vertices1 = polygons_add_x_reflection(vertices1)
    vertices2 = np.array([[0, 3.97, 4.17, 5.38, 5.61, 4.5],
                          [-0.47, -0.5, -0.75, -0.97, -0.5, -0.313]])
    vertices2 = polygons_add_x_reflection(vertices2)
    return (gm.Polygon(vertices1), gm.Polygon(vertices2))


polygons = polygons_generate()

import matplotlib.pyplot as plt
import numpy as np

import me570_geometry as gm


def hat2(theta):
    """
    Givenascalar returnthe2x2skewsymmetricmatrixcorrespondingtothe    hatoperator    """
    return np.array([[0, -theta], [theta, 0]])


def polygons_add_x_reflection(vertices):
    """
    Givenasequenceofvertices addsotherverticesbyreflection    alongthexaxis    """
    vertices = np.hstack([vertices, np.fliplr(np.diag([1, -1]).dot(vertices))])
    return vertices


def polygons_generate():
    """
    Generatethepolygonstobeusedforthetwolinkmanipulator    """
    vertices1 = np.array([[0, 5], [-1.11, -0.511]])
    vertices1 = polygons_add_x_reflection(vertices1)
    vertices2 = np.array([[0, 3.97, 4.17, 5.38, 5.61, 4.5],
                          [-0.47, -0.5, -0.75, -0.97, -0.5, -0.313]])
    vertices2 = polygons_add_x_reflection(vertices2)
    return (gm.Polygon(vertices1), gm.Polygon(vertices2))


polygons = polygons_generate()


class TwoLink:
    """
    ClassforcreatingourTwo_LinkManipulator    """
    def kinematic_map(self, theta):
        """
        Thefunctionreturnsthecoordinateoftheendeffector plusthe        verticesofthelinks alltransformedaccordingto _1 _2
        """

        # Rotation matrices
        rotation_w_b1 = gm.rot2d(theta[0, 0])
        rotation_b1_b2 = gm.rot2d(theta[1, 0])
        rotation_w_b2 = rotation_w_b1 @ rotation_b1_b2

        # Translation matrix
        translation_b1_b2 = np.vstack((5, 0))
        translation_w_b2 = rotation_w_b1 @ translation_b1_b2

        # Transform end effector from B₂ to W
        p_eff_b2 = np.vstack((5, 0))
        vertex_effector_transf = rotation_w_b2 @ p_eff_b2 + translation_w_b2

        # Transform polygon 1 from B₁ to W
        polygon1_vertices_b1 = polygons[0].vertices
        polygon1_transf = gm.Polygon(rotation_w_b1 @ polygon1_vertices_b1)

        # Transform polygon 2 from B₂ to W
        polygon2_vertices_b2 = polygons[1].vertices
        polygon2_transf = gm.Polygon(rotation_w_b2 @ polygon2_vertices_b2 +
                                     translation_w_b2)
        return vertex_effector_transf, polygon1_transf, polygon2_transf

    def plot(self, theta, color):
        """
        ThisfunctionshoulduseTwoLinkkinematic_mapfromthepreviousquestiontogetherwith        themethodPolygonplotfromHomework1toplotthemanipulator
        """
        [_, polygon1_transf, polygon2_transf] = self.kinematic_map(theta)
        polygon1_transf.plot(color)
        polygon2_transf.plot(color)

    def is_collision(self, theta, points):
        """
        Foreachspecifiedconfiguration returns Trueif anyofthelinksofthemanipulator        collideswith anyofthepoints and Falseotherwise Usethefunction        Polygonis_collisiontocheckifeachlinkofthemanipulatorisincollision
        """

        nb_theta = theta.shape[1]
        flag_theta = [False] * nb_theta

        for i_theta in range(theta.shape[1]):
            config = np.vstack(theta[:, i_theta])
            [_, polygon1_transf, polygon2_transf] = self.kinematic_map(config)

            flag_points1 = polygon1_transf.is_collision(points)
            flag_points2 = polygon2_transf.is_collision(points)
            flag_theta[i_theta] = any(flag_points1) or any(flag_points2)

        return flag_theta

    def plot_collision(self, theta, points):
        """
        Thisfunctionshould
     - UseTwoLinkis_collisionfordeterminingifeachconfigurationisacollisionornot
     - UseTwoLinkplottoplotthemanipulatorforallconfigurations usingaredcolorwhenthe    manipulatorisincollision andgreenotherwise
     - Plotthepointsspecifiedby pointsasblackasterisks
        """
        collisions = self.is_collision(theta, points)
        for i, is_collision in enumerate(collisions):
            if is_collision:
                color = 'r'
            else:
                color = 'g'

            self.plot(np.vstack(theta[:, i]), color)
            plt.scatter(points[0, :], points[1, :], c='k', marker='*')

    def jacobian(self, theta, theta_dot):
        """
        ImplementthemapfortheJacobianofthepositionoftheendeffector        withrespecttothejointanglesasderivedintheassignment        """

        link_lengths = [5, 5]
        offset = [
            np.vstack([link_lengths[0], 0]),
            np.vstack([link_lengths[1], 0])
        ]
        vertex_effector_dot = np.zeros(theta.shape)

        for i in range(theta.shape[1]):
            theta_i = [theta[0, i], theta[1, i]]
            hat = [hat2(theta_dot[0, 0]), hat2(theta_dot[1, 0])]
            rot = [gm.rot2d(theta_i[0]), gm.rot2d(theta_i[1])]

            vertex_effector_dot[:, [i]] = hat[0] @ rot[0] @ \
                (rot[1]@offset[0]+offset[1]) \
                + rot[0]@hat[1]@rot[1]@offset[0]

        return vertex_effector_dot

# 


import numpy as np

import me570_geometry as gm


def polygons_add_x_reflection(vertices):
    """
    Given a sequence of vertices, adds other vertices by reflection
    along the x axis
    """
    vertices = np.hstack([vertices, np.fliplr(np.diag([1, -1]).dot(vertices))])
    return vertices


def polygons_generate():
    """
    Generate the polygons to be used for the two-link manipulator
    """
    vertices1 = np.array([[0, 5], [-1.11, -0.511]])
    vertices1 = polygons_add_x_reflection(vertices1)
    vertices2 = np.array([[0, 3.97, 4.17, 5.38, 5.61, 4.5],
                          [-0.47, -0.5, -0.75, -0.97, -0.5, -0.313]])
    vertices2 = polygons_add_x_reflection(vertices2)
    return (gm.Polygon(vertices1), gm.Polygon(vertices2))


polygons = polygons_generate()

import matplotlib.pyplot as plt
import numpy as np

import me570_geometry as gm


def hat2(theta):
    """
    Givenascalar returnthe2x2skewsymmetricmatrixcorrespondingtothe    hatoperator    """
    return np.array([[0, -theta], [theta, 0]])


def polygons_add_x_reflection(vertices):
    """
    Givenasequenceofvertices addsotherverticesbyreflection    alongthexaxis    """
    vertices = np.hstack([vertices, np.fliplr(np.diag([1, -1]).dot(vertices))])
    return vertices


def polygons_generate():
    """
    Generatethepolygonstobeusedforthetwolinkmanipulator    """
    vertices1 = np.array([[0, 5], [-1.11, -0.511]])
    vertices1 = polygons_add_x_reflection(vertices1)
    vertices2 = np.array([[0, 3.97, 4.17, 5.38, 5.61, 4.5],
                          [-0.47, -0.5, -0.75, -0.97, -0.5, -0.313]])
    vertices2 = polygons_add_x_reflection(vertices2)
    return (gm.Polygon(vertices1), gm.Polygon(vertices2))


polygons = polygons_generate()


class TwoLink:
    """
    ClassforcreatingourTwo_LinkManipulator    """
    def kinematic_map(self, theta):
        """
        Thefunctionreturnsthecoordinateoftheendeffector plusthe        verticesofthelinks alltransformedaccordingto _1 _2
        """

        # Rotation matrices
        rotation_w_b1 = gm.rot2d(theta[0, 0])
        rotation_b1_b2 = gm.rot2d(theta[1, 0])
        rotation_w_b2 = rotation_w_b1 @ rotation_b1_b2

        # Translation matrix
        translation_b1_b2 = np.vstack((5, 0))
        translation_w_b2 = rotation_w_b1 @ translation_b1_b2

        # Transform end effector from B₂ to W
        p_eff_b2 = np.vstack((5, 0))
        vertex_effector_transf = rotation_w_b2 @ p_eff_b2 + translation_w_b2

        # Transform polygon 1 from B₁ to W
        polygon1_vertices_b1 = polygons[0].vertices
        polygon1_transf = gm.Polygon(rotation_w_b1 @ polygon1_vertices_b1)

        # Transform polygon 2 from B₂ to W
        polygon2_vertices_b2 = polygons[1].vertices
        polygon2_transf = gm.Polygon(rotation_w_b2 @ polygon2_vertices_b2 +
                                     translation_w_b2)
        return vertex_effector_transf, polygon1_transf, polygon2_transf

    def plot(self, theta, color):
        """
        ThisfunctionshoulduseTwoLinkkinematic_mapfromthepreviousquestiontogetherwith        themethodPolygonplotfromHomework1toplotthemanipulator
        """
        [_, polygon1_transf, polygon2_transf] = self.kinematic_map(theta)
        polygon1_transf.plot(color)
        polygon2_transf.plot(color)

    def is_collision(self, theta, points):
        """
        Foreachspecifiedconfiguration returns Trueif anyofthelinksofthemanipulator        collideswith anyofthepoints and Falseotherwise Usethefunction        Polygonis_collisiontocheckifeachlinkofthemanipulatorisincollision
        """

        nb_theta = theta.shape[1]
        flag_theta = [False] * nb_theta

        for i_theta in range(theta.shape[1]):
            config = np.vstack(theta[:, i_theta])
            [_, polygon1_transf, polygon2_transf] = self.kinematic_map(config)

            flag_points1 = polygon1_transf.is_collision(points)
            flag_points2 = polygon2_transf.is_collision(points)
            flag_theta[i_theta] = any(flag_points1) or any(flag_points2)

        return flag_theta

    def plot_collision(self, theta, points):
        """
        Thisfunctionshould
     - UseTwoLinkis_collisionfordeterminingifeachconfigurationisacollisionornot
     - UseTwoLinkplottoplotthemanipulatorforallconfigurations usingaredcolorwhenthe    manipulatorisincollision andgreenotherwise
     - Plotthepointsspecifiedby pointsasblackasterisks
        """
        collisions = self.is_collision(theta, points)
        for i, is_collision in enumerate(collisions):
            if is_collision:
                color = 'r'
            else:
                color = 'g'

            self.plot(np.vstack(theta[:, i]), color)
            plt.scatter(points[0, :], points[1, :], c='k', marker='*')

    def jacobian(self, theta, theta_dot):
        """
        ImplementthemapfortheJacobianofthepositionoftheendeffector        withrespecttothejointanglesasderivedintheassignment        """

        link_lengths = [5, 5]
        offset = [
            np.vstack([link_lengths[0], 0]),
            np.vstack([link_lengths[1], 0])
        ]
        vertex_effector_dot = np.zeros(theta.shape)

        for i in range(theta.shape[1]):
            theta_i = [theta[0, i], theta[1, i]]
            hat = [hat2(theta_dot[0, 0]), hat2(theta_dot[1, 0])]
            rot = [gm.rot2d(theta_i[0]), gm.rot2d(theta_i[1])]

            vertex_effector_dot[:, [i]] = hat[0] @ rot[0] @ \
                (rot[1]@offset[0]+offset[1]) \
                + rot[0]@hat[1]@rot[1]@offset[0]

        return vertex_effector_dot

# 

import matplotlib.pyplot as plt

import me570_potential as pot


class TwoLink:
    """ See description from previous homework assignments. """
    def jacobian_matrix(self, theta):
        """
        Compute the matrix representation of the Jacobian of the position of the end effector with
    respect to the joint angles as derived in Question~ q:jacobian-matrix.
        """
        pass  # Substitute with your code
        return j_theta

    def animate(self, theta):
        """
        Draw the two-link manipulator for each column in theta with a small pause between each drawing operation
        """
        theta_steps = theta.shape[1]
        for i_theta in range(0, theta_steps, 15):
            self.plot(theta[:, [i_theta]], 'k')


class TwoLinkPotential:
    """ Combines attractive and repulsive potentials """
    def __init__(self, world, potential):
        """
        Save the arguments to internal attributes
        """
        pass  # Substitute with your code

    def eval(self, theta_eval):
        """
        Compute the potential U pulled back through the kinematic map of the two-link manipulator,
        i.e., U(Wp_eff(theta)), where U is defined as in Question~q:total-potential, and
        Wp_ eff(theta) is the position of the end effector in the world frame as a function of the joint angles   = _1\\ _2.
        """
        pass  # Substitute with your code
        return u_eval_theta

    def grad(self, theta_eval):
        """
        Compute the gradient of the potential U pulled back through the kinematic map of the
        two-link manipulator, i.e., grad U(  Wp_ eff(  )).
        """
        pass  # Substitute with your code
        return grad_u_eval_theta

    def run_plot(self, epsilon, nb_steps):
        """
        This function performs the same steps as Planner.run_plot in
        Question~q:potentialPlannerTest, except for the following:
     - In step  it:grad-handle:  planner_parameters['U'] should be set to  @twolink_total, and
    planner_parameters['control'] to the negative of  @twolink_totalGrad.
     - In step  it:grad-handle: Use the contents of the variable  thetaStart instead of  xStart to
    initialize the planner, and use only the second goal  x_goal[:,1].
     - In step  it:plot-plan: Use Twolink.plotAnimate to plot a decimated version of the results of
    the planner. Note that the output  xPath from Potential.planner will really contain a sequence
    of join angles, rather than a sequence of 2-D points. Plot only every 5th or 10th column of
    xPath (e.g., use  xPath(:,1:5:end)). To avoid clutter, plot a different figure for each start.
        """
        sphere_world = pot.SphereWorld()

        nb_starts = sphere_world.theta_start.shape[1]

        planner = pot.Planner(function=self.eval,
                              control=self.grad,
                              epsilon=epsilon,
                              nb_steps=nb_steps)

        two_link = TwoLink()

        for start in range(0, nb_starts):
            # Run the planner
            theta_start = sphere_world.theta_start[:, [start]]
            theta_path, u_path = planner.run(theta_start)

            # Plots
            _, axes = plt.subplots(ncols=2)
            axes[0].set_aspect('equal', adjustable='box')
            plt.sca(axes[0])
            sphere_world.plot()
            two_link.animate(theta_path)
            axes[1].plot(u_path.T)
