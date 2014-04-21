;ロードパスを追加
(setq load-path (cons my/dropbox-dir load-path))
(setq load-path (cons (concat my/dropbox-dir "/elisps") load-path))
;(setq load-path (cons (concat my/dropbox-dir "/package") load-path))
;(setq load-path (cons (concat my/dropbox-dir "/auto-install") load-path))
;(setq load-path (cons (concat my/dropbox-dir "/elisp/SKK") load-path))


(defun x->bool (elt) (not (not elt)))

;;; 今何の環境で開いているかのチェック
;; emacs-version predicates
(setq emacs22-p (string-match "^22" emacs-version)
      emacs23-p (string-match "^23" emacs-version)
      emacs23.0-p (string-match "^23\.0" emacs-version)
      emacs23.1-p (string-match "^23\.1" emacs-version)
<<<<<<< HEAD
      emacs23.2-p (string-match "^23\.2" emacs-version))
=======
      emacs23.2-p (string-match "^23\.2" emacs-version)
	  emacs24-p (string-match "^24" emacs-version))
>>>>>>> 2d36fee8445df79fb79db3d3cf785db3b1a23640

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

