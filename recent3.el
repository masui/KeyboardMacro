(setq saved-recent-keys [])

(defun save-recent-keys ()
  (setq saved-recent-keys (recent-keys)))

;;; アイドル状態になるとrecent-keysをセーブする
(run-with-idle-timer 3 t 'save-recent-keys)

(setq *last-macro* "")

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

(defun execute-kbc-macrop (s)
  (if (= (length s) 0)
      ""
    (substring s 0 (1- (length s)))
    )
  )


(defun chomp (s) ; 文字列の最後の文字を除く
  (let ((len (length s)))
    (if (= len 0)
	""
      (substring s 0 (1- len)))
    )
  )


(defun exec-macro ()
  (interactive)
  (setq old (concat saved-recent-keys))
  (if (and (> (length old) 0) (string= (substring (concat (recent-keys)) -2) "\C-l\C-l"))
      (progn
	;;(insert *last-macro*)
	(execute-kbd-macro *last-macro*)
	)
    (setq new (chomp (concat (recent-keys))))
    (setq *last-macro* (get-postfix old new))
    (execute-kbd-macro *last-macro*)
    ;;(insert *last-macro*)
    )
  )

(global-set-key "\C-l" 'exec-macro)


ahoahoaho

(concat saved-recent-keys)
(concat (recent-keys))





Lorem ipsum dolor sit amet, consectetur
dipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna
liqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris
nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in
reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla
pariatur. Excepteur sint occaecat
cupidatat non proident, sunt in culpa
qui officia deserunt mollit anim id est
laborum.


