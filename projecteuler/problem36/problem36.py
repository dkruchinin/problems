#!/usr/bin/env python


def is_palindrome(string):
    left = 0
    right = len(string) - 1

    while left < right:
        if string[left] != string[right]:
            return False

        left += 1
        right -= 1

    return True


def to_bin(num):
    binstr = ""
    while True:
        binstr += str(num % 2)
        num //= 2
        if num == 0:
            break

    return binstr


def find_palindrome_numbers(limit):
    return [i for i in range(1, limit)
            if (is_palindrome(str(i)) and is_palindrome(to_bin(i)))]


if __name__ == '__main__':
    print(sum(find_palindrome_numbers(1000000)))
