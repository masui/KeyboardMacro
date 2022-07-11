(provide 'recent)

(defvar *last-macro* "" "繰り返し文字列")
(defvar *old-recent* "" "以前のrecent-keys")
(defvar *new-recent* "" "recent-keys")


;;(setq *last-macro* "")
;;(setq *old-recent* "")

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
      (substring s 0 (1- len))
      )))

(defun exec-macro-xxx () ;;; Ctrl-L で呼ばれる
  (interactive)
  (setq *new-recent* (concat (recent-keys)))
  (if (and (not (string= *last-macro* "")) (not (string= (substring *new-recent* -2) "\C-l\C-l")))
  ;;(if (not (string= *last-macro* ""))
      (progn
	(setq *last-macro* (chomp (get-postfix *old-recent* *new-recent*)))
	(setq *old-recent* *new-recent*)
	)
    (if (string= *last-macro* "")
	(setq *last-macro* (chomp (get-postfix *old-recent* *new-recent*)))
      )
    )
  ;;(setq *new-recent recent)
  (execute-kbd-macro *last-macro*)
  )


(defun exec-macro () ;;; Ctrl-L で呼ばれる
  (interactive)
  (setq recent (concat (recent-keys)))
  (if (string= (substring recent -2) "\C-l\C-l") ; 連打
      (setq *new-recent* recent)
    (if (string= *last-macro* "") ; 新規作成
	(progn
	  (setq *new-recent* (concat (recent-keys)))
	  (setq *last-macro* (chomp (get-postfix *old-recent* *new-recent*)))
	  )
      (setq *old-recent* *new-recent*)
      (setq *new-recent* (concat (recent-keys)))
      (setq *last-macro* (chomp (get-postfix *old-recent* *new-recent*)))
      )
    )
  (execute-kbd-macro *last-macro*)
  )

(global-set-key "\C-l" 'exec-macro)

;;
;; exec-macro の動作
;;
;; キー操作      123456789*            時間待ちしたところ
;; *old-recent*  123456789             時間待ちで設定
;; *new-recent*       
;; *last-macro*            
;; 
;; キー操作      123456789*abcL
;; *old-recent*  123456789             時間待ちで設定されたまま
;; *new-recent*       6789 abcL        Lで設定
;; *last-macro*            abc         引算計算 + 実行
;; 
;; キー操作      123456789*abcLL
;; *old-recent*  123456789
;; *new-recent*        789 abcLL
;; *last-macro*            abc         LLなので*last-macro*を実行
;; 
;; キー操作      123456789*abcLLL
;; *old-recent*  123456789
;; *new-recent*         89 abcLLL
;; *last-macro*            abc         LLなので*last-macro*を実行
;; 
;; キー操作      123456789*abcLLLd
;; *old-recent*  123456789
;; *new-recent*         89 abcLLL      変化せず
;; *last-macro*            abc         実行せず / 実行しない
;; 
;; キー操作      123456789*abcLLLde
;; *old-recent*  123456789             変化せず
;; *new-recent*         89 abcLLL      変化せず
;; *last-macro*            abc         変化せず / 実行しない
;; 
;; キー操作      123456789*abcLLLdeL
;; *old-recent*         89 abcLLL      これをどう作る? *new-recent*をコピー?
;; *new-recent*            abcLLLdeL
;; *last-macro*                  de    引算+実行したい

