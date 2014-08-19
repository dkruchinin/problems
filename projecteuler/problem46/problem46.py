#!/usr/bin/env python3

from math import sqrt


def is_prime(n, primes):
    for i in primes:
        if n % i == 0:
            return False
    return True


def goldbach_conj_holds(n, primes):
    for p in primes:
        diff = n - p
        i = 1
        while True:
            test = 2 * i ** 2
            if test > diff:
                break
            elif test == diff:
                return True

            i += 1

    return False

if __name__ == '__main__':
    primes = [2, 3, 5, 7]
    i = 9
    while True:
        if is_prime(i, primes):
            primes.append(i)
        elif not goldbach_conj_holds(i, primes):
            print(i)
            break

        i += 2