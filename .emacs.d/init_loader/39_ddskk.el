(setq skk-user-directory (concat my/emacs-directory "ddskk/")) ; ディレクトリ指定
(when (require 'skk-autoloads nil t)
  ;; C-x C-j で skk モードを起動
  (define-key global-map (kbd "C-x C-j") 'skk-mode)
  ;; .skk を自動的にバイトコンパイル
  (setq skk-byte-compile-init-file t)
  (setq skk-tut-file "~/.emacs.d/etc/skk/SKK.tut"))



(require 'info)
(add-to-list 'Info-additional-directory-list "~/.emacs.d/info")
