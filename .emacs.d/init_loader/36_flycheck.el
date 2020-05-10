;;; package --- Summary
;;; Commentary:


;;; Code:

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  :config
  (flycheck-pos-tip-mode)
  (setq flycheck-gcc-language-standard "c++1y"
		flycheck-clang-language-standard "c++1y"
		flycheck-gcc-include-path
		(list "/usr/local/include"
			  "~/local/include"
			  )
		flycheck-clang-include-path
		(list "/usr/local/include"
			  "~/local/include"))
  )
