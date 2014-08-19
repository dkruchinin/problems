#!/usr/bin/env python3

from math import sqrt


def is_triangular(num):
    res = (1 + sqrt(1 + 8 * num)) / 2
    return res == int(res)


def is_pentagonal(num):
    res = (1 + sqrt(1 + 24 * num)) / 6
    return res == int(res)


if __name__ == '__main__':
    found = False
    h = 144
    while not found:
        num = h * (2 * h - 1)
        if is_pentagonal(num) and is_triangular(num):
            print("Answer:", num)
            break

        h += 1
