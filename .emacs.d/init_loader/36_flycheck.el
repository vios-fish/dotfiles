;;; package --- Summary
;;; Commentary:


;;; Code:

;;; flycheck clang include path
(setq flycheck-clang-include-path '("/usr/local/Cellar/glpk/4.52/include" "/Users/tokunagamakoto/Programing/uchidalab/HigherMarkovTracking/src/"))

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
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))

;;; flycheck error view by tool tip
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(add-hook 'after-init-hook #'global-flycheck-mode)
