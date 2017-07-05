;;; package --- Su

;;; Commentary:

;;; Code:
(use-package helm
  :init (progn
		  (helm-mode t)
		  (helm-descbinds-mode)
		  (helm-migemo-mode 1)
		  )
  
  :bind (("M-x"     .  helm-M-x)
		 ("C-x b"   .  helm-buffers-list)
		 ("C-x C-f" .  helm-find-files)
		 ("C-x C-r" .  helm-recentf)
		 ("M-y"     .  helm-show-kill-ring)
		 ("C-c i"	.  helm-imenu)
		 ("M-g ."	.  helm-ag)
		 ("C-M-s"	.  helm-ag-this-file)
		 ("C-q"	    .  helm-mini))
  
  :config
  (progn
	(use-package helm-config)
	;; for popwin
	(setq helm-samewindows nil)
	(setq display-buffer-function 'popwin:display-buffer)
	(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
	(push '("^\*helm-.+\*$" :regexp t) popwin:special-display-config)

	;; migemo
	(helm-migemo-mode 1)
	
	;; keybind
	(unbind-key "C-z")
	(custom-set-variables '(helm-command-prefix-key "C-z"))
	(bind-keys :map helm-command-map
			   ("d"   . helm-descbinds)
			   ("o"   . helm-occur)
			   ("y"   . yas/insert-snippet)
			   ("M-/" . helm-dabbrev))
	(bind-key "<tab>" 'helm-execute-persistent-action helm-read-file-map)
	(bind-key "<tab>" 'helm-execute-persistent-action helm-find-files-map)
	
	;; Emulate 'kill-line' in helm minibuffer
	(setq helm-delete-minibuffer-contents-from-point t)
	(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
	  "Emulate 'kill-line' in helm minibuffer"
	  (kill-new (buffer-substring (point) (field-end))))

	(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
	  "Execute command only if CANDIDATE exists"
	  (when (file-exists-p candidate)
		ad-do-it))))


(use-package helm-ag
  :after helm
  :config
  (bind-key "g" 'helm-ag helm-command-map))

(provide '20_helm)
;;; 20_helm.el ends here
