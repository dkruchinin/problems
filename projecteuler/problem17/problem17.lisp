(defun number-to-words (number)
  (format nil "~R" number))

(defun gen-numwords-list (start end step &optional (numwords '()))
  (if (>= end start)
      (gen-numwords-list
       start (- end step) step
       (cons (number-to-words end) numwords))
      numwords))

(defun count-letters (words-list)
  (reduce #'+ (mapcar
               #'(lambda (x)
                   (length (remove #\Space (remove #\- x))))
                      words-list)))
  
(defun problem17 (number)
  (let ((l (count-letters (gen-numwords-list 1 number 1)))
        (and-length 3)
        (base (floor (/ number 100))))
    (+ l
       (if (>= base 2) (* (- base 1) and-length 99) 0)
       (if (> base 0) (* (- number (* base 100)) and-length) 0))))
