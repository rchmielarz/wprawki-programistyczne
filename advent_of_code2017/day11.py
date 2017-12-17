#!/usr/bin/python

import operator

dir_to_coord = {'n': [0, 1, -1],
                'ne': [1, 0, -1],
                'se': [1, -1, 0],
                's': [0, -1, 1],
                'sw': [-1, 0, 1],
                'nw': [-1, 1, 0]}


def go_to_cube(directions):
    start = (0, 0, 0)
    for direction in directions:
        start = list(map(operator.add, start, dir_to_coord[direction]))
    return start


def cube_distance(coordinate):
    return sum([abs(x) for x in coordinate]) / 2


def furthest_cube_distance(directions):
    start = (0, 0, 0)
    distance = 0
    for direction in directions:
        start = list(map(operator.add, start, dir_to_coord[direction]))
        distance = max(distance, cube_distance(start))
    return distance


with open('day11_input.txt', 'r') as f:
    print(furthest_cube_distance(f.read().strip().split(',')))
