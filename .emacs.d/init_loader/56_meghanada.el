;;; 56_meghanada.el ---                              -*- lexical-binding: t; -*-

;; Copyright (C) 2017

;; Author:  <works@TOKUNAGA_M>
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

(use-package autodisass-java-bytecode
  :ensure t
  :defer t)

;; (use-package google-c-style
;;   :defer t
;;   :ensure t
;;   :commands
;;   (google-set-c-style))

(use-package meghanada
  :defer t
  :init
  (add-hook 'java-mode-hook
            (lambda ()
              ;(google-set-c-style)
              ;(google-make-newline-indent)
              (meghanada-mode t)
              (smartparens-mode t)
              (rainbow-delimiters-mode t)
              (highlight-symbol-mode t)
              (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))

  :config
  (use-package realgud
    :ensure t)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq c-basic-offset 4)
  (setq meghanada-server-remote-debug t)
  (setq meghanada-javac-xlint "-Xlint:all,-processing")
  :bind
  (:map meghanada-mode-map
        ("C-S-t" . meghanada-switch-testcase)
        ("M-RET" . meghanada-local-variable)
        ("C-M-." . helm-imenu)
        ("M-r" . meghanada-reference)
        ("M-t" . meghanada-typeinfo)
        ("C-z" . hydra-meghanada/body))
  :commands
  (meghanada-mode))

;; (defhydra hydra-megyhanada (:hint nil :exit t)
;; "
;; ^Edit^                           ^Tast or Task^
;; ^^^^^^-------------------------------------------------------
;; _f_: meghanada-compile-file      _m_: meghanada-restart
;; _c_: meghanada-compile-project   _t_: meghanada-run-task
;; _o_: meghanada-optimize-import   _j_: meghanada-run-junit-test-case
;; _s_: meghanada-switch-test-case  _J_: meghanada-run-junit-class
;; _v_: meghanada-local-variable    _R_: meghanada-run-junit-recent
;; _i_: meghanada-import-all        _r_: meghanada-reference
;; _g_: magit-status                _T_: meghanada-typeinfo
;; _l_: helm-ls-git-ls
;; _q_: exit
;; "
;;   ("f" meghanada-compile-file)
;;   ("m" meghanada-restart)

;;   ("c" meghanada-compile-project)
;;   ("o" meghanada-optimize-import)
;;   ("s" meghanada-switch-test-case)
;;   ("v" meghanada-local-variable)
;;   ("i" meghanada-import-all)

;;   ("g" magit-status)
;;   ("l" helm-ls-git-ls)

;;   ("t" meghanada-run-task)
;;   ("T" meghanada-typeinfo)
;;   ("j" meghanada-run-junit-test-case)
;;   ("J" meghanada-run-junit-class)
;;   ("R" meghanada-run-junit-recent)
;;   ("r" meghanada-reference)

;;   ("q" exit)
;;   ("z" nil "leave"))


(provide '56_meghanada)
;;; 56_meghanada.el ends here
