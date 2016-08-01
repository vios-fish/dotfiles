;;; undo-tree
;;; undo,redoを木状にしてやりやすくする

(use-package undo-tree :diminish "UT"
  :after popwin
  :init
  (global-undo-tree-mode)
  
  :config
  (push '("*undo-tree*" :height 30) popwin:special-display-config))

