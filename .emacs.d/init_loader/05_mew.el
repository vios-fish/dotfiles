;;; 05-mew.el --- 

;; Copyright (C) 2014  tokunaga

;; Author: tokunaga <tokunaga@tokunaga-AX877AV-ABJ-HPE-190jp>
;; Keywords: abbrev, mail

(require 'mew)
;; Gmail 用のIMAP設定
(setq mew-proto "%")
(setq mew-user "vios.fish@gmail.com")
(setq mew-mail-domain "gmail.com")
(setq mew-imap-server "imap.gmail.com")
(setq mew-imap-user "vios.fish@gmail.com")
(setq mew-imap-auth t)
(setq mew-imap-ssl t)
(setq mew-imap-ssl-port "993")
(setq mew-smtp-auth t)
(setq mew-smtp-ssl t)
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "vios.fish@gmail.com")
(setq mew-ssl-verify-level 0)
(setq mew-use-cached-passwd t)
(setq mew-fcc "%Sent")
(setq mew-imap-trash-folder"%[Gmail]/ゴミ箱")

