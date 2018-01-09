;;; 05-mew.el --- 

;; Copyright (C) 2014  vios.fish

;; Author: tokunaga <vios.fish@vios.fish-AX877AV-ABJ-HPE-190jp>
;; Keywords: abbrev, mail

;; Gmail 受信用のIMAP設定

(setq mew-proto "%")
(setq mew-user "vios.fish@gmail.com")
(setq mew-mail-domain "gmail.com")
(setq mew-imap-server "imap.gmail.com")
(setq mew-imap-user "vios.fish@gmail.com")
(setq mew-imap-auth t)
(setq mew-imap-ssl t)
(setq mew-imap-ssl-port "993")
;; Gmail 送信用のSMTP設定
(setq mew-smtp-server "smtp.gmail.com")
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "vios.fish@gmail.com")
(setq mew-smtp-auth t)
(setq mew-smtp-ssl t)

(setq mew-ssl-verify-level 0)
(setq mew-use-cached-passwd t)
(setq mew-fcc "%Sent")
(setq mew-imap-trash-folder"%[Gmail]/ゴミ箱")

