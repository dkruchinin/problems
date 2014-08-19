#!/usr/bin/python
# In the 2020 grid below, four numbers along a diagonal line have been marked in red.
# The product of these numbers is 26  63  78  14 = 1788696.
# What is the greatest product of four adjacent numbers in any 
# direction (up, down, left, right, or diagonally) in the 2020 grid?

from math import sqrt

# note: this task can be easily solved using multiple arrays or an array of strings
# but it's not very interisting. I decided to make an experiment with one-dimensional
# array. It's more fun (::

GRID = [  8,  2, 22, 97, 38, 15,  0, 40,  0, 75,  4,  5,  7, 78, 52, 12, 50, 77, 91,  8, 
         49, 49, 99, 40, 17, 81, 18, 57, 60, 87, 17, 40, 98, 43, 69, 48,  4, 56, 62,  0, 
         81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30,  3, 49, 13, 36, 65, 
         52, 70, 95, 23,  4, 60, 11, 42, 69, 24, 68, 56,  1, 32, 56, 71, 37,  2, 36, 91, 
         22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80, 
         24, 47, 32, 60, 99,  3, 45,  2, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50, 
         32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70, 
         67, 26, 20, 68,  2, 62, 12, 20, 95, 63, 94, 39, 63,  8, 40, 91, 66, 49, 94, 21, 
         24, 55, 58,  5, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72, 
         21, 36, 23,  9, 75,  0, 76, 44, 20, 45, 35, 14,  0, 61, 33, 97, 34, 31, 33, 95, 
         78, 17, 53, 28, 22, 75, 31, 67, 15, 94,  3, 80,  4, 62, 16, 14,  9, 53, 56, 92, 
         16, 39,  5, 42, 96, 35, 31, 47, 55, 58, 88, 24,  0, 17, 54, 24, 36, 29, 85, 57, 
         86, 56,  0, 48, 35, 71, 89,  7,  5, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58, 
         19, 80, 81, 68,  5, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77,  4, 89, 55, 40, 
          4, 52,  8, 83, 97, 35, 99, 16,  7, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66, 
         88, 36, 68, 87, 57, 62, 20, 72,  3, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69, 
          4, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18,  8, 46, 29, 32, 40, 62, 76, 36, 
         20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74,  4, 36, 16, 
         20, 73, 35, 29, 78, 31, 90,  1, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57,  5, 54, 
          1, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52,  1, 89, 19, 67, 48 ]
LINEW = 4

def find_max_in_lines(line1, line2):
    maxval = 0
    i = 0
    llen = len(line1) - LINEW
    f = lambda x, y: x * y
        
    while i < llen:
        t1 = reduce(f, line1[i + 1:i + LINEW])
        t2 = reduce(f, line2[i + 1:i + LINEW])
        maxval = max(t1 * line1[i], t2 * line2[i], maxval)
        if (i - llen > 0):
            maxval = max(t1 * line1[i + LINEW + 1], t2 * line2[i + LINEW + 1], maxval)
            i += 1
            
        i += 1

    return maxval

def rowcol_max(line_len):
    lim = len(GRID)
    i, j = 0, 0
    maxval = 0
    inc = 1

    while i < lim:
        maxval = max(find_max_in_lines(GRID[i:i + line_len], \
                                           [ GRID[k] for k in xrange(j, j + lim - line_len + 1, line_len) ]), maxval)
        i += line_len
        j += inc

    return maxval

def diags_max(line_len):
    glen = len(GRID)
    d1p, d2p = (LINEW - 1), (line_len - LINEW)
    d3p, d4p = (glen - LINEW), (glen - line_len + LINEW - 1)
    llen = LINEW
    maxval = 0
    
    while d1p < line_len:
        l1, l2, l3, l4 = [], [], [], []
        j = 0
        for i in xrange(0, line_len * llen, line_len):
            l1.append(GRID[d1p + i - j])
            l2.append(GRID[d2p + i + j])        
            l3.append(GRID[d3p - i + j])
            l4.append(GRID[d4p - i - j])
            j += 1

        maxval = max(find_max_in_lines(l1, l2), maxval)
        if (d1p + 1) != line_len:
            maxval = max(find_max_in_lines(l3, l4), maxval)
        d1p += 1
        d2p -= 1
        d3p -= 1
        d4p += 1
        llen += 1

    return maxval

def main():
    max_item = 0
    line_len = int(sqrt(len(GRID))) 

    print "MAX = %s" % max(rowcol_max(line_len), diags_max(line_len))

if __name__ == "__main__":
    main()
