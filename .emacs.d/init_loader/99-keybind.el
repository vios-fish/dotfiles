;;;キーバインド
(define-key global-map (kbd "M-?") 'help-for-help)        ; ヘルプ
(define-key global-map (kbd "C-c i") 'indent-region)      ; インデント
;(define-key global-map (kbd "C-c C-i") 'hippie-expand)    ; 補完
(define-key global-map (kbd "C-c ;") 'comment-dwim)       ; コメントアウト
(define-key global-map (kbd "M-C-g") 'grep)               ; grep
(define-key global-map (kbd "C-[ M-C-g") 'goto-line)      ; 指定行へ移動
(define-key global-map (kbd "M-C-!") 'term)             ; eshell
(keyboard-translate ?\C-h ?\C-?)

;; スクリーンの最大化
;(set-frame-parameter nil 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
