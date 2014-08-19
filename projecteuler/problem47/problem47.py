#!/usr/bin/env python3


def seive(lim):
    primes = []
    seive_nums = [False] * (lim + 1)
    seive_nums[0] = seive_nums[1] = True
    for i in range(2, lim):
        if seive_nums[i]:
            continue

        for j in range(2, lim // i + 1):
            seive_nums[i * j] = True

        primes.append(i)

    return primes


def factorize(num, primes):
    factors = []
    for p in primes:
        if p > num:
            break
        if num % p != 0:
            continue

        f = 1
        while num % p == 0:
            num //= p
            f *= p

        factors.append(f)

    return factors


def main(nfactors):
    primes = seive(144000)
    nfactors = 4
    nums = []
    n = 1
    while True:
        factors = factorize(n, primes)
        if len(factors) != nfactors:
            nums = []
            n += 1
            continue

        nums.append(n)
        if len(nums) == nfactors:
            print(nums)
            break

        n += 1


if __name__ == '__main__':
    main(4)