;;;基本設定
;;; Code:
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

; dotfilesのパス追加
(setq my/dotfiles-dir "~/dotfiles/.emacs.d")
(setq load-path (cons my/dotfiles-dir load-path))

;; dotfilesのcommon.elを読み込む
(load (concat my/dotfiles-dir "/common"))
(put 'dired-find-alternate-file 'disabled nil)

(provide 'init)
;;; init.el ends here

