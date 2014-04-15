;;;
;;; anything.el
;;;
;; (require 'anything-startup)
;; ;;; descbinds-anything.el
;; (require 'descbinds-anything)
;; (descbinds-anything-install)
;; ; my-anything-filelist+
;; (defun my-anything-filelist+ ()
;;   (interactive)
;;   (anything-other-buffer
;;    '(anything-c-source-files-in-current-dir+
;;      anything-c-source-buffers+
;;      anything-c-source-recentf
;;      anything-c-source-mac-spotlight
;;      anything-c-source-locate)
;;    " *my-anything-filelist+*"))

;; ;; anything key
;; (global-set-key "\C-x\C-b" 'anything-buffers+)
;; (global-set-key "\C-x\C-v" 'my-anything-filelist+)
;; (global-set-key "\C-x\C-f" 'find-file)

;;;
;;; helm
;;;

(require 'helm-config)
(helm-mode t)
(helm-descbinds-mode)
(require 'helm-migemo)
(setq helm-nestmigemo t)

;; Emulate 'kill-line' in helm minibuffer
(setq helm-delete-minibuffer-contents-from-point t)
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate 'kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

;; gitのプロジェクトをhelmで開く
(defun helm-c-sources-git-project-for (pwd)
  (loop for elt in
        '(("Modified files" . "--modified")
          ("Untracked files" . "--others --exclude-standard")
          ("All controlled files in this project" . nil))
        for title  = (format "%s (%s)" (car elt) pwd)
        for option = (cdr elt)
        for cmd    = (format "git ls-files %s" (or option ""))
        collect
        `((name . ,title)
          (init . (lambda ()
                    (unless (and (not ,option) (helm-candidate-buffer))
                      (with-current-buffer (helm-candidate-buffer 'global)
                        (call-process-shell-command ,cmd nil t nil)))))
          (candidates-in-buffer)
          (type . file))))

(defun helm-git-project-topdir ()
  (file-name-as-directory
   (replace-regexp-in-string
    "\n" ""
    (shell-command-to-string "git rev-parse --show-toplevel"))))

(defun helm-git-project ()
  (interactive)
  (let ((topdir (helm-git-project-topdir)))
    (unless (file-directory-p topdir)
      (error "I'm not in Git Repository!!"))
    (let* ((default-directory topdir)
           (sources (helm-c-sources-git-project-for default-directory)))
      (helm-other-buffer sources "*helm git project*"))))

;;; tab complete
;; For find-file etc.
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; For helm-find-files etc.
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

;;; 
(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

;; helmの設定
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x b") 'helm-buffers-list)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)
(define-key global-map (kbd "C-c i") 'helm-imenu)
