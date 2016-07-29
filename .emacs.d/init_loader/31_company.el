;; Copyright (C) 2016  vios-fish

;; Author: vios-fish
;; Keywords: lisp

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

(defun company--insert-candidate2 (candidate)
  (when (> (length candidate) 0)
	(setq candidate (substring-no-properties candidate))
	(if (eq (company-call-backend 'ignore-case) 'keep-prefix)
		(insert (company-strip-prefix candidate))
	  (if (equal company-prefix candidate)
		  (company-select-next)
		(delete-region (- (point) (length company-prefix)) (point))
		(insert candidate))
	  )))

(defun company-complete-common2 ()
  (interactive)
  (when (company-manual-begin)
	(if (and (not (cdr company-candidates))
			 (equal company-common (car company-candidates)))
		(company-complete-selection)
	  (company--insert-candidate2 company-common))))

(use-package company
  :ensure t
  :init (progn (global-company-mode))
  :bind (("tab" . company-complete))
  :config
  (setq company-idle-delay nil) ;; 自動補完無効
  (setq company-minimum-prefix-length 2) 
  (setq company-selection-wrap-around t)
  (bind-keys :map company-active-map
			 ("tab" . company-complete-common2)
			 ("backtab" . company-select-previous)
			 ("M-n" . nil)
			 ("M-p" . nil)
			 ("C-n" . company-select-next)
			 ("C-p" . company-select-previous)
			 ("C-h" . nil)
			 ("C-s" . company-filter-candidates))
  )

(provide '31_company)
;;; 31_company.el ends here
