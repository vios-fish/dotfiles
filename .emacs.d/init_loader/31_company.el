;;; 31_company.el --
;;; Comentary
;; Copyright (C) 2015  徳永誠

;; Author: 徳永誠 <tokunagamakoto@Tokunaga-MBA.local>
;; Keywords: local, extensions,
;;; Code:
(require 'company)
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

(global-company-mode) ; 全バッファで有効にする 
;; 特定のモードだけ有効にしたい時は以下のように
;; (add-hook 'python-mode-hook 'company-mode)


;;; TABの挙動をいい感じにする
;;; 候補が1つの時はそれを選択
;;; 複数の時は挿入可能なprefixがあれば挿入し，なければcompany-nextする
(defun company--insert-candidate2 (candidate)
  (when (> (length candidate) 0)
    (setq candidate (substring-no-properties candidate))
    (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
        (insert (company-strip-prefix candidate))
      (if (equal company-prefix candidate)
          (company-select-next)
          (delete-region (- (point) (length company-prefix)) (point))
        (insert candidate))
      )))

(defun company-complete-common2 ()
  (interactive)
  (when (company-manual-begin)
    (if (and (not (cdr company-candidates))
             (equal company-common (car company-candidates)))
        (company-complete-selection)
      (company--insert-candidate2 company-common))))

(define-key company-active-map [(tab)] 'company-complete-common2)
(define-key company-active-map [(backtab)] 'company-select-previous) ; おまけ

(defun check-expansion ()
  (save-excursion
	(if (looking-at "\\_>") t
	  (backward-char 1)
	  (if (looking-at "\\.") t
		(backward-char 1)
		(if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
	(yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
	  (minibuffer-complete)
	(if (or (not yas/minor-mode)
			(null (do-yas-expand)))
		(if (check-expansion)
			(company-complete-common2)
		  (indent-for-tab-command)))))

(global-set-key [tab] 'tab-indent-or-complete)

;; デフォルトが M-n, M-pで次の候補なのでC-n, C-pに変更
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil)


;;; 候補の順番を入れ替える
(setq company-transformers '(company-sort-by-occurrence company-sort-by-backend-importance))

;(add-hook 'after-init-hook 'global-company-mode)

(provide '32_company)
;;; 31_company.el ends here

