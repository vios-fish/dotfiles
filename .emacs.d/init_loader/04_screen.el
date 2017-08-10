;;; Commentary
(setq default-frame-alist
;;; Code:
;;; Emacsのスクリーン情報
      (append (list '(foreground-color . "azure3")
					'(background-color . "black")
					'(border-color . "black")
					'(mouse-color . "white")
					'(cursor-color . "white")
					'(width . 190)
					'(height . 50)
					'(alpha . (100 100 40 40))
					)
			  default-frame-alist))

(setq custom-theme-directory (concat my/emacs-directory "/themes/"))
(load-theme 'molokai t)


