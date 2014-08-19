;; By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, 
;; we can see that the 6th prime is 13.
;; What is the 10001st prime number?

(defun is-prime (num lp)
  (labels ((rec (n lst)
                (cond ((or
                       (null lst)
                       (> (car lst) n))
                       t)
                      ((= (mod num (car lst)) 0)
                       nil)
                      (t
                       (rec n (cdr lst))))))
    (rec (floor (sqrt num)) lp)))

(defun get-list-of-primes (lim)
  (do ((i 5 (+ i 2))
       (j 2)
       (lp '(2 3)))
      ((>= j lim) lp)
    (when (is-prime i lp)
      (setf lp (append lp (cons i nil)))
      (incf j))))

(time (last (get-list-of-primes 10001)))