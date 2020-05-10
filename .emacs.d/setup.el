;;; setup.el --- 

;; Copyright (C) 2014  makoto tokunaga

;; Author: makoto tokunaga
;; Keywords: lisp


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(provide 'setup)
