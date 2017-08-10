
;;; Code:
;;日本語
;言語を日本語にする
;(require 'un-define)
(set-language-environment 'Japanese)
(set-terminal-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(setq default-input-method 'japanese-anthy)
;日本語化
;(setq menu-tree-coding-system 'utf-8)
;(require 'menu-tree)
; UTF-8 and Japanese Setting


;;;オープニングメッセージを表示しない
(setq inhibit-startup-message t)

;ビープ音を消す
(setq visible-bell t)

;;;画像
;;画像ファイルを表示
(auto-image-file-mode t)

;;;カーソル
;;カーソルの点滅を止める
(blink-cursor-mode 0)

;;; メニューバー
;; メニューバーを消す
(menu-bar-mode nil)
;; ツールバーを消す
(tool-bar-mode -1)

;;; バックアップファイル
;; .#*とかのバックアップファイルを作る
(setq make-backup-files t)
(setq backup-directory (expand-file-name "~/.emacs.d/backup/"))
(if (and (boundp 'backup-directory)
         (not (fboundp 'make-backup-file-name-original)))
    (progn
      (fset 'make-backup-file-name-original
            (symbol-function 'make-backup-file-name))
      (defun make-backup-file-name (filename)
        (if (and (file-exists-p (expand-file-name backup-directory))
                 (file-directory-p (expand-file-name backup-directory)))
            (concat (expand-file-name backup-directory) 
                    "/" (file-name-nondirectory filename))
          (make-backup-file-name-original filename)))))

(setq auto-save-default t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backup/" t)))


;; バッファの自動読み込み
(global-auto-revert-mode 1)

;;;タブ
;;タブ幅を 4 に設定
(setq-default tab-width 4)
;;タブ幅の倍数を設定
(setq tab-stop-list
  '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
;;タブではなくスペースを使う
;(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)


;;; 括弧
;; 対応する括弧を光らせる。
(show-paren-mode 1)
;; ウィンドウ内に収まらないときだけ括弧内も光らせる。
(setq show-paren-style 'mixed)


;;; 空白
;; 行末の空白を表示
;(setq-default show-trailing-whitespace t)
;; 空白や長すぎる行を視覚化する。
;(require 'whitespace)
;; 1行が80桁を超えたら長すぎると判断する。
;(setq whitespace-line-column 80)
(setq whitespace-style '(face              ; faceを使って視覚化する。
                         trailing          ; 行末の空白を対象とする。
                         lines-tail        ; 長すぎる行のうち
                                           ; whitespace-line-column以降のみを
                                           ; 対象とする。
                         space-before-tab  ; タブの前にあるスペースを対象とする。
                         space-after-tab)) ; 
;; デフォルトで視覚化を有効にする。
;(global-whitespace-mode)


;;; 位置
;; 現在行を目立たせる
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "#CC0066"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)
;カーソルの位置が何文字目かを表示する
(column-number-mode t)
;; カーソルの位置が何行目かを表示する
(line-number-mode t)
;; カーソルの場所を保存する
(require 'saveplace)
(setq-default save-place t)

;; for tramp
(require 'tramp)
(setq tramp-default-method "ssh")

;;; 行
;; 行の先頭でC-kを一回押すだけで行全体を消去する
(setq kill-whole-line t)
;; 最終行に必ず一行挿入する
(setq require-final-newline t)
;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)
; newline and indent
(global-set-key (kbd "C-m") 'newline-and-indent)

;;; バックアップ
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)


;;; 履歴
;; 履歴数を大きくする
(setq history-length 10000)
;; ミニバッファの履歴を保存する
(savehist-mode 1)
;; 最近開いたファイルを保存する数を増やす
(setq recentf-max-saved-items 10000)

;;; 圧縮
;; gzファイルも編集できるようにする
(auto-compression-mode t)

;;; リージョンの大文字小文字変換を有効にする。
;; C-x C-u -> upcase
;; C-x C-l -> downcase
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;commandキーとQptionキーを逆にする
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; 問い合わせを簡略化 yes/no を y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;; emacsclient
(require 'server)
(unless (server-running-p)
  (server-start))

;;; tramp
(if windows-p
	(setq tramp-default-method "plink"))

(provide '01-setting)
;;; 01-setting.el ends here
