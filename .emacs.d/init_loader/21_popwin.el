;;; package -- summery
;;; Commentary:

;;; Code:

(use-package popwin
  :config
  (progn
	(popwin-mode 1)
	(setq display-buffer-function 'popwin:display-buffer)
	;; diredバッファをボップアップ表示
	(push '(dired-mode :position top) popwin:special-display-config)))
  

(provide '21_popwin)
;;; 21_popwin.el ends here
