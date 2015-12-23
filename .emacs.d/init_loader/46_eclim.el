(require 'eclim)
(require 'eclimd)
;; java-mode で有効
(add-hook 'java-mode-hook 'eclim-mode)
(custom-set-variables
  '(eclim-eclipse-dirs '("/private/etc/Caskroom/eclipse-java/4.5.1/Eclipse.app/Contents/Eclipse"))
  '(eclim-executable     "/private/etc/Caskroom/eclipse-java/4.5.1/Eclipse.app/Contents/Eclipse/eclim")
  '(eclimd-default-workspace "~/programing/workspace"))
;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)
;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)
;; エラー箇所にカーソルを当てるとエコーエリアに詳細を表示する
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)
(define-key eclim-mode-map (kbd "C-c C-e ;") 'eclim-run-class)
