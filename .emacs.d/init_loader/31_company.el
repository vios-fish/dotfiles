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

;; yasnippet and company
(defun check-expansion ()
  (save-excursion
	(if (looking-at "\\_>") t
	  (backward-char 1)
	  (if (looking-at "\\.") t
		(backward-char 1)
		(if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
	(yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
	  (minibuffer-complete)
	(if (or (not yas-minor-mode)
			(null (do-yas-expand)))
		(if (check-expansion)
			(company-complete-common)
		  (indent-for-tab-command)))))

(use-package company
  :init (progn (add-hook 'after-init-hook 'global-company-mode))
  
  :bind ("TAB" . tab-indent-or-complete)
  
  :config
  (setq company-idle-delay nil) ;; 自動補完無効
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (bind-keys :map company-active-map
			 ([tab] . company-complete-common2)
			 ("<backtab>" . company-select-previous)
			 ("M-n" . nil)
			 ("M-p" . nil)
			 ("C-n" . company-select-next)
			 ("C-p" . company-select-previous)
			 ("C-h" . nil)
			 ("C-s" . company-filter-candidates))
  (bind-keys :map company-search-map
			 ("C-n" . company-select-next)
			 ("C-p" . company-select-previous)
			 ([tab] . company-complete-common2)))

(provide '31_company)
;;; 31_company.el ends here
