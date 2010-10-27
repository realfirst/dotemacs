;-*- coding: utf-8 -*-
;
; ding.je's .emacs for GUN/Emacs 23.2 on Arch GNU/Linux


;{{{ Initialization
;
;; Define the load path
(setq load-path (cons "~/.emacs.d/" load-path))
(add-to-list 'load-path "~/.emacs.d/lib")

;; Load CEDET
;(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")

;; Turn off the toolbar
(tool-bar-mode -1)
;; 
;; Turn off the menu bar
(menu-bar-mode -1)
;; 
;; Turn off the scrollbar
(scroll-bar-mode -1)
;}}}


;{{{ Look & Feel
;
;; Default font


;; Color theme initialization
;;   - http://emacswiki.org/cgi-bin/wiki/ColorTheme
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
;; 
;; Load preferred theme
;;   - http://www.brockman.se/software/zenburn/zenburn.el
;(require 'zenburn)
;(color-theme-zenburn)

;; Support 256 colors in screen
;; - http://article.gmane.org/gmane.emacs.devel/109504/
(if (not (window-system)) (load "term/rxvt"))
(defun terninal-init-screen ()
  "Terminal initialization function for screen."
  ;; Use the rxvt color initialization code.
  (rxvt-register-default-colors)
  (tty-set-up-initial-frame-faces)
)

;; Don't show the welcome message
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; Shut off message buffer
(setq message-log-max nil)
(kill-buffer "*Messages*")		

;; Show column number in modeline
(setq column-number-mode t)

;; Modeline setup
;; - somewhat cleaner than default
(setq default-mode-line-format
      '("-"
	mode-line-mule-info
	mode-line-modified
	mode-line-frame-identification
	mode-line-buffer-identification
	"   "
	global-mode-string
	"   %[(" mode-name mode-line-process minor-mode-alist "%n"")%]--"
	(line-number-mode "L%l--")
	(column-number-mode "C%c--")
	(-3 . "%p")
	"-%-")
)
;; show battery status in modeline
(display-battery-mode 1)

;; Date in mode line
(display-time)

;; Set window title according to buffer name
(setq frame-title-format '("emacs: %f"))

;; Syntax coloring (font-lock-mode)
(global-font-lock-mode t)

;; Always flash for parens and define a more distinctive color
(show-paren-mode 1)
(set-face-foreground 'show-paren-match-face "#bc8383")

;; Answer y or n instead of yes or no at prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; Use ANSI colors within shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; transparent the emacs background
;; (eval-when-compile (require 'cl))
;;  (defun toggle-transparency ()
;;    (interactive)
;;    (if (/=
;;         (cadr (frame-parameter nil 'alpha))
;;         100)
;;        (set-frame-parameter nil 'alpha '(100 100))
;;      (set-frame-parameter nil 'alpha '(85 50))))
;;  (global-set-key (kbd "C-c t") 'toggle-transparency)
;; (set-frame-parameter (selected-frame) 'alpha '(85 50))
;; (add-to-list 'default-frame-alist '(alpha 85 50))

;}}}
;
;
;; Window Fringes
(require 'fringe)
(setq default-indicate-buffer-boundaries 'left) ; Indicate the
(setq default-indicate-empty-lines t)           ; Display an in
(fringe-mode 'default)

;{{{ General settings
;
;; Provide an error trace if loading .emacs fails
(setq debug-on-error t)

;; Encoding
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(setq local-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; Spell checking				
(setq-default ispell-program-name "aspell")
;   ispell-extra-args '("--sug-mode=ultra"))
;(setq-default ispell-dictionary "en_US")

;; Default Web Browser
(setq browse-url-browset-function 'browse-url-firefox)

;; Show unfinished keystrokes early
(setq echo-keystrokes 0.1)

;; Ignore case on completion
(setq completion-ingore-case t
   read-file-name-completion-ingnore-case t)

;; Save after a certion amount of time.
(setq auto-save-timeout 1800)
;; 
;; Change backup behavior to save in a specified directory
(setq backup-directorty-alist '(("." . "~/.emacs.d/saves/"))
   backup-by-copying     t
   version-control t
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
)

;; Keep bookmarks in load path
(setq bookmark-default-file "~/.emacs.d/emacs-bookmarks")

;; Keep abbreviations in load path
(setq abbrev-file-name "~/.emacs.d/emacs-abbrev-defs")

;; Default major mode
(setq default-major-mode 'text-mode)
;; 
;; Warp lines at 70 in text-mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; 
;; Text files end in new lines.
(setq require-final-newline t)

;; Narrowing enabled
(put 'narrow-to-region 'disabled nil)
;; 支持emacs和外部程序的黏贴
(setq x-select-enable-clipboard t)
;
;}}}


;{{{ Mouse and cursor settings
;
;; Enable mouse scrolling
(mouse-wheel-mode t)

;; Push the mouse out of the way on cursor approach
(mouse-avoidance-mode 'jump)

;; Stop cursor from blinking
(blink-cursor-mode nil)

;; Accelerate the cursor when scrolling
(load "accel" t t)
;; 
;; Start scrolling when 2 lines from top/bottom
(setq scroll-margin 2)
;; 
;; Fix the scrolling on jumps between windows
(setq scroll-conservatively 5)

;; Coursor in same relative row and column during PgUP/DN
(setq scroll-preserve-screen-postion t)

;; Copy/paste with accentuation intact
(setq selection-coding-system 'compound-text-with-extensions)

;; Delete selection on a key press
(delete-selection-mode t)
;}}}


;{{{ Setting for various modes
;    - major modes for editing code and other formats are defined now


;; Linum (line numbering)
(require 'linum)
;; - do not enable by default,breaks org-mode
;(global-linum-mode)

(add-to-list 'load-path "~/.emacs.d/site-lisp/yas")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/site-lisp/yas/snippets")




(require 'ibus)
 ;; Turn on ibus-mode automatically after loading .emacs
 (add-hook 'after-init-hook 'ibus-mode-on)
 ;; Use C-SPC for Set Mark command
 (ibus-define-common-key ?\C-\s nil)
 ;; Use C-/ for Undo command
 (ibus-define-common-key ?\C-/ nil)
 ;; Change cursor color depending on IBus status
; (setq ibus-cursor-color '("red" "blue" "limegreen"))
;; Use s-SPC to toggle input status
(global-set-key (kbd "s-SPC") 'ibus-toggle)



;{{{ Setting for various modes
;    - major modes for editing code and other formats are defined below
;
;; ;; Auctex
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
;; ;
;; ;; 在工具栏显示编辑按钮
;; ;(add-hook 'LaTex-mode-hook 'LaTex-install-toolbar)
;; ;
;; (autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
;; (autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
;; (autoload 'reftex-citation "reftex-cite" "Make citation" nil)  
;; (autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
;; (autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
;; (autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
;; (add-hook 'TeX-mode-hook
;;           (lambda ()
;;             (turn-on-reftex)
;;             (auto-fill-mode)
;;             (outline-minor-mode)
;; 	    (menu-bar-mode 1)
;; 	    (tool-bar-mode 1)
;;             (flyspell-mode)))
;; (add-hook 'LaTeX-mode-hook
;;           (lambda ()
;;             (LaTeX-math-mode)
;;             (turn-on-cdlatex)
;;             (turn-on-reftex)
;;             (auto-fill-mode)
;;             (outline-minor-mode)
;; 	    (menu-bar-mode 1)
;; 	    (tool-bar-mode 1)
;;             (flyspell-mode)))
;; ;; copy from http://soundandcomplete.com/2010/05/13/emacs-as-the-ultimate-latex-editor/
;; (require 'flymake)

;; (defun flymake-get-tex-args (file-name)
;; (list "pdflatex"
;; (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

;; (add-hook 'LaTeX-mode-hook 'flymake-mode)

;; (setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
;; (setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;;{{{ GNU Plot mode
;;--------------------------------------------------------------------
;; Lines enabling gnuplot-mode

;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))

;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode 
  (global-set-key [(f9)] 'gnuplot-make-buffer)

;; end of line for gnuplot-mode
;;--------------------------------------------------------------------

;{{{ emms
(require 'emms-setup)
(emms-standard)
(emms-default-players)
;}}}

;{{{ Main bindings
;
;; C-w to backward kill for compatibility (and ease of use)
(global-set-key "\C-w" 'backward-kill-word)
;; ...and then provide alternative for cutting
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
;}}}

;{{{ Fn bindings
;
(global-set-key  [f6]  'linum-mode)               ; Toggle line numbering
;(global-set-key  [f11] 'speedbar)
(global-set-key  [f12] 'kill-buffer)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; ------------------------------------------------
;; programming tools & languages
;(load "~/emacs/config/cedet-config.el")
;(load "~/emacs/config/jde-config.el")
(load "~/emacs/config/tex-config.el")
;(load "~/emacs/config/anything-config.el")
;(require 'anything-config)

;;; 全屏
(defvar my-fullscreen-p t "Check if fullscreen is on or off")

(defun my-non-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
	  ;; WM_SYSCOMMAND restore #xf120
	  (w32-send-sys-command 61728)
	(progn (set-frame-parameter nil 'width 90)
		   (set-frame-parameter nil 'fullscreen 'fullheight))))

(defun my-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
	  ;; WM_SYSCOMMAND maximaze #xf030
	  (w32-send-sys-command 61488)
	(set-frame-parameter nil 'fullscreen 'fullboth)))

(defun my-toggle-fullscreen ()
  (interactive)
  (setq my-fullscreen-p (not my-fullscreen-p))
  (if my-fullscreen-p
	  (my-non-fullscreen)
	(my-fullscreen)))

(global-set-key [f11] 'my-toggle-fullscreen)
(set-cursor-color "green")

;; emacs24

;; hour 3
;; hightlight regions in gnu emacs
;(transient-mark-mode)

;; this also was metioned in sachachua's dotemacs.el
(icomplete-mode 1)

;; hour 4
(setq next-line-add-newlines t)

(global-set-key [(meta left)] 'backward-sexp)
(global-set-key [(meta right)] 'forward-sexp)
;; moving to a line specified by a number

(global-set-key [(meta g)] 'goto-line)
;; set template home directory
(setq template-home-directory "/")

(setq tramp-default-method "ssh")

;; hour 5
(require 'undo-tree)
;; C-_ & M-_ for regular undo/redo. C-x u to enter the fancy visualiiser
(global-undo-tree-mode)

;; keeping all the backup files in one directroy
(require 'backup-dir)
(setq  bkup-backup-directory-info '((t "/home/arch/backups" ok-create full-path)))


;; hour 6
(load-library "yic-buffer")
;; bind it to Ctrl-Page-Up and Ctrl-Page-Down
(global-set-key [(control prior)] 'bury-buffer)
(global-set-key [(control next)] 'yic-next-buffer)

(require 'iswitchb)
(iswitchb-default-keybindings)

;; saving the buffer list
(load "desktop")
(desktop-load-default)
(desktop-read)

;; resize minibuffer dynamically to use enough space
;; to show all its content at any give time
; (resize-minibuffer-mode)

;; to tell emacs which buffers it must create dedicated frame for
(setq special-display-buffer-names '("*Help*" "*Apropos*" 
                                     "*compilation*" "*grep*" "*igrep*")) 

;; hour 7
; (setq search-exit-option t)

;; make emacs to always match using case
;(setq-default case-fold-search nil)

;; enable highlighting when searching
(setq search-highlight t)

;; highlight matches when using search-and-replace
(setq query-replace-highlight t)

;; to interpret line breaks as ordinary spaces in incremental search
(setq search-whitespace-regexp "[ \t\r\n]+")

(message ".emacs loaded")







