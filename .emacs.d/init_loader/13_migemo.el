<<<<<<< HEAD
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
=======
(cond ((eq linux-p t)
	   (setq migemo-dictionary "/usr/share/migemo/utf-8/migemo-dict"))
	  ((eq carbon-p t)
	   (setq migemo-directory "/usr/local/share/migemo/utf-8/migemo-dict")
	  ))
>>>>>>> 2d36fee8445df79fb79db3d3cf785db3b1a23640
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-user-dictionary nil)
(setq migemo-coding-system 'utf-8)
(setq migemo-regex-dictionary nil)
(load-library "migemo")
(migemo-init)
