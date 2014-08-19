#!/usr/bin/env python3

from functools import reduce


def cartesian(lists):
    l = len(lists)
    if l == 0:
        return [[]]
    else:
        return [tuple(list(i) + [j]) for i in cartesian(lists[1:])
                for j in lists[0]]

def find_primes(lim):
    primes = []

    for i in range(3, lim, 2):
        is_prime = True
        for j in primes:
            if i % j == 0:
                is_prime = False
                break

        if is_prime:
            primes.append(i)

    return [2] + primes


def factorize(num, primes):
    factors = []
    for p in primes:
        if p > num / 2:
            break

        item = [p, 0]
        while num % p == 0:
            item[1] += 1
            p *= item[0]
        if item[1] != 0:
            factors.append(tuple(item))

    return factors


def get_divisors(num, primes):
    factors = cartesian([tuple([f[0] ** i for i in range(0, f[1] + 1)]) for f in factorize(num, primes)])
    if len(factors) > 1:
        divisors = [reduce(lambda a,b: a*b, lst) for lst in factors]
    else:
        divisors = factors[0]

    return [i for i in divisors if i < num]

def find_abundants(lim):
    primes = find_primes(lim)
    abundants = [12]

    for i in range(13, lim):
        divisors = get_divisors(i, primes)
        if sum(divisors) > i:
            abundants.append(i)

    return abundants


def main():
    abundants = find_abundants(28123)
    ab_sums = sorted(list(set([-1] + [i + j for i in abundants for j in abundants
                                      if i + j < 28123])))
    print(sum([sum(range(ab_sums[i] + 1, ab_sums[i + 1])) for i in range(0, len(ab_sums) - 1)]))

if __name__ == '__main__':
    main()