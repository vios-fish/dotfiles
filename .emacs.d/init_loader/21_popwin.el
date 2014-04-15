;;;
;;; popwin
;;; バッファをホップアップウィンドウで表示
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
;; anythingバッファをボップアップ表示
(setq anything-samewindow nil)
(push '("*helm*" :height 20) popwin:special-display-config)
(push '(" *my-anything-filelist+*" :height 30) popwin:special-display-config)
(push '("*undo-tree*" :height 30) popwin:special-display-config)
;; diredバッファをボップアップ表示
(push '(dired-mode :position top) popwin:special-display-config)

