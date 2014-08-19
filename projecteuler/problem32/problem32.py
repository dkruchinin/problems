#!/usr/bin/env python3

from math import log10

def combinations(seq, sz):

    def allcombs(rest, n, comb, combs):
        if n == 0:
            combs.append(comb)
            return

        for i in range(0, len(rest)):
            allcombs(rest[:i] + rest[i+1:], n - 1, comb + rest[i], combs)

    combs = []
    allcombs(seq, sz, "", combs)
    return combs


def panmult():
    pattern = sum(range(1, 10))
    seq = "123456789"

    def countmults(left, rest, products):
        if len(left) >= 3:
            return

        if len(left) > 0:
            a = int(left)
            for comb in combinations(rest, 5 - len(left)):
                mult = a * int(comb)
                if sorted(str(mult) + left + comb) != sorted(seq):
                    continue
                products.append(mult)

        for i in range(0, len(rest)):
            countmults(left + rest[i], rest[:i] + rest[i+1:], products)

    products = []
    countmults("", seq, products)
    return sum(set(products))

if __name__ == '__main__':
    print(panmult())