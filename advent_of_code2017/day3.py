#!/usr/bin/python

directions = [(1, 0), (0, 1), (-1, 0), (0, -1)]


def calculate_position(n):
    position = [0, 0]
    current_direction_index = 0
    direction_repetitions = 1
    current_repetitions = 1
    while n > 1:
        position[0] += directions[current_direction_index][0]
        position[1] += directions[current_direction_index][1]
        n -= 1

        current_repetitions -= 1
        if current_repetitions == 0:
            if current_direction_index == 3:
                current_direction_index = 0
            else:
                current_direction_index += 1

            if current_direction_index in (0, 2):
                direction_repetitions += 1

            current_repetitions = direction_repetitions

    return position


def neighbours(point):
    return [(point[0] - 1, point[1]),
            (point[0] - 1, point[1] - 1),
            (point[0] - 1, point[1] + 1),
            (point[0], point[1] - 1),
            (point[0], point[1] + 1),
            (point[0] + 1, point[1]),
            (point[0] + 1, point[1] - 1),
            (point[0] + 1, point[1] + 1)]


def get_neighbours_values(point, grid):
    sum = 0
    for neighbour in neighbours(point):
        if neighbour in grid:
            sum += grid[(neighbour[0], neighbour[1])]
    return sum


def spiral_memory2(n):
    position = [0, 0]
    current_direction_index = 0
    direction_repetitions = 1
    current_repetitions = 1
    grid = {(0, 0): 1}
    while n >= grid[(position[0], position[1])]:
        position[0] += directions[current_direction_index][0]
        position[1] += directions[current_direction_index][1]
        grid[(position[0], position[1])] = get_neighbours_values(position, grid)
        current_repetitions -= 1
        if current_repetitions == 0:
            if current_direction_index == 3:
                current_direction_index = 0
            else:
                current_direction_index += 1

            if current_direction_index in (0, 2):
                direction_repetitions += 1

            current_repetitions = direction_repetitions

    return grid[(position[0], position[1])]


def spiral_memory(n):
    position = calculate_position(n)
    return abs(position[0]) + abs(position[1])
