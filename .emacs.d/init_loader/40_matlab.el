;;;
;;; matlab
;;; matlab用elisp
(autoload 'matlab-mode "matlab-mode" "Enter MATLAB mode." t)
(autoload 'matlab-shell "matlab-mode" "Interactive MATLAB mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))


(setq matlab-shell-command "/usr/local/bin/matlab"  
      matlab-shell-command-swithes '("-nodesktop -v=glnxa64")  
      matlab-indent-level 4
      matlab-indent-function-body nil  
      matlab-highlight-cross-function-variables t  
      matlab-return-add-semicolon t  
      matlab-show-mlint-warnings t  
      mlint-programs '("/usr/local/matlab2009a/bin/glnxa64/mlint")  
      matlab-mode-install-path (list (expand-file-name "~/matlab/"))
      )

(defun set-matlab-mode-common-conf ()
  (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
  (show-paren-mode t)             ; 括弧を強調表示する
  (auto-revert-mode)              ; ファイルの変更をすぐに反映
  )
;; matlabにフックさせる
(add-hook 'matlab-mode 'set-matlab-mode-common-conf)


(autoload 'mlint-minor-mode "mlint" nil t)  
(add-hook 'matlab-mode-hook (lambda () (mlint-minor-mode 1)))  
(add-hook 'matlab-shell-mode-hook 'ansi-color-for-comint-mode-on)  
(add-hook 'matlab-shell-mode-hook  
	  (lambda () (setenv "LANG" "C")))
(eval-after-load "shell"  
  '(define-key shell-mode-map [down] 'comint-next-matching-input-from-input))
(eval-after-load "shell"  
  '(define-key shell-mode-map [up] 'comint-previous-matching-input-from-input))
