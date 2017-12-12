#!/usr/bin/python

import re
from collections import deque


def count_groups(stream):
    total = 0
    left_parens = deque()
    for i in stream:
        if i == '{':
            left_parens.append('{')
        else:
            total += len(left_parens)
            left_parens.pop()
    return total


def remove_garbage(stream):
    without_bang = re.sub('!.', '', stream)
    without_garbage = re.sub('<[^>]*>', '', without_bang)
    return ''.join(c for c in without_garbage if c in '{}')


def process_stream(lines):
    total = 0
    for line in lines:
        total += count_groups(remove_garbage(line))
    return total


def count_garbage(stream):
    without_bang = re.sub('!.', '', stream)
    return sum([len(match) - 2 for match in re.findall('<[^>]*>', without_bang)])


def process_stream2(lines):
    total = 0
    for line in lines:
        total += count_garbage(line)
    return total


with open('day9_input.txt', 'r') as f:
    print(process_stream2(f.read().splitlines()))
