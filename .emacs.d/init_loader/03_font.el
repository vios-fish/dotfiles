;; ;;; フォントの設定
;; (set-fontset-font
;;  (frame-parameter nil 'font)
;;  'mule-unicode-0100-24ff
;;  '("Ricty" . "iso10646-1"))
;; (set-fontset-font (frame-parameter nil 'font)
;; 		  'japanese-jisx0208
;;                          '("Ricty" . "unicode-bmp")
;;                          )
;; (set-fontset-font (frame-parameter nil 'font)
;; 		   'katakana-jisx0201
;;                          '("Ricty" . "unicode-bmp")
;                         )


(let* ((size 14)
           (asciifont "Myrica M") ; ASCII fonts
           (jpfont "Myrica M") ; Japanese fonts
           (h (* size 10))
           (fontspec (font-spec :family asciifont))
           (jp-fontspec (font-spec :family jpfont)))
      (set-face-attribute 'default nil :family asciifont :height h)
      (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
      (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
      (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
      (set-fontset-font nil '(#x0080 . #x024F) fontspec) 
      (set-fontset-font nil '(#x0370 . #x03FF) fontspec))
