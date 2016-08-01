;; org-modeの初期化

(use-package org-install
  :bind (("C-c l" . org-store-link)
		 ("C-c a" . org-agenda)
		 ("C-c r" . org-remember))

  :mode (("\\.org$" . org-mode))

  :config
  ;; org-modeでの強調表示を可能にする
  (add-hook 'org-mode-hook 'turn-on-font-lock)
  ;; 見出しの余分な*を消す
  (setq org-hide-leading-stars t)
  ;; org-default-notes-fileのディレクトリ
  (setq org-directory "~/org/")
  ;; org-default-notes-fileのファイル名
  (setq org-default-notes-file "notes.org")

  ;; TODO状態
  (setq org-todo-keywords
		'((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
  ;; DONEの時刻を記録
  (setq org-log-done 'time))

