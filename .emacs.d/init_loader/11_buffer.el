;;; バッファ名
;; ファイル名が重複していたらディレクトリ名を追加する。
(use-package uniquify
    :config
    (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
)


