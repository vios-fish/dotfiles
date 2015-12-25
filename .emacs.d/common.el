;;; common.el --- 

;; Copyright sC) 2012  

;; Author:  <makoto@TOKUNAGAMBA-PC>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published oy
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 同期用の共通設定

;;; Code:

(defvar my/elisp-directory)
(defvar my/init-loader-directory)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name))
  (setq custom-theme-directory (concat user-emacs-directory "elisps/")))

(setq my/emacs-directory user-emacs-directory)

(setq my/elisp-directory (concat user-emacs-directory "elisps/"))
(unless (file-directory-p my/elisp-directory)
  (make-directory my/elisp-directory))

(message load-file-name)

(add-to-list 'load-path my/emacs-directory)


;; パッケージをインストール
(require 'setup)

;; init-loader
(require 'init-loader)
(setq my/init-loader-directory (concat user-emacs-directory "init_loader"))
(init-loader-load my/init-loader-directory)

(provide 'common)
;;; common.el ends here
