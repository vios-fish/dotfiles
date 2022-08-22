;;; 49_semantic-refactor.el ---                      -*- lexical-binding: t; -*-
;; Copyright (C) 2016  tokunaga

;; Author: tokunaga <tokunaga@tokunaga-Ubuntu16>
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

(use-package srefactor :defer t
  :init
  (semantic-mode 1)
  (bind-key "M-RET" 'srefactor-refactor-at-point c-mode-map)
  (bind-key "M-RET" 'srefactor-refactor-at-point c++-mode-map)
  (bind-keys
   ("M-RET o" . srefactor-lisp-one-line)
   ("M-RET m" . srefactor-lisp-format-sexp)
   ("M-RET d" . srefactor-lisp-format-defun)
   ("M-RET b" . srefactor-lisp-format-buffer))
  )
(provide '49_semantic-refactor)
;;; 49_semantic-refactor.el ends here
