;;
;; "xyzabcdefg" と "abcdefghij" から "hij" を得る
;;
(defun get-postfix (s1 s2)
  (let (
	(i 0)
	(len1 (length s1))
	(len2 (length s2))
	(finished nil)
	(res "")
	p
	s
	)
    (while (and (< i len2) (not finished))
      (setq s (substring s2 0 (- len2 i)))
      (setq p (substring s1 (- (min len1 (length s)))))
      (if (string= s p)
	  (progn
	    (setq finished t)
	    (setq res (substring s2 (- i)))
	    )
	(setq i (1+ i))
	)
      )
    res
    )
  )

(defun chomp (s)
  (if (= (length s) 0)
      ""
    (substring s 0 (1- (length s)))
    )
  )

(and
 (string= (get-postfix "xx" "yy") "")
 (string= (get-postfix "xyz" "yzwu") "wu")
 (string= (get-postfix "xyzabc" "abcdefg") "defg")
 (string= (get-postfix "abc" "abcdefg") "defg")
 (string= (get-postfix "abckkk" "abcdefg") "")
 (string= (get-postfix "xxabcdef" "abcdefghi") "ghi")
 (string= (chomp "") "")
 (string= (chomp "xyz") "xy")
 )

















 













































