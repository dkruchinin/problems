#!/usr/bin/python
# n! means n × (n − 1) × ... × 3 × 2 × 1
# Find the sum of the digits in the number 100!


sod = 0
for i in str(reduce(lambda x, y: x * y, range(1, 101))): sod += int(i)
print sod
