;;; Code:

;;;---------------------------------
;;; R & ESS の設定
;;;---------------------------------
;; パスの追加
;(setq load-path (cons (concat my/emacs-directory "/elisp/ess") load-path))
;; 拡張子が r, R の場合に R-mode を起動
(add-to-list 'auto-mode-alist '("\\.[rR]$" . R-mode))
;; R-mode を起動する時に ess-site をロード
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
;; R を起動する時に ess-site をロード
(autoload 'R "ess-site" "start R" t)
 
;; R-mode, iESS を起動する際に呼び出す初期化関数
(setq ess-loaded-p nil)
(defun ess-load-hook (&optional from-iess-p)
  ;; インデントの幅を4にする（デフォルト2）
  (setq ess-indent-level 4)
  ;; インデントを調整
  (setq ess-arg-function-offset-new-line (list ess-indent-level))
  ;; comment-region のコメントアウトに # を使う（デフォルト##）
  (make-variable-buffer-local 'comment-add)
  (setq comment-add 0)
 
  ;; 最初に ESS を呼び出した時の処理
  (when (not ess-loaded-p)
    ;; アンダースコアの入力が " <- " にならないようにする
    (ess-toggle-underscore nil)
    ;; C-c r を押した際に表示される候補数の上限値
    ;; 表示数が多いと処理が重くなる
    (setq helm-R-help-limit 40)
    (setq helm-R-local-limit 20)
    ;; C-c r で R の関数やオブジェクトを検索できるようにする
    (when (require 'helm-R nil t)
      ;; ess-smart-comma が導入されたので repospkg と localpkg はあまり必要なさそう
      (setq helm-for-R-list '(helm-c-source-R-help
                                  helm-c-source-R-local))
      (define-key ess-mode-map (kbd "C-c r") 'helm-for-R)
      (define-key inferior-ess-mode-map (kbd "C-c r") 'helm-for-R))p
    ;; C-c C-g で オブジェクトの内容を確認できるようにする
    (require 'ess-R-object-popup nil t)
    ;; 補完機能を有効にする
    (setq ess-use-auto-complete t)
    ;; helm を使いたいので IDO は邪魔
    (setq ess-use-ido nil)
    ;; キャレットがシンボル上にある場合にもエコーエリアにヘルプを表示する
    (setq ess-eldoc-show-on-symbol t)
    ;; 起動時にワーキングディレクトリを尋ねられないようにする
    (setq ess-ask-for-ess-directory nil)
    ;; # の数によってコメントのインデントの挙動が変わるのを無効にする
    (setq ess-fancy-comments nil)
    (setq ess-loaded-p t)
    (unless from-iess-p
      ;; ウィンドウが1つの状態で *.R を開いた場合はウィンドウを縦に分割して R を表示する
      (when (one-window-p)
        (split-window-horizontally)
        (let ((buf (current-buffer)))
          (ess-switch-to-ESS nil)
          (switch-to-buffer-other-window buf)))
      ;; R を起動する前だと auto-complete-mode が off になるので自前で on にする
      ;; cf. ess.el の ess-load-extras
      (when (and ess-use-auto-complete (require 'auto-complete nil t))
        (add-to-list 'ac-modes 'ess-mode)
        (mapcar (lambda (el) (add-to-list 'ac-trigger-commands el))
                '(ess-smart-comma smart-operator-comma skeleton-pair-insert-maybe))
        (setq ac-sources '(ac-source-R ac-source-filename)))))
 
  (if from-iess-p
      ;; R のプロセスが他になければウィンドウを分割する
      (if (> (length ess-process-name-list) 0)
          (when (one-window-p)
            (split-window-horizontally)
            (other-window 1)))
    ;; *.R と R のプロセスを結びつける
    ;; これをしておかないと補完などの便利な機能が使えない
    (ess-force-buffer-current "Process to load into: ")))
 
;; R-mode 起動直後の処理
(add-hook 'R-mode-hook 'ess-load-hook)
 
;; R 起動直前の処理
(add-hook 'ess-pre-run-hook (lambda () (ess-load-hook t)))
