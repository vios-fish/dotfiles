;;; flycheck
(require 'flycheck)
(flycheck-define-checker c/c++-clang
  "A C/C++ checker using clang."
  :command ("/usr/bin/clang" "-Wall" "-Wextra" "-std=c++11" source)
  :error-patterns
  ((error line-start
          (message "In file included from") " " (file-name) ":" line ":"
          line-end)
   (info line-start (file-name) ":" line ":" column
		 ": note: " (message) line-end)
   (warning line-start (file-name) ":" line ":" column
            ": warning: " (message) line-end)
   (error line-start (file-name) ":" line ":" column
          ": " (or "fatal error" "error") ": " (message) line-end))

  :modes (c-mode c++-mode))

;;; flycheck error view by tool tip
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(add-hook 'after-init-hook #'global-flycheck-mode)
