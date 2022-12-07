(defun day-6-solver (marker-length input-path)
  (first (reduce (lambda (state next-char)
                   (if (= (length (second state)) marker-length)
                       state
                       (list (+ (first state) 1)
                             (let ((find-index (position next-char (second state))))
                               (if find-index
                                   (append (nthcdr (+ find-index 1) (second state)) (list next-char))
                                   (append (second state) (list next-char)))))))
                 (uiop:read-file-string input-path)
                 :initial-value (list 0 '()))))

(defun part-1-solver (input-path) (day-6-solver 4 input-path))

(defun part-2-solver (input-path) (day-6-solver 14 input-path))
