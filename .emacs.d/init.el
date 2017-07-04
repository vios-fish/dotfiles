;;; インストールするパッケージを特定のディレクトリにおいて
;;; 環境を閉じ込めるためのイディオム
;;; 以下のように使う
;;; emacs -q -l ~/path/to/somewhere/init.el
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;; パッケージのインストール先をEmacsのバージョンで変える
;;; Emacsのバージョンが24.4.1の場合~/.emacs.d/24.4.1/{el-get,elpa}にインストールされる
(let ((versioned-dir (locate-user-emacs-file emacs-version)))
  (setq el-get-dir (expand-file-name "el-get" versioned-dir)
        package-user-dir (expand-file-name "elpa" versioned-dir)))

;;; 基本設定
; dotfilesのパスの設定
(setq my/dotfiles-dir "~/dotfiles/.emacs.d")

;; dotfilesのcommon.elを読み込む
(load (concat my/dotfiles-dir "/common"))
(put 'dired-find-alternate-file 'disabled nil)
