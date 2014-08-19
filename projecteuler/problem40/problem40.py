#!/usr/bin/env python3

from functools import reduce

# get total number of digits that can be
# produced by all n-digit numbers, in other words
#   nsyms(n) - a number of digits produced by numbers in
#              range [10^(n-1), 10^n)
def nsyms(n):
    return 10 ** (n - 1) * 9 * n


def get_nth_digit(d):
    baseidx = 1
    n = 1

    # Find suitable baseidx and n values
    # Where n is a number of digits in d
    # and baseidx is the closest to d sum of
    # nsyms(1) .. nsyms(n), such that baseidx <= d,
    # in other words the distance to k's number,
    # where k = 10^(n-1)
    while baseidx + nsyms(n) < d:
        baseidx += nsyms(n)
        n += 1

    # Knowing the number of digits in d we can easily find
    # power of 10 closest to d (which is 10^(n-1)), that
    # will be the base. We also know that base's index in the
    # fraction corresponds to baseidx, so we easily can get
    # the actual number that contributes one its digits to
    # the position d. Using a bit of modular arithmetic
    # we can get the exact digit.
    num = 10 ** (n - 1) + (d - baseidx) // n
    return int(str(num)[(d - baseidx) % n])


if __name__ == '__main__':
    print(reduce(lambda a,b: a*b,
                 [get_nth_digit(i) for i in (1, 10, 100, 1000, 10000, 100000, 1000000)]))

