#!/usr/bin/env python


def diagonals(spsize):
    topright = spsize ** 2
    return [topright - (spsize - 1) * i for i in range(0, 4)]


def main(spsize):
    print (sum([sum(diagonals(sz)) for sz in range(3, spsize + 1, 2)]) + 1)


if __name__ == '__main__':
    main(1001)
