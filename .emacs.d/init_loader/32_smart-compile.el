;;;smart-compile
(require 'smart-compile)
(setq smart-compile-option-string "-std=c++11")
(global-set-key "\C-cc" 'smart-compile)
(define-key menu-bar-tools-menu [compile] '("Compile..." . smart-compile))
