#!/usr/bin/python3


def nth_triag(n):
    return int(0.5 * n * (n + 1))


def word_rank(word):
    return sum([ord(c) - ord('A') + 1 for c in word])


def main(fname):
    triag_nums = [nth_triag(i) for i in range(1, 2000)]
    ntriag_words = 0

    text = open(fname).readlines()[0]
    for word in text.split(","):
        if word_rank(word[1:-1]) in triag_nums:
            ntriag_words += 1

    print("Number of triag words is", ntriag_words)

if __name__ == '__main__':
    main("words.txt")
