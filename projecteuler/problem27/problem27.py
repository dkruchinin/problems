#!/usr/bin/env python3

from math import sqrt
from itertools import product


def is_prime(num):
    for i in range(2, int(sqrt(num))):
        if num % i == 0:
            return False
    return True


def list_primes(a, b):
    primes = []
    for n in range(0, abs(b)):
        if n > 0 and (n % b == 0):
            break

        num = abs(n ** 2 + a * n + b)
        if not is_prime(num):
            break

        primes.append(num)

    return primes

def main():
    bvals = [i for i in range(41, 1001, 2) if is_prime(i)]

    longest_seq = 0
    aval = bval = None
    for b in bvals:
        for a in [i for i in range(1, 1001) if i % b != 0]:
            for pair in product((a, -a), (b, -b)):
                primes = list_primes(pair[0], pair[1])
                if len(primes) > longest_seq:
                    longest_seq = len(primes)
                    aval = pair[0]
                    bval = pair[1]

    print("Longest sequence: %d, A: %d, B: %d" %
          (longest_seq, aval, bval))


if __name__ == '__main__':
    main()
