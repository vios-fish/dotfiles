;;; Code:

;;;ロードパスを追加
(setq load-path (cons my/emacs-directory load-path))
(setq load-path (cons (concat my/emacs-directory "/elisps") load-path))
;(setq load-path (cons (concat my/emacs-directory "/package") load-path))
;(setq load-path (cons (concat my/emacs-directory "/auto-install") load-path))
;(setq load-path (cons (concat my/emacs-directory "/elisp/SKK") load-path))


;; load environment variables
;; 追記 GEMに関する環境変数を設定すると rbenv経由で rubyがうまく使えなかったので削除
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;; (let ((envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH" "CPATH"
;; 			  "PKG_CONFIG_PATH"
;; 			  )))
;;   (exec-path-from-shell-copy-envs envs))


(defun x->bool (elt) (not (not elt)))

;;; 今何の環境で開いているかのチェック
;; emacs-version predicates
(setq emacs22-p (string-match "^22" emacs-version)
      emacs23-p (string-match "^23" emacs-version)
      emacs23.0-p (string-match "^23\.0" emacs-version)
      emacs23.1-p (string-match "^23\.1" emacs-version)
      emacs23.2-p (string-match "^23\.2" emacs-version)
	  emacs24-p (string-match "^24" emacs-version))

;; system-type predicates
(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      carbon-p  (eq window-system 'mac)
      linux-p   (eq system-type 'gnu/linux)
      colinux-p (when linux-p
                  (let ((file "/proc/modules"))
                    (and
                     (file-readable-p file)
                     (x->bool
                      (with-temp-buffer
                        (insert-file-contents file)
                        (goto-char (point-min))
                        (re-search-forward "^cofuse\.+" nil t))))))
      cygwin-p  (eq system-type 'cygwin)
      nt-p      (eq system-type 'windows-nt)
      meadow-p  (featurep 'meadow)
      windows-p (or cygwin-p nt-p meadow-p))

