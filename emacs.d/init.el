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
