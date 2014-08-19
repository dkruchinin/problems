#!/usr/bin/env python3


def is_fifthp_dig(dig):
    return dig == sum([int(i) ** 5 for i in str(dig)])


def main():
    print(sum([i for i in range(100, 1000000) if is_fifthp_dig(i)]))


if __name__ == '__main__':
    main()
