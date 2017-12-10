#!/usr/bin/python

import re
import collections


def find_root(lines):
    candidates = set()
    eliminated = set()
    pattern = re.compile('([a-z]+)')
    for line in lines:
        match = pattern.findall(line)
        candidates.add(str(match[0]))
        for element in match[1:]:
            eliminated.add(str(element))

    return candidates - eliminated


Disk = collections.namedtuple(
    'Disk', ['weight', 'children'])


def create_dictionary(lines):
    tree = collections.defaultdict(list)
    pattern = re.compile('([a-z]+|[0-9]+)')
    for line in lines:
        match = pattern.findall(line)
        tree[str(match[0])] = Disk(weight=int(match[1]), children=match[2:])
    return tree


def fill_children_weight(parent, tree):
    if len(tree[parent].children) == 0:
        return tree[parent].weight

    children = collections.defaultdict(list)
    for child in tree[parent].children:
        children[fill_children_weight(child, tree)].append(child)

    children_weight = sum([child[0] * len(child[1])
                           for child in children.items()])

    outlier = ''
    outlier_weight = 0
    normal_weight = 0
    for child in children:
        if len(children[child]) == 1:
            outlier = children[child][0]
            outlier_weight = child
        else:
            normal_weight = child

    if outlier:
        weight_difference = normal_weight - outlier_weight
        print(outlier + ' is an outlier. It should weight ' +
              str(tree[outlier].weight + weight_difference))

    return tree[parent].weight + children_weight


def find_outlier(lines):
    tree = create_dictionary(lines)
    fill_children_weight(list(find_root(lines))[0], tree)


with open('day7_input.txt', 'r') as f:
    find_outlier(f.read().splitlines())
