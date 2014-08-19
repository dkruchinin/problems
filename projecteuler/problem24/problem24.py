#!/usr/bin/env python3

import sys
from math import factorial

def permutations(seq):
    if len(seq) == 1:
        return [seq]

    perms = []
    for i in range(0, len(seq)):
        subarray = seq[:i] + seq[i+1:]
        for p in permutations(subarray):
            perms.append([seq[i]] + p)

    return perms


def permutations_iter(seq):
    stack = [(0, seq)]
    perm = []

    while len(stack) > 0:
        (idx, subseq) = stack.pop()
        if idx == len(subseq):
            perm = perm[:-1]
            continue

        if len(subseq) == 1:
            yield perm + subseq
            perm.pop()
            continue

        perm.append(subseq[idx])
        nextidx = idx + 1
        stack.append((nextidx, subseq))

        stack.append((0, subseq[:idx] + subseq[nextidx:]))


def nth_permutation(seq, n):
    perm = []
    idxs = list(range(0, len(seq)))
    for i in range(len(seq) - 1, 0, -1):
        nperms = factorial(i)
        for j in range(0, len(idxs)):
            p = j + 1
            if nperms * p >= n:
                n -= nperms * j
                perm.append(seq[idxs[j]])
                del idxs[j]
                break

    return perm + [seq[i] for i in idxs]

def main(seq, type):
    if type == "iter":
        g = permutations_iter(seq)
        for i in range(1, 1000000):
            next(g)

        res = next(g)
    elif type == "nth":
        res = nth_permutation(seq, 1000000)
    else:
        res = permutations(seq)[999999]

    print("".join([str(i) for i in res]))


if __name__ == '__main__':
    if len(sys.argv) != 2 or sys.argv[1] not in ("rec", "iter", "nth"):
        print("Usage: %s <rec|iter|nth>" % sys.argv[0])
        sys.exit(1)

    main([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], sys.argv[1])
