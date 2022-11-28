;;;;;;;;;;;;;;;;;;;;;;;;;
;; set-up installation ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; first, declare repositories
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))

;; Init the package facility
(require 'package)
(package-initialize)
;; (package-refresh-contents) ;; this line is commented 
;; since refreshing packages is time-consuming and should be done on demand

;; Declare packages
(setq my-packages
      '(beacon
        highlight-parentheses
        rainbow-delimiters))

;; Iterate on packages and install missing ones
(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;;;;;;;;;;;;;;;;;;;
;; extra settings ;;
;;;;;;;;;;;;;;;;;;;;
      (defun move-forward-paren (&optional arg)
       "Move forward parenthesis"
        (interactive "P")
        (if (looking-at ")") (forward-char 1))
        (while (not (looking-at ")")) (forward-char 1))
      ) 
      
      (defun move-backward-paren (&optional arg)
       "Move backward parenthesis"
        (interactive "P")
        (if (looking-at "(") (forward-char -1))
        (while (not (looking-at "(")) (backward-char 1))
      ) 
      
      (defun move-forward-sqrParen (&optional arg)
       "Move forward square brackets"
        (interactive "P")
        (if (looking-at "]") (forward-char 1))
        (while (not (looking-at "]")) (forward-char 1))
      ) 
      
      (defun move-backward-sqrParen (&optional arg)
       "Move backward square brackets"
        (interactive "P")
        (if (looking-at "[[]") (forward-char -1))
        (while (not (looking-at "[[]")) (backward-char 1))
      ) 
      
      (defun move-forward-curlyParen (&optional arg)
       "Move forward curly brackets"
        (interactive "P")
        (if (looking-at "}") (forward-char 1))
        (while (not (looking-at "}")) (forward-char 1))
      ) 
      
      (defun move-backward-curlyParen (&optional arg)
       "Move backward curly brackets"
        (interactive "P")
        (if (looking-at "{") (forward-char -1))
        (while (not (looking-at "{")) (backward-char 1))
      ) 

;;;;;;;;;;;;;;;;;;;;;;
;; startup settings ;; + aesthetics
;;;;;;;;;;;;;;;;;;;;;;

;; start up so I don't have to do M-x <commands>
(add-hook 'prog-mode-hook #'highlight-parentheses-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; makes the cursortext blink when scrolling around
;(beacon-mode 1)

;; autocomplete paired brackets
(electric-pair-mode 1)

;; makes emacs maximize to the monitor size by making the 1st startup frame fullscreen sized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; sets the highlight color
(set-face-attribute 'region nil :background "#cdb924")

;; disables backup files (ends in ~). This is different from the autosave files (contains #) that gets auto deleted
(setq make-backup-files nil)

;;;;;;;;;;;;;;;;;;;;;;;;
;; M-x compile changes;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Set up for M-x compile command. Default is no longer "make -k"
(setq compile-command "")

;;;;;;;;;;;;;;;;;;
;; custom hotkey;;
;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "<f5>") 'compile)


(global-set-key (kbd "M-)")           (quote move-forward-paren))
(global-set-key (kbd "M-(")           (quote move-backward-paren))
      
(global-set-key (kbd "M-]")           (quote move-forward-sqrParen))
(global-set-key (kbd "M-[")           (quote move-backward-sqrParen))

;;this conflicts with and overrides emac's default M-{ and M-} which are paragraph navigations      
(global-set-key (kbd "M-}")           (quote move-forward-curlyParen))
(global-set-key (kbd "M-{")           (quote move-backward-curlyParen))


;;goes to end of line, adds semicolon, makes new line below the current line
(global-set-key (kbd "C-;")
  (lambda ()
    (interactive)
    (end-of-line)
    (insert ";")
    (newline-and-indent)
))

;;goes to end of line, adds semicolon, makes new line above the current line. the colon is used because that's the semicolon key except with shift pressed
(global-set-key (kbd "C-:")
  (lambda ()
    (interactive)
    (end-of-line)
    (insert ";")
    (previous-line)
    (newline-and-indent)
))


;; goes to the end of the current line, adds semicolon
;; this conflicts with and overrides emac's default hotkey of "comment-dwim" // not much of a loss
(global-set-key (kbd "M-;")
  (lambda ()
    (interactive)
    (end-of-line)
    (insert ";")
))
