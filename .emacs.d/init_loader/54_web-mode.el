;;; 54_web-mode.el ---

;; Copyright (C) 2017  Guest

;; Author: Guest
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

(use-package web-mode
  :mode (("\\.jsp$" . web-mode)
		 ("\\.html?$" . web-mode))
  :config
   (setq web-mode-html-offset   2)
   (setq web-mode-style-padding 2)
   (setq web-mode-css-offset    2)
   (setq web-mode-script-offset 2)
   (setq web-mode-java-offset   2)
   (setq web-mode-asp-offset    2)

   (local-set-key (kbd "C-m") 'newline-and-indent)
   
   ;; auto tag closing
										;0=no auto-closing
										;1=auto-close with </
										;2=auto-close with > and </
   (setq web-mode-tag-auto-close-style 2)
   )

(provide '54_web-mode)
;;; 54_web-mode.el ends here
