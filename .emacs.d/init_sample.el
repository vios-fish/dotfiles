;;; 基本設定
; dotfilesのパスの設定
(setq my/dotfiles-dir "~/dotfiles/.emacs.d")

;; dotfilesのcommon.elを読み込む
(load (concat my/dotfiles-dir "/common")
(put 'dired-find-alternate-file 'disabled nil)
