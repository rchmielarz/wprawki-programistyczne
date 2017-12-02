#!/usr/bin/python


def corruption_checksum(input):
    sum = 0
    for line in [line.split('\t') for line in input.splitlines()]:
        numbers = [int(number) for number in line]
        sum += abs(max(numbers) - min(numbers))
    return sum


with open('day2_input.txt', 'r') as f:
    print(corruption_checksum(f.read()))
