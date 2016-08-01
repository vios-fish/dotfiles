;;; undo-tree
;;; undo,redoを木状にしてやりやすくする

(use-package undo-tree
  :diminish "UT"
  :init
  (global-undo-tree-mode))

