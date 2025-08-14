;;; package --- Summary
;;; Commentary:


;;; Code:

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  :config
  (setq flycheck-gcc-language-standard "c++1y"
		flycheck-clang-language-standard "c++1y"
		flycheck-gcc-include-path
		(list "/usr/local/include"
			  "~/local/include"
			  )
		flycheck-clang-include-path
		(list "/usr/local/include"
			  "~/local/include")))

(use-package flycheck-pos-tip
  :ensure t
  :requires (flycheck)
  :init
  (flycheck-pos-tip-mode))
