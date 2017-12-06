#!/usr/bin/python


def redistribute_memory(memory):
    value = max(memory)
    index = memory.index(value)
    redistributed = memory.copy()
    redistributed[index] = 0
    while value > 0:
        if index == len(redistributed) - 1:
            index = 0
        else:
            index += 1
        redistributed[index] += 1
        value -= 1
    return redistributed


def memory_reallocation(memory):
    counter = 1
    history = [memory]
    current = redistribute_memory(memory)
    while current not in history:
        history.append(current)
        current = redistribute_memory(current)
        counter += 1
    return counter


def memory_reallocation2(memory):
    history = [memory]
    current = redistribute_memory(memory)
    while current not in history:
        history.append(current)
        current = redistribute_memory(current)
    return len(history) - history.index(current)


with open('day6_input.txt', 'r') as f:
    print(memory_reallocation2([int(number)
                                for number in f.read().strip().split()]))
