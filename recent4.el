(setq *last-macro* "")

(defun clear-kbd-macro ()
  (setq *last-macro* "")
  ;;(execute-kbd-macro "\C-f\C-b\C-f\C-b")
  (setq aaa (substring (concat (recent-keys)) -4))
  )

(run-with-idle-timer 3 t 'clear-kbd-macro)

(defun exec-macro ()
  (interactive)
  (setq recent (concat (recent-keys)))
  (if (string= *last-macro* "")
      (progn
	;;(setq res (string-match (concat aaa "\C-l\\([^\C-l]*\\)\C-l$") recent))
	(setq res (string-match (concat aaa "\\([^\C-l]*\\)\C-l$") recent))
	(if res
	    (progn
	      (setq *last-macro* (substring recent (match-beginning 1) (match-end 1)))
	      ;;(insert *last-macro*)
	      (execute-kbd-macro *last-macro*)
	      )
	  (setq *last-macro* "")
	  )
	)
    (if (string= (substring recent -2) "\C-l\C-l")
	;;(insert *last-macro*)
	(execute-kbd-macro *last-macro*)
      )
    )
  )

























































