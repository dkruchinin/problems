#!/usr/bin/env python3

from math import sqrt


def main():
    lim = 1001
    longest = []
    pval = -1

    for P in range(1, lim):
        vals = []
        for a in range(1, P):
            asquare = a * a
            if a > P - a:
                break
            for b in range(a, P - a):
                csquare = asquare + b * b
                c = sqrt(csquare)
                tmp = a + b + c
                if tmp > P:
                    break
                if a + b + c == P:
                    vals.append((a, b, int(c)))
        if len(vals) > len(longest):
            longest = vals
            pval = P

    print("Longest: %d (%s)" % (len(longest), longest))
    print("P value:", pval)


if __name__ == '__main__':
    main()