;;; Auto Complete
;; 自動補完

;;; パスを通す
;; (defvar my/ac-dir (concat my/emacs-directory "/elisp/auto-complete/"))
;; (setq load-path
;;       (append (list my/ac-dir
;; 					(concat my/ac-dir "lib/ert")
;; 					(concat my/ac-dir "lib/fuzzy")
;; 					(concat my/ac-dir "lib/popup")
;; 					)
;; 	      load-path))

(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/dotfiles/.emacs.d/ac-dict")
(global-auto-complete-mode t)
(setq ac-auto-start nil)
(ac-config-default)

;; Enable auto-complete mode other than default enable modes
;; (dolist (mode '(git-commit-mode
;;                 coffee-mode
;;                 go-mode
;;                 markdown-mode
;;                 fundamental-mode
;;                 org-mode
;;                 text-mode
;; 				python-mode
;; 				matlab-mode
;; 				objc-mode))
;;   (add-to-list 'ac-modes mode))


;;; ベースとなるソースを指定
(defvar my/ac-sources
              '(ac-source-yasnippet
                ac-source-abbrev
                ac-source-dictionary
                ac-source-words-in-same-mode-buffers))

;;; 個別にソースを指定
(defun ac-scss-mode-setup ()
  (setq-default ac-sources (append '(ac-source-css-property) my/ac-sources)))
(defun ac-web-mode-setup ()
  (setq-default ac-sources my/ac-sources))
(defun ac-coffee-mode-setup ()
  (setq-default ac-sources my/ac-sources))
(defun ac-python-mode-setup ()
  (setq-default ac-sources my/ac-sources))
;(add-hook 'scss-mode-hook 'ac-scss-mode-setup)
;(add-hook 'web-mode-hook 'ac-web-mode-setup)
;(add-hook 'coffee-mode-hook 'ac-coffee-mode-setup)
;(add-hook 'python-mode-hook 'ac-python-mode-setup)


;;補完キー指定
(ac-set-trigger-key "TAB")
;;ヘルプ画面が出るまでの時間（秒）
;(setq ac-quick-help-delay 0.8)

;; C-n/C-p to choose candidates
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;(define-key ac-completing-map "<tab>" 'ac-complete)

;(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
;(add-hook 'ruby-mode-hook 'ac-css-mode-setup)
;(add-hook 'auto-complete-mode-hook 'ac-common-setup)

(require 'auto-complete-clang-async)
(add-hook 'c++-mode-hook
		  '(lambda()
			 (setq ac-calng-complete-executeble "~/.emacs.d/bin/clang-complete")
			 (setq ac-sources '(ac-source-clang-async))
			 (ac-clang-launch-completion-press)))

;;; ディレクトリに.setting.elを置くとあるファイルを開いた時に
;;; そのファイルの上の階層の.setting.elを読み込む
;;; .setting.elにそのプロジェクト独自のインクルードパスを指定する
(defun recursive-load-dir-settings (currentfile)
  (let ((lds-dir (locate-dominating-file currentfile ".settings.el")))
  (when lds-dir
      (progn
        (load-file (concat lds-dir ".settings.el"))
        (recursive-load-dir-settings
         (file-truename(concat lds-dir "..")))))))

(defun load-dir-settings()
  (interactive)
  (when buffer-file-name
    (recursive-load-dir-settings buffer-file-name)))

(add-hook 'find-file-hook 'load-dir-settings)
		  

;;; auto-complete-clang用の設定
;; (require 'auto-complete-clang)
;; (defun ac-cc-init ()
;;   (ac-cc-mode-setup)
;;   (setq ac-clang-prefix-header (format "%s/dict/stdafx.pch" my/emacs-directory))
;;   (setq ac-clang-flags
;; 		'("-std=c++11" "-w" "-Wc++11-extension"))
;; ;        '("-std=c++11" "-w" "-ferror-limit" "1")) ; C++11の場合
;;   (setq ac-clang-executable "/usr/bin/clang")
;;   (setq ac-sources (append '(ac-source-clang 
;;                              ac-source-yasnippet 
;;                              ac-source-gtags)
;;                            my/ac-sources))
;;   ;(ac-clang-launch-completion-process)
;;   )

;; (add-hook 'c++-mode-hook 'ac-cc-init)
;; (add-hook 'c-mode-hook 'ac-cc-init)

(provide '30_auto-complete)
;;; 30_auto-complete.el ends here
