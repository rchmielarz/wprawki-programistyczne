#!/usr/bin/python


def walk_instructions(instructions):
    counter = 0
    current_instruction_index = 0
    while current_instruction_index >= 0 and current_instruction_index < len(instructions):
        jump = instructions[current_instruction_index]
        instructions[current_instruction_index] += 1
        current_instruction_index += jump
        counter += 1
    return counter


def walk_instructions2(instructions):
    counter = 0
    current_instruction_index = 0
    while current_instruction_index >= 0 and current_instruction_index < len(instructions):
        jump = instructions[current_instruction_index]
        if jump >= 3:
            instructions[current_instruction_index] += -1
        else:
            instructions[current_instruction_index] += 1
        current_instruction_index += jump
        counter += 1
    return counter


with open('day5_input.txt', 'r') as f:
    print(walk_instructions2([int(number)
                              for number in f.read().splitlines()]))
