
(setq saved-recent-keys [])

(defun save-recent-keys ()
  (setq saved-recent-keys (recent-keys)))

;;; アイドル状態になるとrecent-keysをセーブする
(run-with-idle-timer 3 t 'save-recent-keys)

(setq *last-macro* "")

(defun exec-macro ()
  (interactive)
  (setq old (concat saved-recent-keys))
  (if (and (> (length old) 0) (string= (substring (concat (recent-keys)) -2) "\C-l\C-l"))
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
    (if finished
	(progn
	  (setq *last-macro* (substring new (- (- i 1))))
	  (execute-kbd-macro *last-macro*)
	  )
      (setq *last-macro* "")
      )
    )
  )


(global-set-key "\C-l" 'exec-macro)



aho




old
"

(concat (recent-kesys(()))


"


new
"(concat (recent-kesys(()))


aho"



(concat (recent-keys))


(setq i 3)

(setq x (substring new 0 (- (length new) i)))
"(concat (recent-kesys(()))


aho"


(setq y (substring old (- (length x))))



(substring new (- i))


*last-macro*


(string= x y)
t




;;;;;;;;;;;
(concat saved-recent-keys)

;;;;;;;;;;;
(concat (recent-keys))


def(setq new "abcdefghij")
"abcdefghij"

(setq new (substring new 0 (1- (length new))))
"abcdefghij"

(setq newlen (length new))
(setq x (substring new 0 (- newlen i)))
"abcdefg"


(setq i 3)
(substring new (- (- i 1)))
"ij"



