;;; 53_docker.el --- elisp for docker                -*- lexical-binding: t; -*-

;; Copyright (C) 2017  徳永誠

;; Author: 徳永誠 <tokunagamakoto@TokunagaMB.local>
;; Keywords:

;;; Code:

;; docker package
(use-package docker)

;; dockerfile mode
(use-package dockerfile-mode

  :mode (("Dockerfile\\'" . dockerfile-mode))
  )


(provide '53_docker)
;;; 53_docker.el ends here

