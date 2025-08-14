;;; package --- init.el
;;; Company:
;;; Commentary:
;; 基本設定

;;; Code:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

; dotfilesのパス追加
(setq my/dotfiles-dir "~/repos/dotfiles/emacs.d")
(setq load-path (cons my/dotfiles-dir load-path))

;; dotfilesのcommon.elを読み込む
(load (concat my/dotfiles-dir "/common"))
(put 'dired-find-alternate-file 'disabled nil)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(irony-additional-clang-options '("-std=c++1y"))
 '(package-selected-packages
   '(cmake-mode yasnippet yaml-mode web-mode use-package rtags popwin open-junk-file migemo markdown-mode magit ivy-hydra init-loader htmlize highlight-symbol helm-gtags groovy-mode flycheck-irony dockerfile-mode docker counsel company-irony company-go autodisass-java-bytecode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-directory ((t (:foreground "#5fafff" :weight bold))))
 '(dired-flagged ((t (:background "red" :foreground "#eee" :underline t :weight bold))))
 '(dired-marked ((t (:underline t :weight bold))))
 '(dired-symlink ((t (:foreground "#5fd7ff" :weight bold))))
 '(web-mode-comment-face ((t (:foreground "#587F35"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-property-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-css-pseudo-class ((t (:foreground "#DFCF44"))))
 '(web-mode-css-selector-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-string-face ((t (:foreground "#D78181"))))
 '(web-mode-doctype-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-attr-equal-face ((t (:foreground "#FFFFFF"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#D78181"))))
 '(web-mode-html-tag-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-server-comment-face ((t (:foreground "#587F35")))))
