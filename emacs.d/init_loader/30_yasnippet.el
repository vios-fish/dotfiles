;;;
;;; yasnippet
;;; スニペットを使うためのelisp

;; ドロップボックスのEmacsフォルダにsnippetsというフォルダを作っておく
;(add-to-list 'yas-snippet-dirs (concat my/emacs-directory "/snippets")) ;; 作成するスニペットはここに入る
										;(add-to-list 'yas-snippet-dirs (concat my/emacs-directory "/elisp/yasnippet/snippets")) ;; 最初から入っていたスニペット(省略可能)

;;; Code:

(use-package yasnippet
  :ensure t
  :commands company
  :init (progn
		  (yas-global-mode 1)
		  )
  :mode ("\\.yasnippet" . snippet-mode)
  :config
  (bind-keys :map yas-minor-mode-map
			 ("C-;" . yas-expand)
			 ([tab] . nil)
			 ("C-x i i" . yas-insert-snippet)
			 ("C-x i n" . yas-new-snippet)
			 ("C-x i v" . yas-visit-snippet-file))
  )

(provide '30_yasnippet)
;;; 30_yasnippet ends here

