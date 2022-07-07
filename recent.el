;;(setq x 0)
;;
;;(defun setx ()
;;  (setq x 1))
;;
;;
;;(run-with-idle-timer 3 nil 'setx)
;;
;;(recent-keys)

;;; 最近入力された文字列を知りたい
;;; アイドル状態が続いた後で入力されたキーの列

(setq saved nil)

(defun save-recent-keys ()
  (setq saved (recent-keys)))


;;; アイドル状態になるとrecent-keysをセーブする
(run-with-idle-timer 3 t 'save-recent-keys)


;;; セーブされたrecent-keysと現在のrecent-keysの差分を計算したい
;;; それが「最近入力されたキー」だろう
(defun adiff (old new)
  ;; newからひとつずつ要素を消していって、oldと同じになればいいんじゃないカナ
  []
  )

(setq a [1 2 3 4 5])
(equal [1 2] [1 2])

(setq a [65 66 67])

(concat (recent-keys))

(setq s "abcdefghijklmn")
"abcdefghijklmn"
(substring s -2)

(setq q (concat saved))


(setq old "abcdefghijklmnopqrstuvwxyz")
(setq old "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ")

(setq new "klmnopqrstuvwxyz0123456")
;;; ここから0123456を取得したい

(setq i 0)
(setq i (1+ i))


(setq saved-recent-keys [])

(defun save-recent-keys ()
  (setq saved-recent-keys (recent-keys)))


;;; アイドル状態になるとrecent-keysをセーブする
(run-with-idle-timer 3 t 'save-recent-keys)

(defun calc ()
  (setq old (concat saved-recent-keys))
  (setq new (concat (recent-keys)))
  (setq newlen (length new))
  (setq finished nil)
  (setq i 0)
  (setq len (length new))
  (while (and (< i newlen) (not finished))
    (setq x (substring new 0 (- len i)))
    (if (string= (substring old (- (length x))) x)
	(setq finished t))
    (setq i (1+ i))
    )
  (substring new (- i))
  )


(length (concat saved))
(length (concat (recent-keys)))

(calc)






































   
















