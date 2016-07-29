;;; setup-el-get.el ---                              -*- lexical-binding: t; -*-

;; Copyright (C) 2016  vios-fish

;; Author: vios-fish;;; setup-el-get.el ---                              -*- lexical-binding: t; -*- <MBA>
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

(add-to-list 'load-path (locate-user-emacs-file "el-get/elget"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
	  (url-retrieve-synchronously
	   "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
	(goto-char (point-max))
	(eval-print-last-sexp)))

(provide 'setup-el-get)
;;; setup-el-get.el ends here
