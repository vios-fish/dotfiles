;;; package --- Summary
;;; Commentary:


;;; Code:

;;; flycheck for c++11
;; (flycheck-define-checker c/c++-clang
;;   "A C/C++ checker using clang."
;;   :command ("clang" "-Wall" "-Wextra" "-std=c++11"
;;             (option-list "-I" flycheck-clang-include-path)
;; 			source)
;;   :error-patterns
;;   ((error line-start
;;           (message "In file included from") " " (file-name) ":" line ":"
;;           line-end)
;;    (info line-start (file-name) ":" line ":" column
;; 		 ": note: " (message) line-end)
;;    (warning line-start (file-name) ":" line ":" column
;;             ": warning: " (message) line-end)
;;    (error line-start (file-name) ":" line ":" column
;;           ": " (or "fatal error" "error") ": " (message) line-end))

;;   :modes (c-mode c++-mode))

;; 上記設定のかわり
(add-hook 'c++-mode-hook
		  (lambda () (setq flycheck-gcc-language-standard "c++11"
						   flycheck-clang-include-path
						   (list (expand-file-name "/usr/local/include")
								 )
						   )))


;;; flycheck error view by tool tip
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode)
  )

(add-hook 'after-init-hook #'global-flycheck-mode)
