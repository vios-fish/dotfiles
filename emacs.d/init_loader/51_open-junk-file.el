(use-package open-junk-file
    :ensure t
    :config
    (setq open-junk-file-format (concat my/dotfiles-dir "/junk/%Y/%m/%Y-%m-%d-%H%M%S."))
    (global-set-key (kbd "C-x j") 'open-junk-file)
)
