#!/usr/bin/env python


def count(total, coins):
    table = [0] * (total + 1)
    table[0] = 1

    for c in coins:
        for i in range(c, total + 1):
            table[i] += table[i - c]

    return table[total]


def main():
    coins = [1, 2, 5, 10, 20, 50, 100, 200]
    print(count(200, coins))


if __name__ == '__main__':
    main()