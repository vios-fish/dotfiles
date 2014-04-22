(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(add-hook 'python-mode-hook
		  '(lambda ()
			 (jedi:setup)
			 (define-key python-mode-map (kbd "<C-return>") 'jedi:complete)
			 ))
