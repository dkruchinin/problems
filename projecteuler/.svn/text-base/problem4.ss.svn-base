;; A palindromic number reads the same both ways. 
;; The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
;; Find the largest palindrome made from the product of two 3-digit numbers.

(define (number-reverse num)
  (string->number (list->string (reverse (string->list (number->string num))))))
 
(define (palindrom? num)
  (= num (number-reverse num)))
 
(define (find-palindroms from to)
  (letrec ((rec
            (lambda (x y lst)
              (cond ((= x to)
                     (reverse lst))
                    ((= y to)
                     (rec (+ x 1) from lst))
                    ((palindrom? (* x y))
                     (rec x (+ y 1) (cons (* x y) lst)))
                    (else
                     (rec x (+ y 1) lst))))))
    (rec from from '())))
 
(time (apply max (find-palindroms 111 999)))