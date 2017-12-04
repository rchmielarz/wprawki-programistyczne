#!/usr/bin/python


def is_valid_passphrase(passphrase):
    passphrase_list = passphrase.split()
    return len(passphrase_list) == len(set(passphrase_list))


def is_valid_passphrase2(passphrase):
    passphrase_list = ["".join(sorted(word)) for word in passphrase.split()]
    return len(passphrase_list) == len(set(passphrase_list))


def count_valid_passphrases(input, passphrase_validator):
    sum = 0
    for line in input.splitlines():
        if passphrase_validator(line):
            sum += 1
    return sum


with open('day4_input.txt', 'r') as f:
    print(count_valid_passphrases(f.read(), is_valid_passphrase2))
