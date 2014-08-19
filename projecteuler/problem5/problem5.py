#!/usr/bin/python
# The sum of the squares of the first ten natural numbers is,
# 1² + 2² + ... + 10² = 385
# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)² = 55² = 3025
# Hence the difference between the sum of the squares of the first ten natural 
# numbers and the square of the sum is 3025 − 385 = 2640.
# Find the difference between the sum of the squares of the first one hundred natural 
# numbers and the square of the sum.

if __name__ == "__main__":
    sum_of_squares, sum = 0, 0
    limit = 100
    for i in range(1, limit + 1):
        sum_of_squares += i ** 2
        sum += i
    print "Answer: %s" % (sum ** 2 - sum_of_squares)
