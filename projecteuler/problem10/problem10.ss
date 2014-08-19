;; The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
;; Find the sum of all the primes below two million.

(define (prime? num)
  (letrec ((rec 
            (lambda (i lim)
              (if (> i lim)
                  #t
                  (if (= (modulo num i) 0)
                      #f
                      (rec (+ i 1) lim))))))
    (rec 2 (floor (sqrt num)))))

(define (sum-of-primes start end)
  (letrec ((rec
            (lambda (num sum)
              (if (= num end)
                  sum
                  (rec (+ num 1) (if (prime? num) 
                                     (+ sum num)
                                     sum))))))
    (rec start 0)))