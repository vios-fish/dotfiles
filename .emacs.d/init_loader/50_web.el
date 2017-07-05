;;; 50_web.el --- 

;; Copyright (C) 2017  

;; Author: ;;; 50_web.el ---  
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

(add-to-list 'auto-mode-alist '("\\.jsp\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'"     . web-mode))

(defun web-mode-hook ()
  "Hooks for Web mode."

  ;; indent
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
(add-hook 'web-mode-hook 'web-mode-hook)

(custom-set-faces
  ;; web-mode. colors.
 '(web-mode-doctype-face
   ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-tag-face
   ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-attr-name-face
   ((t (:foreground "#87CEEB"))))
 '(web-mode-html-attr-equal-face
   ((t (:foreground "#FFFFFF"))))
 '(web-mode-html-attr-value-face
   ((t (:foreground "#D78181"))))
 '(web-mode-comment-face
   ((t (:foreground "#587F35"))))
 '(web-mode-server-comment-face
   ((t (:foreground "#587F35"))))

 ;;; web-mode. css colors.
 '(web-mode-css-at-rule-face
   ((t (:foreground "#DFCF44"))))
 '(web-mode-comment-face
   ((t (:foreground "#587F35"))))
 '(web-mode-css-selector-face
   ((t (:foreground "#DFCF44"))))
 '(web-mode-css-pseudo-class
   ((t (:foreground "#DFCF44"))))
 '(web-mode-css-property-name-face
   ((t (:foreground "#87CEEB"))))
 '(web-mode-css-string-face
   ((t (:foreground "#D78181"))))
 )

(provide '50_web)
;;; 50_web.el ends here
