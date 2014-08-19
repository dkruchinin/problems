#!/usr/bin/env python3

from math import sqrt


def is_prime(num):
    if num == 1:
        return False
    for i in range(2, int(sqrt(num) + 1)):
        if num % i == 0:
            return False

    return True


def truncright(num):
    return num // 10


def truncleft(num):
    res = str(num)[1:]
    if len(res) == 0:
        return 0

    return int(res)


def is_truncprime(num, truncfn):
    num = truncfn(num)
    if num == 0:
        return False
    while num > 0:
        if not is_prime(num):
            return False

        num = truncfn(num)

    return True


def list_truncprimes():
    start = [2, 3, 5, 7]
    truncprimes = set()

    while len(truncprimes) < 11:
        tmp = []
        for p in start:
            for i in range(1, 10):
                num = int(str(p) + str(i))
                if is_prime(num):
                    tmp.append(num)

                num = int(str(i) + str(p))
                if is_prime(num):
                    tmp.append(num)

        for p in tmp:
            if is_truncprime(p, truncleft) and is_truncprime(p, truncright):
                truncprimes.add(p)

        start = tmp

    return truncprimes



if __name__ == '__main__':
    print(sum(list_truncprimes()))
