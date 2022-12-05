; Takes in a string in format /[0-9]+-[0-9]+/ and converts it to a list containing two numbers
(defun parse-range (s)
  (mapcar #'parse-integer (uiop:split-string s :separator "-")))

(defun split-comma-list (s)
  (uiop:split-string s :separator ","))

(defun range-contains-range (x y)
  (and (>= (first x) (first y))
       (<= (second x) (second y))))

(defun range-overlaps-range (x y)
  (or (and (>= (first x) (first y))
           (<= (first x) (second y)))
      (and (>= (second x) (first y))
           (<= (second x) (second y)))
      (or (range-contains-range x y)
          (range-contains-range y x))))

(defun parse-ranges-from-file (path)
  (mapcar
   (lambda (split-line)
     (mapcar #'parse-range split-line))
   (mapcar #'split-comma-list
           (uiop:read-file-lines path))))

(defun part-1-solver (input-path)
  (reduce #'+
   (mapcar
    (lambda (ranges)
      (if (or (range-contains-range (first ranges) (second ranges))
               (range-contains-range (second ranges) (first ranges)))
          1
          0))
    (parse-ranges-from-file input-path))))

(defun part-2-solver (input-path)
  (reduce #'+
          (mapcar (lambda (ranges)
                    (if (range-overlaps-range (first ranges) (second ranges))
                        1
                        0))
                  (parse-ranges-from-file input-path))))
