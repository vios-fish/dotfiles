;;; 38_irony.el ---                                  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  徳永誠

;; Author: 徳永誠 <tokunagamakoto@TokunagaMB.local>
;; Keywords: abbrev, abbrev

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

(use-package irony
  :ensure t
  :defer t
  
  :init
  (add-hook 'c-mode-common-hook 'irony-mode)
  
  :config
  (custom-set-variables '(irony-additional-clang-options '("-std=c++1y")))
  (use-package company
	:config
	(add-to-list 'company-backends 'company-irony))  
  (irony-cdb-autosetup-compile-options)
  )

(provide '38_irony)
;;; 38_irony.el ends here
