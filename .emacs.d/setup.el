;;; setup.el --- 

;; Copyright (C) 2014  徳永誠

;; Author: 徳永誠 <tokunagamakoto@tokunagamakoto-no-MacBook-Air.local>
;; Keywords: lisp


;; PATHをロードパスに追加
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)


;; (unless load-file-name
;;   (unless (file-symlink-p my/init-loader-directory)
;;     (make-symbolic-link (concat default-directory "init_loader")
;;                         user-emacs-directory)))

;; first eval this code block
(add-to-list 'load-path my/elisp-directory)

;; check commands
(dolist (cmd '("curl"))
  (unless (executable-find cmd)
    (error "Please install %s" cmd)))

(defvar my/favorite-packages
  '(
    ;; cask
    pallet

    ;; base
    exec-path-from-shell
    
    ;; libraly for elisp
    dash ; list function API
    s    ; string function API
    f    ; file function API
    ht   ; hash table API
    
    ;; mode
    php-mode
    haskell-mode
    csharp-mode
    yaml-mode
    ruby-mode
    js2-mode
    web-mode
    matlab-mode
    google-c-style
    
    gtags

    ;; init-loader
    init-loader

    ;; helm
    helm

    ;; helm packages
    helm-git
    helm-gtags
    helm-c-moccur
    helm-c-yasnippet
    helm-R
    helm-ag
    helm-migemo
    wgrep-helm
    helm-descbinds

    ;;; editing utilities
    open-junk-file
    expand-region
    wrap-region
    undo-tree
;    auto-complete
    fuzzy
    smartrep
    yasnippet
    migemo
    all-ext

	company

    ;;; buffer utils
    popwin
    buffer-move
    htmlize
    direx

    ;;; programming
    smart-compile

	;;;auto-complete-clang
	auto-complete-clang-async
    
    ;;; lisp
    paredit

	;;; R
    ess
    ess-R-object-popup

	;;; python
    deferred
    epc
    jedi
    python-mode

    ;;; syntacks check
    flycheck
    flycheck-pos-tip

	;;; org
    org
    org-plus-contrib

	;;; git
    magit
    
    ;;; syntacks check
    flycheck

	;;; mail
	mew

	;;; thema
    powerline
    
    ;;; vim
					;evil

	;;; the-silver-search
    ag
    )
  "起動時に自動的にインストールされるパッケージのリスト")

(defvar my/favorite-package-urls
  '(
    ;; 1ファイルのelispしか管理できません
    ;; パッケージ名はファイル名の.elより前の部分になります
    ;"http://namazu.org/~tsuchiya/elisp/dabbrev-ja.el"
    ;"http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el"
    )
  "起動時に自動的にインストールされるelispのURLのリスト")

;; ネットワーク経由で取得したelispをpackage.el管理する
(defun package-install-from-url (url)
  "URLを指定してパッケージをインストールする"
  (interactive "sURL: ")
  (let ((file (and (string-match "\\([a-z0-9-]+\\)\\.el" url) (match-string-no-properties 1 url))))
    (with-current-buffer (url-retrieve-synchronously url)
      (goto-char (point-min))
      (delete-region (point-min) (search-forward "\n\n"))
      (goto-char (point-min))
      (setq info (cond ((condition-case nil (package-buffer-info) (error nil)))
                       ((re-search-forward "[$]Id: .+,v \\([0-9.]+\\) .*[$]" nil t)
                        (vector file nil (concat "[my:package-install-from-url]") (match-string-no-properties 1) ""))
                       (t (vector file nil (concat file "[my:package-install-from-url]") (format-time-string "%Y%m%d") ""))))
      (package-install-from-buffer info 'single)
      (kill-buffer)
      )))

(defun package-url-installed-p (url)
  "指定されたURLに対応するパッケージがインストールされているか調べる"
  (interactive "sURL: ")
  (let ((pkg-name (and (string-match "\\([a-z0-9-]+\\)\\.el" url) (match-string-no-properties 1 url))))
    (package-installed-p (intern pkg-name))))

(eval-when-compile
  (require 'cl))

(when (require 'package nil t)
  (setq package-user-dir "~/.emacs.d/elpa")
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (package-initialize)
  
  ;; my/favorite-packagesのパッケージをインストールする
  (let ((pkgs (loop for pkg in my/favorite-packages
                    unless (package-installed-p pkg)
                    collect pkg)))
    (when pkgs
      ;; check for new packages (package versions)
      (message "%s" "Get latest versions of all packages...")
      (package-refresh-contents)
      (message "%s" " done.")
      (dolist (pkg pkgs)
        (package-install pkg))))
  
  ;; my/favorite-package-urlsのパッケージをインストール
  (let ((urls (loop for url in my/favorite-package-urls
                    unless (package-url-installed-p url)
                    collect url)))
    (dolist (url urls)
      (package-install-from-url url))))

(provide 'setup)
