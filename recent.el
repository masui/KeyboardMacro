
(setq saved-recent-keys [])

(defun save-recent-keys ()
  (setq saved-recent-keys (recent-keys)))

;;; アイドル状態になるとrecent-keysをセーブする
(run-with-idle-timer 3 t 'save-recent-keys)

(setq *last-macro* "")

(defun exec-macro ()
  (interactive)
  (setq old (concat saved-recent-keys))
  (if (and (> (length old) 0) (string= (substring old -1) "\C-l"))
      (execute-kbd-macro *last-macro*)
    (setq new (concat (recent-keys)))
    (setq new (substring new 0 (1- (length new))))
    (setq newlen (length new))
    (setq finished nil)
    (setq i 0)
    (while (and (< i newlen) (not finished) (>= (length old) (- newlen i)))
      (setq x (substring new 0 (- newlen i)))
      (if (string= (substring old (- (length x))) x)
	  (setq finished t))
      (setq i (1+ i))
      )
    ;;(substring new (- i))
    (setq *last-macro* (substring new (- (- i 1))))
    (execute-kbd-macro *last-macro*)
    )
  )

(global-set-key "\C-l" 'exec-macro)
