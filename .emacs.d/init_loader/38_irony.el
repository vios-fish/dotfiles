;;; 38_irony.el ---                                  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  vios-fish

;; Author: 徳永誠 <vios-fish@MB.local>
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
  :defer t
  
  :init
  (add-hook 'c-mode-common-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  
  :config
  (custom-set-variables '(irony-additional-clang-options '("-std=c++1y")))
  (use-package company
	:config
	(add-to-list 'company-backends 'company-irony))
  )

(require 'irony)

(provide '38_irony)
;;; 38_irony.el ends here
