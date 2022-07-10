(setq *last-macro* "")
(setq *old-recent* "")

(defun clear-kbd-macro ()
  (setq *last-macro* "")
  (setq *old-recent* (concat (recent-keys)))
  )

(run-with-idle-timer 2 t 'clear-kbd-macro)

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
	(p "")
	(s "")
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

(defun chomp (s) ; 文字列の最後の文字を除く
  (let ((len (length s)))
    (if (= len 0)
	""
      (substring s 0 (1- len)))
    )
  )

(defun exec-macro () ;;; Ctrl-L で呼ばれる
  (interactive)
  (setq recent (concat (recent-keys)))
  (if (string= *last-macro* "")
      (setq *last-macro* (chomp (get-postfix *old-recent* recent)))
    )
  (execute-kbd-macro *last-macro*)
  )

(global-set-key "\C-l" 'exec-macro)

