;; The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
;; Find the sum of all the primes below two million.

(defun sum-of-primes (lim)
  (let ((primes (make-array (- lim 1) :element-type 'bit :initial-element 1)))
    (do ((p 0 (1+ p)))
        ((= p (- lim 1)))
      (when (= (bit primes p) 1)
        (loop for i = (+ (* p 2) 2) then (+ i p 2)
              while (< i (- lim 1)) do (setf (sbit primes i) 0))))
    (print "here")
    (loop for i from 0 to (- lim 2)
          when (= (bit primes i) 1) sum (+ i 2))))