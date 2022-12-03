(defun split-on-pred (split-pred list)
  (reduce (lambda (state next)
            (if (apply split-pred (list next))
                (append (list (list)) state)
                (append (list (cons next (car state))) (cdr state))))
          list
          :initial-value (list (list))))

(defun part-one-solver (input-path)
  (reduce #'max
   (mapcar
    (lambda (elf)
      (reduce #'+ (mapcar #'parse-integer elf)))
    (split-on-pred
     (lambda (x) (equal x ""))
     (uiop:read-file-lines input-path)))))

(defun part-two-solver (input-path)
  (reduce #'+
   (subseq
    (sort (mapcar (lambda (elf)
                    (reduce #'+ (mapcar #'parse-integer elf)))
                  (split-on-pred
                   (lambda (x)
                     (equal x ""))
                   (uiop:read-file-lines input-path)))
          #'>)
    0 3)))
