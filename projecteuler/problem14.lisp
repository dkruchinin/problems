;; problem №14
;; 
;; The following iterative sequence is defined for the set of positive integers:
;; n -> n/2 (n is even)
;; n -> 3n + 1 (n is odd)
;; Using the rule above and starting with 13, we generate the following sequence:
;; 13  40  20  10  5  16  8  4  2  1
;; It can be seen that this sequence (starting at 13 and finishing at 1) 
;; contains 10 terms. Although it has not been proved yet (Collatz Problem), 
;; it is thought that all starting numbers finish at 1.
;; Q: Which starting number, under one million, produces the longest chain?

(defvar *collatz-table* (make-hash-table))

(defun collatz-seq-next (num)
  (if (evenp num)
      (/ num 2) (+ (* 3 num) 1)))

(defun power-of-2p (num)
  (= (logand num (logxor (- num 1))) 0))

(defun collatz-seq-len (num)
  (loop for i = num then (collatz-seq-next i) 
     sum 1 into j
     when (oddp i)
       when (gethash i *collatz-table*) do (return (+ (- j 1) (gethash i *collatz-table*)))
     else 
       when (= i 16) do (return (+ j 4))
       else when (power-of-2p i) do (return (+ j (log i 2)))))     

;; it's not necessary to go through even numbers,
;; so they can be skipped...
(defun collatz-seq-find-max (lim)
  (let ((ret (loop for i = 3 then (+ i 2)
                with j = 0
                with tmp = (cons 0 0)
                while (< i (if (oddp lim) (+ lim 1) lim))
                 do 
                   (setf j (collatz-seq-len i))
                   (setf (gethash i *collatz-table*) j)
                   (when (> j (cdr tmp)) 
                     (setf tmp (cons i j)))
                 finally (return tmp))))
    (loop for i = (* (car ret) 2) then (* i 2) while (<= i lim)
       do (setf ret (cons i (+ (cdr ret) 1))))
    ret))