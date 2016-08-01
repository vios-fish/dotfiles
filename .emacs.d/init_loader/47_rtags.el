;;; 47_rtags.el ---                                  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  tokunaga

;; Author: tokunaga
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

(use-package rtags :defer t
  :init (add-hook 'c-mode-common-hook 'rtags-mode)
  :config
  (when (rtags-is-indexed)
	(local-set-key (kbd "M-." 'rtags-find-symbol-at-point))
	(local-set-key (kbd "M-;" 'rtags-find-symbol))
	(local-set-key (kbd "M-@" 'rtags-find-references))
	(local-set-key (kbd "M-," 'rtags-location-stack-back))
	(custom-set-variables '(rtags-use-helm t))))

(provide '47_rtags)
;;; 47_rtags.el ends here
