;;; package -- Summery
;;; C++

;;; Commentary:


;;; Code:

;; .hをC++modeとして開く
(setq auto-mode-alist
      (append '(("\\.h$" . c++-mode))
              auto-mode-alist))

(defun my-c-c++-mode-init ()
  (google-set-c-style)
  (show-paren-mode t)             ; 括弧を強調表示する
  (auto-revert-mode)              ; ファイルの変更をすぐに反映
  (setq c-hungry-delete-key t)
  )
(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)


;;; modern c++ font lock
(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

(provide '41_C)
;;; 41_C.el ends here
