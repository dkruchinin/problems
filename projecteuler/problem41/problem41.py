#!/usr/bin/env python3

from math import sqrt


def is_pandigital(num):
    digs = [0 for i in range(0, 9)]
    numstr = str(num)

    for i in numstr:
        n = int(i) - 1
        if n < 0:
            return False
        digs[n] += 1
        if digs[n] > 1:
            return False

    for i in range(0, len(numstr)):
        if digs[i] == 0:
            return False

    return True


def list_primes(lim):
    seive = [False] * lim
    seive[0] = seive[1] = True
    primes = []

    for i in range(2, lim):
        if seive[i]:
            continue

        for j in range(2, lim // i):
            seive[i * j] = True

        primes.append(i)

    return primes

def is_prime(num):
    if num <= 1:
        return False
    if num % 2 == 0:
        return False
    for i in range(3, int(sqrt(num)) + 1, 2):
        if num % i == 0:
            return False
    return True

if __name__ == '__main__':
    for i in range(7654321, 4231, -1):
        if not is_pandigital(i):
            continue

        if is_prime(i):
            print("Greatest pandigital prime is", i)
            break
