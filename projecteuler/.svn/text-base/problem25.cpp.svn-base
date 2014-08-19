/*
 * Problem №25
 * The Fibonacci sequence is defined by the recurrence relation:
 * Fn = Fn-1 + Fn-2, where F1 = 1 and F2 = 1.
 * Hence the first 12 terms will be:
 * F1 = 1
 * F2 = 1
 * F3 = 2
 * F4 = 3
 * F5 = 5
 * F6 = 8
 * F7 = 13
 * F8 = 21
 * F9 = 34
 * F10 = 55
 * F11 = 89
 * F12 = 144
 * The 12th term, F12, is the first term to contain three digits.
 * Q: What is the first term in the Fibonacci sequence to contain 1000 digits?
 */

#include <iostream>
#include <cstring>
#include <cmath>

const int LIMIT = 1000;
const int BASE = 1000000000;
const int DIGS = 9;
const int ARR_SIZE = LIMIT / DIGS;

static void print_fib(int *fnum)
{
    int active = ARR_SIZE;
    
    while (!fnum[--active]);
    std::cout << fnum[active];
    
    for (int i = active - 1; i >= 0; i--) {
        for (int digs = DIGS - ((int)log10(fnum[i])) - 1; digs > 0; digs--)
            std::cout << 0;

        std::cout << fnum[i];
    }

    std::cout << std::endl;
}

int main(void)
{
    int f_cur[ARR_SIZE], f_prev[ARR_SIZE];
    int item = 0;
    
    memset(f_cur, 0, ARR_SIZE * sizeof(int));
    memset(f_prev, 0, ARR_SIZE * sizeof(int));
    f_prev[0] = 1;
    f_cur[0] = 2;
    for (int i = 3, block = 0;; i++) {
        bool carry = false;
        for (int j = 0, lim = block; (j <= lim) || carry; j++) {            
            int res = f_cur[j] + f_prev[j];
            if (carry) {
                res++;
                carry = false;
                if (!f_cur[j]) {
                    if (++block == ARR_SIZE) {
                        item = i + 1;
                        goto out;
                    }
                }
            }
            f_prev[j] = f_cur[j];
            f_cur[j] = res % BASE;
            if (res >= BASE)
                carry = true;
        }

    }

  out:
    std::cout << "Item #" << item << std::endl;
    print_fib(f_cur);
    return 0;
}
