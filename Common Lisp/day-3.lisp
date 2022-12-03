(defun part-one-solver (input-path)
  (let ((lines (uiop:read-file-lines input-path)))
    (reduce #'+
            (mapcar
             (lambda (line)
               (let ((first-half (subseq line 0 (/ (length line) 2))))
                 (let ((second-half (subseq line (/ (length line) 2))))
                   (let ((common-char (first (intersection (coerce first-half 'list) (coerce second-half 'list)))))
                     (char->priority common-char)))))
             lines))))

(defun chunk (chunk-size list)
  (reduce (lambda (state next)
            (if (= (length (car state)) chunk-size)
                (append (list (list next)) state)
                (append (list (cons next (car state))) (cdr state))))
          list
          :initial-value (list (list))))

(defun part-two-solver (input-path)
  (let ((lines (uiop:read-file-lines input-path)))
    (reduce #'+
            (mapcar (lambda (x) (char->priority (first x)))
                    (mapcar (lambda (group)
                       (intersection (coerce (third group) 'list) (intersection (coerce (first group) 'list) (coerce (second group) 'list)))) (chunk 3 lines))))))

(defun char->priority (char)
  (if (upper-case-p char)
      (- (char-code char) 38)
      (- (char-code char) 96)))
