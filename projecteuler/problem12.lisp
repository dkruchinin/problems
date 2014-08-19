(defconstant NUM-FACTORS 500)

(defun square (x)
  (* x x))

(defun tn (x)
  (/ (+ (square x) x) 2))

(defun get-num-factors (num)
  (let ((nf 2)
        (lim (/ num 2)))
    (loop  for i = 2 then (+ i 1) while (<= i lim)
         when (= (mod num i) 0)
         do (incf nf))
    nf))

(let ((tnum 2)
      (x 2)
      (factors 0))
  (loop do (setf factors (get-num-factors x))
     while (< factors NUM-FACTORS)       
       do (incf tnum)
          (setf x (tn tnum)))
  (format t "~%Triangle number with ~D(>= ~D) factors is ~D(~D)~%"
          factors NUM-FACTORS tnum x))
