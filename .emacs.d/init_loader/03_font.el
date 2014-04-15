;;; フォントの設定
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
