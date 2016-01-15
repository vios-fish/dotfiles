;;
;; YaTeX
;;
(add-to-list 'load-path (concat my/emacs-directory "/elisps/yatex"))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)


(when ns-p
  (setq YaTeX-dvipdf-command "/Library/TeX/texbin/dvipdfmx")
  (setq YaTeX-dvi2-command-ext-alist
        '(("[agx]dvi\\|PictPrinter\\|Mxdvi" . ".dvi")
          ("gv" . ".ps")
          ("Preview\\|TeXShop\\|TeXworks\\|Skim\\|mupdf\\|xpdf\\|Adobe" . ".pdf")))
  (setq tex-command "platex"   ; eucの場合はplatex2pdf-euc
        dvi2-command "open -a Preview")  ; Preview.appを使ってPDFを開く
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/platex -synctex=1/' -e '$bibtex=q/pbibtex/' -e '$makeindex=q/mendex/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/platex -synctex=1/' -e '$bibtex=q/pbibtex/' -e '$makeindex=q/mendex/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -g > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/uplatex -synctex=1/' -e '$bibtex=q/upbibtex/' -e '$makeindex=q/mendex/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/uplatex -synctex=1/' -e '$bibtex=q/upbibtex/' -e '$makeindex=q/mendex/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -u > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/pdflatex -synctex=1/' -e '$bibtex=q/bibtex/' -e '$makeindex=q/makeindex/' -norc -gg -pdf")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/lualatex -synctex=1/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -pdf")
                                        ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/xelatex -synctex=1/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -xelatex")
                                        ;(setq tex-command "/usr/texbin/platex -synctex=1")
                                        ;(setq tex-command "/usr/local/bin/pdfplatex")
                                        ;(setq tex-command "/usr/local/bin/pdfplatex2")
                                        ;(setq tex-command "/usr/texbin/uplatex -synctex=1")
                                        ;(setq tex-command "/usr/local/bin/pdfuplatex")
                                        ;(setq tex-command "/usr/local/bin/pdfuplatex2")
                                        ;(setq tex-command "/usr/texbin/pdflatex -synctex=1")
                                        ;(setq tex-command "/usr/texbin/lualatex -synctex=1")
                                        ;(setq tex-command "/usr/texbin/xelatex -synctex=1")
  (setq bibtex-command (cond ((string-match "uplatex" tex-command) "/usr/texbin/upbibtex")
                             ((string-match "platex" tex-command) "/Library/TeX/texbin/pbibtex")
                             ((string-match "lualatex\\|xelatex" tex-command) "/usr/texbin/bibtexu")
                             (t "/usr/texbin/bibtex")))
  (setq makeindex-command (cond ((string-match "uplatex" tex-command) "/usr/texbin/mendex")
                                ((string-match "platex" tex-command) "/Library/TeX/texbin/mendex")
                                ((string-match "lualatex\\|xelatex" tex-command) "/usr/texbin/texindy")
                                (t "/usr/texbin/makeindex")))
  (setq dvi2-command (cond ((string-match "pdf\\|lua\\|xe" tex-command) "/usr/bin/open -a Preview")
						   (t "open -a Preview")))
;                           (t "/usr/bin/open -a PictPrinter")))
  (setq dviprint-command-format "dvipdfmx %s")
;  (setq dviprint-command-format (cond ((string-match "pdf\\|lua\\|xe" tex-command) "/usr/bin/open -a \"Adobe Reader\" %s")
;                                      (t "/usr/bin/open -a \"Adobe Reader\" `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")))
  
  (defun skim-forward-search ()
    (interactive)
    (let* ((ctf (buffer-name))
           (mtf)
           (pf)
           (ln (format "%d" (line-number-at-pos)))
           (cmd "/Applications/Skim.app/Contents/SharedSupport/displayline")
           (args))
      (if (YaTeX-main-file-p)
          (setq mtf (buffer-name))
        (progn
          (if (equal YaTeX-parent-file nil)
              (save-excursion
                (YaTeX-visit-main t)))
          (setq mtf YaTeX-parent-file)))
      (setq pf (concat (car (split-string mtf "\\.")) ".pdf"))
      (setq args (concat ln " " pf " " ctf))
      (message (concat cmd " " args))
      (process-kill-without-query
       (start-process-shell-command "displayline" nil cmd args)))
    
    (add-hook 'yatex-mode-hook
              '(lambda ()
                 (define-key YaTeX-mode-map (kbd "C-c s") 'skim-forward-search)))))
(when windows-p
  (message "windwos32-tex")
  (setq tex-command "platex")
  (setq dvi2-command "c:/w32tex/dviout/dviout.exe")
  (setq dviprint-command-format "dvipdfmx %s "))

(when linux-p
  (setq tex-command "platex")
  (setq dvi2-command "pxdvi")
  (setq dviprint-command-format "evince %s "))


;; 何故かplatex等が使えなかったので(platex: command not foundとか表示される)pathを通す。
;; 必要なのは多分/usr/texbinだけだけど、コピペ元の設定をそのまま流用する。
;; (dolist (dir (list
;;               "/sbin"
;;               "/usr/sbin"
;;               "/bin"
;;               "/usr/bin"
;;               "/opt/local/bin"
;;               "/sw/bin"
;;               "/usr/local/bin"
;;               "/usr/texbin"
;;               (expand-file-name "~/bin")
;;               (expand-file-name "~/.emacs.d/bin")
;;               ))
;; ;; PATH と exec-path に同じ物を追加します
;;   (when (and (file-exists-p dir) (not (member dir exec-path)))
;;      (setenv "PATH" (concat dir ":" (getenv "PATH")))
;;   	  (setq exec-path (append (list dir) exec-path))))
	  

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))
;; templatefile
;(setq YaTeX-template-file (concat my/emacs-directory "/insert/template.tex"))


(when linux-p
  (defun evince-forward-search ()
	(interactive)
	(progn
	  (process-kill-without-query
	   (start-process
		"fwdevince"
		nil
		"fwdevince"
		(expand-file-name
		 (concat (file-name-sans-extension (or YaTeX-parent-file
											   (save-excursion
												 (YaTeX-visit-main t)
												 buffer-file-name)))
				 ".pdf"))
		(number-to-string (save-restriction
							(widen)
							(count-lines (point-min) (point))))
		(buffer-name)))))

  (add-hook 'yatex-mode-hook
			'(lambda ()
			   (define-key YaTeX-mode-map (kbd "C-c e") 'evince-forward-search)))

  (require 'dbus)

  (defun un-urlify (fname-or-url)
	"A trivial function that replaces a prefix of file:/// with just /."
	(if (string= (substring fname-or-url 0 8) "file:///")
		(substring fname-or-url 7)
	  fname-or-url))

  (defun evince-inverse-search (file linecol &rest ignored)
	(let* ((fname (un-urlify file))
		   (buf (find-file fname))
		   (line (car linecol))
		   (col (cadr linecol)))
	  (if (null buf)
		  (message "[Synctex]: %s is not opened..." fname)
		(switch-to-buffer buf)
		(goto-line (car linecol))
		(unless (= col -1)
		  (move-to-column col)))))

  (dbus-register-signal
   :session nil "/org/gnome/evince/Window/0"
   "org.gnome.evince.Window" "SyncSource"
   'evince-inverse-search)

  (defun okular-forward-search ()
	(interactive)
	(progn
	  (process-kill-without-query
	   (start-process
		"okular"
		nil
		"okular"
		"--unique"
		(concat (expand-file-name
				 (concat (file-name-sans-extension (or YaTeX-parent-file
													   (save-excursion
														 (YaTeX-visit-main t)
														 buffer-file-name)))
						 ".pdf"))
				"#src:"
				(number-to-string (save-restriction
									(widen)
									(count-lines (point-min) (point))))
				(buffer-file-name))))))

  (add-hook 'yatex-mode-hook
			'(lambda ()
			   (define-key YaTeX-mode-map (kbd "C-c o") 'okular-forward-search)))

  (defun qpdfview-forward-search ()
	(interactive)
	(progn
	  (process-kill-without-query
	   (start-process
		"qpdfview"
		nil
		"qpdfview"
		"--unique"
		(concat (expand-file-name
				 (concat (file-name-sans-extension (or YaTeX-parent-file
													   (save-excursion
														 (YaTeX-visit-main t)
														 buffer-file-name)))
						 ".pdf"))
				"#src:"
				(buffer-name)
				":"
				(number-to-string (save-restriction
									(widen)
									(count-lines (point-min) (point))))
				":0")))))

  (add-hook 'yatex-mode-hook
			'(lambda ()
			   (define-key YaTeX-mode-map (kbd "C-c q") 'qpdfview-forward-search)))

  (defun pdfviewer-forward-search ()
	(interactive)
	(progn
	  (process-kill-without-query
	   (start-process
		"pdfviewer"
		nil
		"pdfviewer"
		(concat "file:"
				(expand-file-name
				 (concat (file-name-sans-extension (or YaTeX-parent-file
													   (save-excursion
														 (YaTeX-visit-main t)
														 buffer-file-name)))
						 ".pdf"))
				"#src:"
				(number-to-string (save-restriction
									(widen)
									(count-lines (point-min) (point))))
				" "
				(buffer-name)))))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c p") 'pdfviewer-forward-search)))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))



;;
;; RefTeX with YaTeX
;;
(add-hook 'yatex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

;; popwinを用いてYaTexを表示
(require 'popwin)
(defadvice YaTeX-showup-buffer (around popwin:YaTeX-showup-buffer (buffer &optional func select) activate)
  (popwin:display-buffer-1 buffer
                           :default-config-keywords `(:noselect ,(not select))
                           :if-buffer-not-found :create
                           :if-config-not-found (lambda (buffer) ad-do-it)))

(push '("*YaTeX-typesetting*" :height 20) popwin:special-display-config)
(push '("*dvi-preview*" :height 15) popwin:special-display-config)

