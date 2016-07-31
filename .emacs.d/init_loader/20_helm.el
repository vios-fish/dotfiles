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

(use-package helm
  :ensure t
  :init (progn
		  (helm-mode t)
		  (helm-descbinds-mode)
		  (setq helm-nestmigemo t))
  :bind (("M-x" . helm-M-x)
		 ("C-x b" . helm-buffers-list)
		 ("C-x C-f" . helm-find-files)
		 ("C-x C-r" . helm-recentf)
		 ("M-y" . helm-show-kill-ring)
		 ("C-c i" . helm-imenu)
		 ("M-g ." . helm-ag)
		 ("C-M-s" . helm-ag-this-file)
		 ("C-q" . helm-mini))
  :config
  (use-package helm-config)
  (use-package helm-migemo)
  (use-package helm-ag)
  (unbind-key "C-z")
  (custom-set-variables '(helm-command-prefix-key "C-z"))
  (bind-keys :map helm-command-map
			 ("d" . helm-descbinds)
			 ("g" . helm-ag)
			 ("o" . helm-occur)
			 ("y" . yas/insert-snippet)
			 ("M-/" . helm-dabbrev))
  (bind-key "<tab>" 'helm-execute-persistent-action helm-read-file-map)
  (bind-key "<tab>" 'helm-execute-persistent-action helm-find-files-map)
  )

;; (progn
;;   (require 'helm-config)
;;   (global-unset-key (kbd "C-z"))
;;   (custom-set-variables
;;    '(helm-command-prefix-key "C-z")))
;; ;; For find-file etc.
;; (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; ;; For helm-find-files etc.
;; (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

;; (define-key helm-command-map (kbd "d") 'helm-descbinds)
;; (define-key helm-command-map (kbd "g") 'helm-ag)
;; (define-key helm-command-map (kbd "o") 'helm-occur)
;; (define-key helm-command-map (kbd "y") 'yas/insert-snippet)
;; (define-key helm-command-map (kbd "M-/") 'helm-dabbrev)
			 
;; (define-key global-map (kbd "M-x") 'helm-M-x)
;; (define-key global-map (kbd "C-x b") 'helm-buffers-list)
;; (define-key global-map (kbd "C-x C-f") 'helm-find-files)
;; (define-key global-map (kbd "C-x C-r") 'helm-recentf)
;; (define-key global-map (kbd "M-y") 'helm-show-kill-ring)
;; (define-key global-map (kbd "C-c i") 'helm-imenu)
;; (define-key global-map (kbd "M-g .") 'helm-ag)
;; (define-key global-map (kbd "C-M-s") 'helm-ag-this-file)
;; (define-key global-map (kbd "C-q") 'helm-mini)


		 

;; Emulate 'kill-line' in helm minibuffer
(setq helm-delete-minibuffer-contents-from-point t)
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate 'kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

;;; tab complete

;;; 
(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

;; helmの設定
;; set helm-command-prefix-key to "C-z"


