;;; 52_markdown.el --- 

;; Copyright (C) 2016  徳永誠

;; Author: 徳永誠 <tokunagamakoto@TokunagaMB.local>
;; Keywords: elisp

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

;; (add-hook 'markdown-mode-hook
;; 		  (lambda ()
;; 			(when buffer-file-name
;; 			  (add-hook 'after-save-hook
;; 						'check-parens
;; 						nil t))))

;; (autoload 'markdown-mode "markdown-mode"
;;    "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(use-package markdown-mode :ensure t
  :mode (("\\.md$" . markdown-mode)
		 ("\\.markdown$" . markdown-mode))
  )

(provide '52_markdown)
;;; 52_markdown.el ends here
