;;; 47_rtags.el ---

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

(use-package rtags
  :ensure t
  :init
  (rtags-enable-standard-keybindings c-mode-base-map)
  (bind-keys :map c-mode-base-map
		("C-." . rtags-find-symbol)
		("C-," . rtags-find-references)
		("M-." . rtags-find-symbol-at-point)
		("M-," . rtags-find-references-at-point)
		("C-c i" . rtags-imenu)
		("C-{" . rtags-location-stack-back)
		("C-}" . rtags-location-stack-forward))
  
  :config
  (rtags-start-process-unless-running)
  (custom-set-variables '(rtags-use-helm t))
  (cmake-ide-setup))


(provide '47_rtags)
;;; 47_rtags.el ends here
