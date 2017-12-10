#!/usr/bin/python

from collections import defaultdict


def parse_instructions(lines):
    register = defaultdict(int)
    for line in lines:
        (command, condition) = line.split('if')
        condition_tokens = condition.split()
        if eval("register['" + condition_tokens[0] + "']" + ''.join(condition_tokens[1:])):
            command_tokens = command.split()
            if command_tokens[1] == 'inc':
                command_tokens[1] = '+'
            else:
                command_tokens[1] = '-'
            register[command_tokens[0]] = eval(
                "register['" + command_tokens[0] + "']" + ''.join(command_tokens[1:]))
    return max(register.values())


def parse_instructions2(lines):
    max_value = 0
    register = defaultdict(int)
    for line in lines:
        (command, condition) = line.split('if')
        condition_tokens = condition.split()
        if eval("register['" + condition_tokens[0] + "']" + ''.join(condition_tokens[1:])):
            command_tokens = command.split()
            if command_tokens[1] == 'inc':
                command_tokens[1] = '+'
            else:
                command_tokens[1] = '-'
            register[command_tokens[0]] = eval(
                "register['" + command_tokens[0] + "']" + ''.join(command_tokens[1:]))
            current_max = max(register.values())
            if current_max > max_value:
                max_value = current_max
    return max_value


with open('day8_input.txt', 'r') as f:
    print(parse_instructions2(f.read().splitlines()))
