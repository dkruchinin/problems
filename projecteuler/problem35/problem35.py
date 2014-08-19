#!/usr/bin/env python3


def rotations(num):
    def do_rotation(n):
        return n[1:] + n[0]

    rots = []
    next = num
    while True:
        r = do_rotation(next)
        if r == num:
            break

        rots.append(r)
        next = r

    return rots


def list_circular_primes(lim):
    is_prime = [True] * lim
    is_prime[0] = is_prime[1] = False
    primes = []

    p = 0
    while True:
        try:
            p = is_prime.index(True, p + 1)
        except ValueError:
            break

        primes.append(p)
        for i in range(2, lim):
            j = p * i
            if j >= lim:
                break

            is_prime[j] = False

    circulars = []
    for p in primes:
        if not is_prime[p]:
            continue

        is_circular = True
        rots = [int(i) for i in rotations(str(p))]
        for n in rots:
            if n >= lim or not is_prime[n]:
                is_circular = False
                break

            is_prime[n] = False

        if is_circular:
            circulars.append(p)
            circulars += rots

    return circulars

if __name__ == '__main__':
    print(len(list_circular_primes(1000000)))