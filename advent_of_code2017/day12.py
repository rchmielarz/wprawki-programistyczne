#!/usr/bin/python

from collections import defaultdict


def parse_pipes(connections):
    pipes = defaultdict(list)
    for connection in connections:
        (fro, to) = connection.split('<->')
        pipes[fro.strip()] = [x.strip() for x in to.split(',')]
    return pipes


def count_connections(connections):
    communication_set = set()
    communication_set.add('0')
    length = len(communication_set)
    while True:
        for connection in connections:
            if connection in communication_set:
                for x in connections[connection]:
                    communication_set.add(x)
        if len(communication_set) == length:
            break
        else:
            length = len(communication_set)
    return communication_set


def create_group(connections, leader):
    communication_set = set()
    communication_set.add(leader)
    length = len(communication_set)
    while True:
        for connection in connections:
            if connection in communication_set:
                for x in connections[connection]:
                    communication_set.add(x)
        if len(communication_set) == length:
            break
        else:
            length = len(communication_set)
    return communication_set


def elect_next_group_leader(groups, connections):
    for connection in connections:
        if all(connection not in group for group in groups):
            return connection
    return ''


def groups_count(connections):
    groups = []
    groups.append(create_group(connections, '0'))
    while elect_next_group_leader(groups, connections) != '':
        groups.append(create_group(connections,
                                   elect_next_group_leader(groups, connections)))
    return len(groups)


with open('day12_input.txt', 'r') as f:
    print(groups_count(parse_pipes(f.read().splitlines())))
