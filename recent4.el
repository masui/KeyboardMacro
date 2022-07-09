(setq *last-macro* "")
(setq *keys-tail* "")


(defun clear-kbd-macro ()
  (setq *last-macro* "")
  (let ((r (concat (recent-keys))))
    (setq *keys-tail*(substring r (- (min 10 (length r)))))
    )
  )

(run-with-idle-timer 2 t 'clear-kbd-macro)

(defun exec-macro ()
  (interactive)
  (setq recent (concat (recent-keys)))
  (if (string= *last-macro* "")
      (progn
	;;(setq res (string-match (concat aaa "\C-l\\([^\C-l]*\\)\C-l$") recent))
	;;(setq res (string-match (concat aaa "\C-@\\([^\C-l]*\\)\C-l$") recent))

	(setq i 1)
	(setq res nil)
	(while (and (not res) (<= i (length recent)))
	  (setq s (substring recent (- i)))
	  (setq res (string-match (concat *keys-tail* "\\([^\C-l]+\\)\C-l$") s))
	  (if res
	      (setq *last-macro* (substring s (match-beginning 1) (match-end 1))))
	  (setq i (1+ i))
	  )
	(if res
	    (progn
	      ;;(setq *last-macro* (substring recent (match-beginning 1) (match-end 1)))
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

(global-set-key "\C-l" 'exec-macro)

