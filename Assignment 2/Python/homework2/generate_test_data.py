#!/usr/bin/env python
"""
GenerateautogradertestdataforHomework1"""

import os
import pickle
import sys

import numpy as np
import typer
from scipy import io as scio

import me570_geometry as geometry
import me570_robot as robot

app = typer.Typer()

sys.path.insert(0, '../common')

import test_data

DIR_AUTOGRADER = '../../pythonAutograders/homework2'


@app.command()
def torus_phi():
    """
    Torusphionrandompoints    """
    torus = geometry.Torus()
    inputs = [[
        2 * np.pi * np.random.rand(2, 1),
    ] for count in range(10)]
    test_data.generate_save_pairs_object(DIR_AUTOGRADER,
                                         torus,
                                         geometry.Torus.phi,
                                         inputs,
                                         file_name='Torus.phi')


@app.command()
def torus_phi_push_curve():
    """
    Torusphi_push_curveonrandompoints    """
    torus = geometry.Torus()
    inputs = [[np.random.randn(2, 1),
               np.random.randn(2, 1)] for count in range(10)]
    test_data.generate_save_pairs_object(DIR_AUTOGRADER,
                                         torus,
                                         geometry.Torus.phi_push_curve,
                                         inputs,
                                         file_name='Torus.phi_push_curve')


@app.command()
def twolink_kinematic_map():
    """
    TwoLinkkinematic_maponrandompoints    """
    twolink = robot.TwoLink()
    inputs = [[
        np.random.randn(2, 1),
    ] for count in range(10)]
    test_data.generate_save_pairs_object(DIR_AUTOGRADER,
                                         twolink,
                                         robot.TwoLink.kinematic_map,
                                         inputs,
                                         file_name='TwoLink.kinematic_map')


@app.command()
def twolink_kinematic_map():
    """
    TwoLinkkinematic_maponrandompoints    """
    twolink = robot.TwoLink()
    inputs = [[
        np.random.randn(2, 1),
    ] for count in range(10)]
    test_data.generate_save_pairs_object(DIR_AUTOGRADER,
                                         twolink,
                                         robot.TwoLink.kinematic_map,
                                         inputs,
                                         file_name='TwoLink.kinematic_map')


@app.command()
def twolink_is_collision():
    """
    TwoLinkis_collisiononrandompoints    """
    twolink = robot.TwoLink()
    obstacle_points = scio.loadmat('twolink_testData.mat')['obstaclePoints']

    inputs = [[np.random.randn(2, 1), obstacle_points] for count in range(15)]
    test_data.generate_save_pairs_object(DIR_AUTOGRADER,
                                         twolink,
                                         robot.TwoLink.is_collision,
                                         inputs,
                                         file_name='TwoLink.is_collision')


@app.command()
def twolink_jacobian():
    """
    TwoLinkjacobianonrandompoints    """
    twolink = robot.TwoLink()
    inputs = [[np.random.randn(2, 1),
               np.random.randn(2, 1)] for count in range(10)]
    test_data.generate_save_pairs_object(DIR_AUTOGRADER,
                                         twolink,
                                         robot.TwoLink.jacobian,
                                         inputs,
                                         file_name='TwoLink.jacobian')


if __name__ == '__main__':
    app()

# 
