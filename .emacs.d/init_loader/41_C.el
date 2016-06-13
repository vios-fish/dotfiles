;;; C++
;; .hをC++modeとして開く
(setq auto-mode-alist
      (append '(("\\.h$" . c++-mode))
              auto-mode-alist))

;; C系言語の共通設定
(setq-default c-indent-tabs-mode nil     ; Pressing TAB should cause indentation
	      c-indent-level 4         ; A TAB is equivilent to four spaces
	      c-argdecl-indent 0       ; Do not indent argument decl's extra
	      c-tab-always-indent t
	      backward-delete-function nil) ; DO NOT expand tabs when deleting
(c-add-style "my-c-style" '((c-continued-statement-offset 4))) ; If a statement continues on the next line, indent the continuation by 4
(defun set-c-mode-common-conf ()
  (c-toggle-hungry-state 1)       ; バックスペースなどの削除するキーを押すとスペースを一気に消す欲張り削除機能とelecetic-modeをを有功にする
  (c-set-style "my-c-style")      ; 使うのはmy-c-style
  (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
  (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
  (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
  (show-paren-mode t)             ; 括弧を強調表示する
  (auto-revert-mode)              ; ファイルの変更をすぐに反映
  ;(flymake-mode t)                ; flymakeを行う
  )
;; C言語系全てにフックさせる
(add-hook 'c-mode-common-hook 'set-c-mode-common-conf)

;; C,C++ style
(defun my-c-mode-hook ()
  (c-set-style "my-c-style")
  (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
  (c-set-offset 'inline-open '+)
  (c-set-offset 'block-open '+)
  (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  (c-set-offset 'case-label '+))       ; indent case labels by c-indent-level, too
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

;;; modern c++ font lock
(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

;; ;;; C++11の予約語セット
;; (require 'font-lock)

;; (defun --copy-face (new-face face)
;;   "Define NEW-FACE from existing FACE."
;;   (copy-face face new-face)
;;   (eval `(defvar ,new-face nil))
;;   (set new-face new-face))

;; (--copy-face 'font-lock-label-face  ; labels, case, public, private, proteced, namespace-tags
;;          'font-lock-keyword-face)
;; (--copy-face 'font-lock-doc-markup-face ; comment markups such as Javadoc-tags
;;          'font-lock-doc-face)
;; (--copy-face 'font-lock-doc-string-face ; comment markups
;;          'font-lock-comment-face)

;; (global-font-lock-mode t)
;; (setq font-lock-maximum-decoration t)

;; ;(set-face-foreground 'font-lock-constant-face "#FFBF7F")

;; (add-hook 'c++-mode-hook
;; 		  '(lambda()
;; 			 (font-lock-add-keywords
;; 			  nil '(;; complete some fundamental keywords
;; 					;("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
;; 					;; add the new C++11 keywords
;; 					("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
;; 					;("\\<\\(char[0-9]+_t\\)\\>" . font-lock-keyword-face)
;; 					;; PREPROCESSOR_CONSTANT
;; 					;("\\<[A-Z]+[A-Z_]+\\>" . font-lock-constant-face)
;; 					;; hexadecimal numbers
;; 					("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
;; 					;; integer/float/scientific numbers
;; 					("\\<[-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][-+]?[0-9]+\\)?[fFlL]?\\>" . font-lock-constant-face)
;; 					;; user-types (customize!)
;; 					;("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(t\\|type\\|ptr\\)\\>" . font-lock-type-face)
;; 					;("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
;; 					))
;; 			 ) t)
