;;; 38_irony.el ---

;; Copyright (C) 2016  vios-fish

;; Author: vios-fish <vios-fish@MB.local>
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

(use-package irony :defer t
  :diminish "irony"
 
  :init
  (progn
	(add-hook 'c-mode-hook 'irony-mode)
	(add-hook 'c++-mode-hook 'irony-mode))
  
  :config
  ;; replace the `completion-at-point' and `complete-symbol' bindeings in
  ;; irony-mode's buffers by irony-mode's function
  (bind-key [remap completion-at-point] 'irony-completion-at-point-async irony-mode-map)
  (bind-key [remap complete-symbol] 'irony-completion-at-point-async irony-mode-map)

  
  (custom-set-variables '(irony-additional-clang-options '("-std=c++1y")))
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company-irony
  :config
  (company-irony-setup-begin-commands)
  (add-to-list 'company-backends 'company-irony))


(use-package flycheck-irony
  :config
  (flycheck-irony-setup))


(provide '38_irony)
;;; 38_irony.el ends here
