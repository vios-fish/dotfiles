;;; package --- Summary
;;; Commentary:


;;; Code:

(use-package flycheck
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (flycheck-pos-tip-mode)
  (setq flycheck-gcc-language-standard "c++1y"
		flycheck-clang-language-standard "c++1y"
		flycheck-gcc-includes
		(list (expand-file-name "/usr/local/include")
			  (expand-file-name "~/local/include")
			  )
		flycheck-clang-includes
		(list (expand-file-name "/usr/local/include")
			  (expand-file-name "~/local/include")))
  )
