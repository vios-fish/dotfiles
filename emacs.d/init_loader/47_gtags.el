;;; 47_gtags.el ---                                  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  tokunaga-m

;; Author: tokunaga-m <tokunaga-m@tokunagam-OptiPlex-7040>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(use-package helm-gtags
  :ensure t
  :config
  (add-hook 'helm-gtags-mode-hook
			'(lambda ()
			   ;; ;;入力されたタグの定義元へジャンプ
			   ;; (local-set-key (kbd "M-t") 'helm-gtags-find-tag)

			   ;; ;;入力タグを参照する場所へジャンプ
			   ;; (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)  

			   ;; ;;入力したシンボルを参照する場所へジャンプ
			   ;; (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)

			   ;; ;;タグ一覧からタグを選択し, その定義元にジャンプする
			   ;; (local-set-key (kbd "M-l") 'helm-gtags-select)

			   ;; ;;ジャンプ前の場所に戻る
			   ;; (local-set-key (kbd "C-t") 'helm-gtags-pop-stack))
			))

  (add-hook 'php-mode-hook 'helm-gtags-mode)
  (add-hook 'ruby-mode-hook 'helm-gtags-mode)
  (add-hook 'java-mode-hook 'helm-gtags-mode)
  )


(provide '47_gtags)
;;; 47_gtags.el ends here
