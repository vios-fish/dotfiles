;;; ウィンドウ分割
;; 分割してない時は分割を行う
;; 分割しているときはwindow切り替え

(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
        (split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))

(global-set-key (kbd "C-t") 'other-window-or-split)


;;;linum
(require'linum)
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
(setq linum-format "%4d ") ; 4 桁分の領域を確保して行番号のあとにスペースを入れる
(global-set-key [f9] 'linum-mode)
;; メージャーモード/マイナーモードでの指定
(setq my-linum-hook-name '(emacs-lisp-mode-hook slime-mode-hook sh-mode-hook
			   text-mode-hook php-mode-hook python-mode-hook
			   ruby-mode-hook
                           css-mode-hook yaml-mode-hook org-mode-hook
                           howm-mode-hook js2-mode-hook javascript-mode-hook
                           smarty-mode-hook html-helper-mode-hook c++-mode-hook
			   c-mode-hook))
;; ファイル名での判定
(setq my-linum-file '("hosts" "my_site"))
;; 拡張子での判定
(setq my-linum-file-extension '("conf" "bat"))
;; メージャーモード/マイナーモードでの指定
(defvar my-linum-hook-name nil)
(mapc (lambda (hook-name)
          (add-hook hook-name (lambda () (linum-mode t))))
       my-linum-hook-name)

;; ファイル名での判定
(defvar my-linum-file nil)
(defun my-linum-file-name ()
  (when (member (buffer-name) my-linum-file)
                (linum-mode t)))
(add-hook 'find-file-hook 'my-linum-file-name)
;; 拡張子での判定
(defvar my-linum-file-extension nil)
(defun my-linum-file-extension ()
  (when (member (file-name-extension (buffer-file-name)) my-linum-file-extension)
                (linum-mode t)))
(add-hook 'find-file-hook 'my-linum-file-extension)


;; fullscreen
(defvar my-fullscreen-default 'fullboth)
(defun my-fullscreen (arg)
  (interactive "P")
  (let* ((state (frame-parameter (selected-frame) 'fullscreen))
         (my-fullscreen-default
          (cond
           (arg
            (intern (completing-read (format "method (now:%s): " state)
                                     '("fullboth" "maximized" "nil")
                                     nil
                                     t)))
           (t
            my-fullscreen-default))))
    (cond
     ((or arg (null state))
      (setq state my-fullscreen-default))
     (t
      (setq state nil)))
    (set-frame-parameter (selected-frame) 'fullscreen state))
  (redisplay))
(global-set-key [(F11)] 'my-fullscreen)

