
(use-package migemo
  :ensure t
  :config
  (cond ((eq linux-p t)
		 (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict"))
		((eq ns-p t)
		 (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
		 )
		((eq nt-p t)
		 (setq migemo-dictionary "C:\\Users\\works.DESKTOP-H20QRUB\\Software\\cmigemo-default-win64\\dict\\utf-8\\migemo-dict")
		 ))
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-user-dictionary nil)
  (setq migemo-coding-system 'utf-8)
  (setq migemo-regex-dictionary nil)
  (load-library "migemo")
  (migemo-init))

(provide '13_migemo)
;;; 13_migemo.el ends here
