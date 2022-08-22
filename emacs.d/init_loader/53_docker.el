;;; 53_docker.el --- elisp for docker                -*- lexical-binding: t; -*-

;; Copyright (C) 2017  vios-fish

;; Author: vios-fish <vios.fish@gmail.com>
;; Keywords:

;;; Code:

;; docker package
(use-package docker :ensure t)

;; dockerfile mode
(use-package dockerfile-mode
  :ensure t
  :mode (("Dockerfile\\'" . dockerfile-mode)))


(provide '53_docker)
;;; 53_docker.el ends here

