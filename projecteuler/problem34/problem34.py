#!/usr/bin/env python3

from math import factorial


def factorials_sum(num, factorials):
    if num in factorials:
        return factorials[num]

    factorials[num] = factorials[num % 10] + factorials_sum(num // 10, factorials)
    return factorials[num]


def get_all_factorions():
    factorials = {i: factorial(i) for i in range(0, 10)}
    factorions = []
    for i in range(11, 2540161):
        if factorials_sum(i, factorials) == i:
            factorions.append(i)

    return factorions


if __name__ == '__main__':
    print(sum(get_all_factorions()))