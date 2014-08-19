/*
 * A Pythagorean triplet is a set of three natural numbers, a<b<c, for which,
 * a² + b² = c²
 * For example, 3² + 4² = 9 + 16 = 25 = 5².
 * There exists exactly one Pythagorean triplet for which a + b + c = 1000.
 * Find the product abc.
 *
 */

/**
 * test
 * test
 * @test
 */
#include <stdio.h>

#define TRIPL_SUM 1000
#define square(x) (x * x)

int main(void)
{
    int a, b, c;

    for (c = 3; c < TRIPL_SUM; c++) {
        int sqc = square(c);
        for (b = c - 1; b > 0; b--) {
            int sqb = square(b);
            for (a = b - 1; a > 0; a--) {
                if ((square(a) + sqb == sqc) && (a + b + c == TRIPL_SUM))
                    goto finish;
            }
        }
    }
    
  finish:
    printf("a, b, c = %d, %d, %d\n", a, b, c);
    printf("The product is %d\n", a * b * c);
    return 0;
}
