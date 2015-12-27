;;;
;;; yasnippet
;;; スニペットを使うためのelisp

;; ドロップボックスのEmacsフォルダにsnippetsというフォルダを作っておく
;(add-to-list 'yas-snippet-dirs (concat my/emacs-directory "/snippets")) ;; 作成するスニペットはここに入る
;(add-to-list 'yas-snippet-dirs (concat my/emacs-directory "/elisp/yasnippet/snippets")) ;; 最初から入っていたスニペット(省略可能)
(yas-global-mode 1)

;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
;; (setqだとtermなどで干渉問題ありでした)
;; もちろんTAB以外でもOK 例えば "C-;"とか
;(custom-set-variables '(yas-trigger-key "TAB"))
;(custom-set-variables '(yas-trigger-key "C-;"))
;;トリガーキーをTABからSPCに変更
(define-key yas-minor-mode-map (kbd "C-;") 'yas/expand)
(define-key yas-minor-mode-map (kbd "TAB") nil)

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

;; snippet-mode for *.yasnippet files
(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))

;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
(setf (symbol-function 'yas-active-keys)
      (lambda ()
        (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))

;;; helm yasnippet
(require 'helm-c-yasnippet)
(setq helm-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "C-c y") 'helm-yas-complete)
;(yas-load-directory "<path>/<to>/snippets/")

