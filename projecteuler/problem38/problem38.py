#!/usr/bin/env python3


def is_pandigital(num):
    numstr = str(num)

    for bound in range(1, len(numstr) // 2 + 1):
        n = int(numstr[:bound])
        test_num = ""
        for i in range(1, 10):
            test_num += str(n * i)

            if (len(test_num) > len(numstr)
                or test_num != numstr[:len(test_num)]):
                break
            elif len(test_num) == len(numstr):
                return True

    return False


def permutations(seq):
    def dorec(perm, rest):
        if len(rest) == 0:
            return [perm]

        perms = []
        for i in range(0, len(rest)):
            perms += dorec(perm + rest[i], rest[:i] + rest[i+1:])

        return perms

    return dorec("", seq)

if __name__ == '__main__':
    for perm in permutations("87654321"):
        num = int("9" + perm)
        if is_pandigital(num):
            print("Max pandigital:", num)
            break