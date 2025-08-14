;;; package --- init.el
;;; Company:
;;; Commentary:
;; 基本設定

;;; Code:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

; dotfilesのパス追加
(defvar my/dotfiles-dir "~/repos/dotfiles/emacs.d"
  "Set dotfiles directory.")
(setq load-path (cons my/dotfiles-dir load-path))

;; dotfilesのcommon.elを読み込む
(load (concat my/dotfiles-dir "/common"))
(put 'dired-find-alternate-file 'disabled nil)

;; load auto-generated custom file by packages.el
;; https://extra-vision.blogspot.com/2016/10/emacs25-package-selected-packages.html
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here
