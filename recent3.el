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

(defuexecute-kbc-macrop (s)
  (if (= (length s) 0)
      ""
    ubstring s 0 (1- (length s)))
    ;;)
  )


(defun exec-macro ()
  (interactive)
  (setq old (concat saved-recent-keys))
  (if (and (> (length old) 0) (string= (substring (concat (recent-keys)) -2) "\C-l\C-l"))
      (insert *last-macro*)
      ;;(execute-kbd-macro *last-macro*)
    (setq new (chomp (concat (recent-keys))))
    (setq *last-macro* (get-postfix old new))
    ;;(execute-kbd-macro *last-macro*)
    (insert *last-macro*)
    )
  )

aho

abcabcabcabcabcabcabcabcabcabcabc

abc[Iofabc

old
"


[O"
new
"


[O[Iofabc"

dahkdah
old
"


[O[Iofabcold
new
"
newold
new
"


[O[Iofabcold
new
kdahold
new"
ahoahoahoahoahoaho
old
"


[O[Iofabcold
new
kdahold
new
"


exec-macro

exec-macro






(global-set-key "\C-l" 'exec-macro)

(concat saved-recent-keys)

ahoahoahoahoahoahoahoahoahoahoaho

mensamensamensamensamensamensamensa

manmanmanmanmanmanmanman



maymay
jayjayjayjayjayjayjayjayjay


