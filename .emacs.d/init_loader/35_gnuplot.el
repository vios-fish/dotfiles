;;; gnuplot
;;; for security ファイル読み込み時に変数が勝手に設定されるのを防ぐ
(setq enable-local-eval 'maybe)
(setq enable-local-variables 'query)
;;; gnuplot-mode
(autoload 'gnuplot-mode "gnuplot" nil t)
(add-to-list 'auto-mode-alist '("\\.gp$" . gnuplot-mode))
(add-hook 'gnuplot-mode-hook
      (function (lambda ()
                  (local-set-key "\C-c\C-c" 'compile)
                  (local-set-key "\C-cn" 'next-error)
				  (local-set-key "\C-cp" 'previous-error))))
