#!/usr/bin/python


def corruption_checksum(input):
    sum = 0
    for line in input:
        numbers = [int(number) for number in line]
        sum += abs(max(numbers) - min(numbers))
    return sum


def even_division(numbers):
    for i in range(0, len(numbers)):
        for j in range(i + 1, len(numbers)):
            if numbers[i] % numbers[j] == 0:
                yield int(numbers[i] / numbers[j])
            elif numbers[j] % numbers[i] == 0:
                yield int(numbers[j] / numbers[i])


def produce_numbers(lines):
    for line in lines:
        yield [int(number) for number in line]


def corruption_checksum2(input):
    return sum([list(even_division(numbers))[0] for numbers in produce_numbers(input)])


with open('day2_input.txt', 'r') as f:
    print(corruption_checksum2([line.split('\t')
                                for line in f.read().splitlines()]))
