;;;基本設定
; Dropboxのパス追加
(setq dropbox-emacs-dir "~/dropbox/emacs.d")

;;; フォント
;(cond (window-system
;       (set-default-font "Ricty-14")
;       (set-fontset-font (frame-parameter nil 'font)
;                         'japanese-jisx0208
;                         '("Ricty" . "unicode-bmp")
;			 )))

(set-fontset-font
 (frame-parameter nil 'font)
 'mule-unicode-0100-24ff
 '("Ricty" . "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
		  'japanese-jisx0208
                         '("Ricty" . "unicode-bmp")
                         )
(set-fontset-font (frame-parameter nil 'font)
		   'katakana-jisx0201
                         '("Ricty" . "unicode-bmp")
                         )

;;;Emacsのスクリーン情報
(setq default-frame-alist
      (append (list '(foreground-color . "azure3")
	'(background-color . "black")
	'(border-color . "black")
	'(mouse-color . "white")
	'(cursor-color . "white")
	'(width . 190)
	'(height . 50)
	'(alpha . (80 60 40 40))
	)
	default-frame-alist))

(message "%s\n" dropbox-emacs-dir)

;; dropboxのcommon.elを読み込む
(load (concat dropbox-emacs-dir "/common"))

