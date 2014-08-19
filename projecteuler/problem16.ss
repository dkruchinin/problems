;; 215 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
;; What is the sum of the digits of the number 21000?

(define (number->list num)
  (letrec ((num-lst
            (lambda (orig nlst)
              (if (= orig 0)
                  nlst
                  (num-lst (quotient orig 10)
                           (cons 
                            (remainder orig 10) nlst))))))
    (num-lst num '())))
 
(apply + (number->list (expt 2 1000)))