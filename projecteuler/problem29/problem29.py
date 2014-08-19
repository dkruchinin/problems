#!/usr/bin/env python3


def main(lim):
    nums = []
    for b in range(2, lim + 1):
        for a in range(2, lim + 1):
            nums.append(a ** b)

    print(len(set(nums)))


if __name__ == '__main__':
    main(100)