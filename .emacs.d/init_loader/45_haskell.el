;; haskell-mode
(autoload 'haskell-mode "haskell-mode")
(autoload 'haskell-cabal "haskell-cabal")
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode))
(setq haskell-program-name "ghci")

(add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin")) ;; ghc-modの実行ファイルへのパス
(add-to-list 'load-path "~/.emacs.d/elisps/ghc-mod") ;; ~/.emacs.d/elisp/ghc-mod/ghc-*.el へのパス
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; auto-complete
(ac-define-source ghc-mod
  '((depends ghc)
    (candidates . (ghc-select-completion-symbol))
    (symbol . "s")
    (cache)))

(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod)))
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod))))

(add-hook 'find-file-hook 'my-haskell-ac-init)
