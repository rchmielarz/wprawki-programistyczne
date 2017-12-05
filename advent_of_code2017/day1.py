#!/usr/bin/python


def inverse_captcha(input):
    extended = input + input[0]
    sum = 0
    for i in range(0, len(extended) - 1):
        if extended[i] == extended[i + 1]:
            sum += int(extended[i])
    return sum


def inverse_captcha2(input):
    half_length = int(len(input) / 2)
    extended = input + input[0:half_length]
    sum = 0
    for i in range(0, len(extended) - half_length):
        if extended[i] == extended[i + half_length]:
            sum += int(extended[i])
    return sum


with open('day1_input.txt', 'r') as f:
    print(inverse_captcha2(f.read().strip()))
