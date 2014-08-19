#!/usr/bin/env python3

from math import sqrt
from time import time


def get_pentagonal(i):
    return i * (3 * i - 1) // 2


def is_pentagonal(num):
    res = (1 + sqrt(1 + 24 * num)) / 6
    return res == int(res)


if __name__ == '__main__':
    found = False
    i = 2
    start = time()
    while not found:
        p_i = get_pentagonal(i)
        j = i - 1
        while j > 0:
            p_j = get_pentagonal(j)
            if is_pentagonal(p_i - p_j) and is_pentagonal(p_i + p_j):
                print("P_i, P_j:", (p_i, p_j))
                print("D =", p_i - p_j)
                found = True
                break
            j -= 1
        i += 1
    print("Execution time:", time() - start)