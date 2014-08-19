#!/usr/bin/env python3


def find_cycle(num):
    rems = []
    div = 1
    rem = 0

    while True:
        rem = div % num
        if rem == 0:
            return 0
        if rem in rems:
            return len(rems) - rems.index(rem)

        rems.append(rem)
        div *= 10



def main():
    longest_cycle = 0
    result = -1
    for i in range(1, 1001):
        cycle_len = find_cycle(i)
        if cycle_len > longest_cycle:
            longest_cycle = cycle_len
            result = i

    print("%d gives longest cycle, length %d" %
          (result, longest_cycle))

if __name__ == '__main__':
    main()
