;;; 55_yaml.el ---                                   -*- lexical-binding: t; -*-
;; Copyright (C) 2017

;; Author:  <works@TOKUNAGA_M>
;; Keywords: yaml elisp

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

(use-package yaml-mode :ensure t
  :mode ("\\.ya?ml$" . yaml-mode)
  :bind (:map yaml-mode-map
			  ("\C-m" . newline-and-indent))
  )

(provide '55_yaml)
;;; 55_yaml.el ends here
