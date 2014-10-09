;; 変数の設定
(defvar my/elisp-directory)
(defvar my/init-loader-directory)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name))
  (setq custom-theme-directory (concat user-emacs-directory "elisps/")))

(setq my/emacs-directory user-emacs-directory)

(setq my/elisp-directory (concat user-emacs-directory "elisps/"))
(unless (file-directory-p my/elisp-directory)
  (make-directory my/elisp-directory))

(message load-file-name)

(add-to-list 'load-path my/emacs-directory)

(require 'common)

(provide 'init)
