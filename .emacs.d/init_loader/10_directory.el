;;; ディレクトリ
;; diredを便利にする
(require 'dired-x)
;; diredから"r"でファイル名をインライン編集する
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;; 各種設定
(add-hook 'dired-load-hook
		  '(lambda ()
			 ;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
			 (setq dired-dwim-target t)
			 ;; ディレクトリを再帰的にコピーする
			 (setq dired-recursive-copies 'always)
			 ;; diredバッファでC-sした時にファイル名だけにマッチするように
			 (setq dired-isearch-filenames t)
			 ;; .zipで終わるファイルをZキーで展開できるように
			 (add-to-list 'dired-compress-file-suffixes '("\\.zip\\'" ".zip" "unzip"))
			 ;; ディレクトリを再帰的にコピー可能にする
			 (setq dired-recursive-copies 'always)

			 ;; ディレクトリを確認なしで再帰的に削除可能にする(使用する場合は注意)
										;(setq dired-recursive-deletes 'always)
			 ;; 対象の最上位ディレクトリごとに確認が出る形
			 (setq dired-recursive-deletes 'top)

			 ;; lsのオプションを指定 (詳しくはlsのmanページなどを参照)
			 ;; Windows以外向け
			 ;; "l" (小文字のエル)は必須
			 ;; ディレクトリをファイルよりも上に表示するには
			 ;;   "--group-directories-first" を含める
			 ;; 出力される日時の形式を "YYYY-MM-DD hh:mm" にするには
			 ;;   "--time-style=long-iso" を含める
			 (setq dired-listing-switches "-Flha --time-style=long-iso --group-directories-first")   ; "." と ".." が必要な場合
										;(setq dired-listing-switches "-GFlha --time-style=long-iso --group-directories-first") ; グループ表示が不要な場合
										;(setq dired-listing-switches "-FlhA --time-style=long-iso --group-directories-first")  ; "." と ".." が不要な場合

			 ;; find-dired/find-grep-diredで、条件に合ったファイルを一覧する際の出力形式
			 ;; ([findのオプション(出力に関係するもの)] . [LSのオプション(出力解析上の指定)])
			 (setq find-ls-option '("-print0 | xargs -0 ls -Flhatd --time-style=long-iso" . "-Flhatd --time-style=long-iso"))

			 ;; 新規バッファを作らずに移動するコマンド "dired-find-alternate-file" は
			 ;; 標準では無効化されているので、使用したい場合は下の記述で有効にする
			 (put 'dired-find-alternate-file 'disabled nil)
			 )
		  )

;; 幾つかの部分の表示スタイルをカスタマイズ
;; "M-x describe-face" で "dired-" と入力してTab補完できる項目に適用可で
;; "M-x customize-face" で選択して簡易設定することもできる
(custom-set-faces
 '(dired-directory ((t (:foreground "#5fafff" :weight bold))))
 '(dired-symlink ((t (:foreground "#5fd7ff" :weight bold))))
 '(dired-flagged ((t (:background "red" :foreground "#eee" :underline t :weight bold))))
 '(dired-marked ((t (:underline t :weight bold))))
 )

;; "Enter" を押したとき、新規バッファを作らずにディレクトリを開く
;; 既定では "a" を押したときにのみこの動作になる
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;; "a" を押したときにのみ新規バッファを作って開くようにする
;; 既定では "Enter" を押したときに新規バッファで開く
(define-key dired-mode-map (kbd "a") 'dired-find-file)
;; "^" が押しにくい場合 "c "でも上の階層に移動できるようにする
										;(define-key dired-mode-map (kbd "c") 'dired-up-directory)

;; diredでマークをつけたファイルを開く
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "F") 'my-dired-find-marked-files)
     (defun my-dired-find-marked-files (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))))

;; diredでマークをつけたファイルをviewモードで開く
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "V") 'my-dired-view-marked-files)
     (defun my-dired-view-marked-files (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'view-file fn-list)))))
