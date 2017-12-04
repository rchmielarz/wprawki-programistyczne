#!/usr/bin/python


def is_valid_passphrase(passphrase):
    passphrase_list = passphrase.split()
    return len(passphrase_list) == len(set(passphrase_list))


def count_valid_passphrases(input):
    sum = 0
    for line in input.splitlines():
        if is_valid_passphrase(line):
            sum += 1
    return sum


with open('day4_input.txt', 'r') as f:
    print(count_valid_passphrases(f.read()))
