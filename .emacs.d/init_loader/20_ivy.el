;;; 20_ivy_new.el --- ivy configuration              -*- lexical-binding: t; -*-

;; Copyright (C) 2020  tokunaga

;; Author: tokunaga <tokunaga@tokunaga-ubuntu18-desktop>

;;; Commentary:

;;; Code:
(use-package ivy
  :ensure t
  :config
  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
  (setq ivy-use-virtual-buffers t)

  ;; ミニバッファでコマンド発行を認める
  (when (setq enable-recursive-minibuffers t)
    (minibuffer-depth-indicate-mode 1)) ;; 何回層入ったかプロンプトに表示．

  ;; ESC連打でミニバッファを閉じる
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  ;; プロンプトの表示が長い時に折り返す（選択候補も折り返される）
  (setq ivy-truncate-lines nil)

  ;; リスト先頭で `C-p' するとき，リストの最後に移動する
  (setq ivy-wrap t)

  ;; アクティベート
  (ivy-mode 1)
  )

(use-package ivy-hydra
  :ensure t
  :after ivy
  :config
  ;; M-o を ivy-hydra-read-action に割り当てる．
  (setq ivy-read-action-function #'ivy-hydra-read-action)
  )

(use-package counsel
  :ensure t
  :bind (
         ("M-x" . counsel-M-x)
         ("M-y" . counsel-yank-pop)
         ("C-M-z" . counsel-fzf)
         ("C-M-r" . counsel-recentf)
         ("C-x C-b" . counsel-ibuffer)
         ("C-M-f" . counsel-ag)
         )
  )

(use-package swiper
  :ensure t
  :bind (
         ("M-s M-s" . swiper-thing-at-point)
         )
  )

(provide '20_ivy_new)
;;; 20_ivy_new.el ends here
