#!/usr/bin/env python3

from functools import reduce

def combinations(seq, n):
    def dorec(subseq, sz, comb):
        if sz == 0:
            return [comb]

        combs = []
        for i in range(0, len(subseq)):
            combs += dorec(subseq, sz - 1, comb + subseq[i])

        return combs

    return dorec(seq, n, "")


def gcd(a, b):
    if b == 0:
        return a
    return gcd(b, a % b)


def fraction(numer, denom):
    comdiv = gcd(numer, denom)
    return list(i / comdiv for i in (numer, denom))


def curious_fractions():
    digseq = "".join([str(j) for j in range(0, 10)])
    numbers = [i for i in combinations(digseq, 2) if int(i) >= 10]
    results = []
    for num in numbers:
        num_val = int(num)
        for j in range(0, 2):
            if j == 0:
                denoms = [i + num[j] for i in digseq]
            else:
                denoms = [num[j] + i for i in digseq]

            for denom in denoms:
                denom_val = int(denom)
                if denom_val < 10 or denom_val <= num_val:
                    continue

                frac = fraction(num_val, denom_val)
                if frac == fraction(int(num[1 - j]), int(denom[j])):
                    results.append((num_val, denom_val))

    return results

if __name__ == '__main__':
    res = reduce(lambda a,b: (a[0] * b[0], a[1] * b[1]),
                 [fraction(i[0], i[1]) for i in curious_fractions()])
    print(fraction(res[0], res[1])[1])

