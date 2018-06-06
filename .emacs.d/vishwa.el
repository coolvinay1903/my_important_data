;;---------------------------------------------------------------------------------
;; MELPA
;;---------------------------------------------------------------------------------
( when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))


;;---------------------------------------------------------------------------------
;; show parenthesis
;;---------------------------------------------------------------------------------
(show-paren-mode 1)
(when (>= emacs-major-version 24)
  (require 'smartparens-config))

;;---------------------------------------------------------------------------------
;; smex
;;---------------------------------------------------------------------------------
(setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;;---------------------------------------------------------------------------------
;; scroll bar , menu bar tool bar
;;---------------------------------------------------------------------------------
;; (scroll-bar-mode -1)
;; (tool-bar-mode -1)
;; (menu-bar-mode -1)

;;---------------------------------------------------------------------------------
;; marking text
;;---------------------------------------------------------------------------------
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;;---------------------------------------------------------------------------------
;; for yes and no I can use y and n
;;---------------------------------------------------------------------------------
(defalias 'yes-or-no-p 'y-or-n-p)


;;---------------------------------------------------------------------------------
;; display column number
;;---------------------------------------------------------------------------------
(setq column-number-mode t)

;;---------------------------------------------------------------------------------
;; auto complete 
;;---------------------------------------------------------------------------------
;(require 'auto-complete-config)
;(ac-config-default)

;;---------------------------------------------------------------------------------
;; flyspell
;;---------------------------------------------------------------------------------
(setq flyspell-issue-welcome-flag nil)
(if (eq system-type 'darwin)
    (setq-default ispell-program-name "/usr/local/bin/aspell")
  (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-list-command "list")

;; for company mode
;(add-hook 'after-init-hook 'global-company-mode)
;(setq company-backends (delete 'company-semantic company-backends))
;(define-key c-mode-map  [(tab)] 'company-complete)
;(define-key c++-mode-map  [(tab)] 'company-complete)
;(add-to-list 'company-backends 'company-c-headers)

;; yasnippets
(when (>= emacs-major-version 24)
  (add-to-list 'load-path
	       "~/.emacs.d/plugins/yasnippet")
  (require 'yasnippet)
  (yas-global-mode 1) )

;; ace-window
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-background nil)

;;recentf
(require 'recentf)
;;(setq recentf-save-file "(getenv "VOB_ROOT")/recentf")
(setq recentf-save-file (expand-file-name "recentf" (getenv "VOB_ROOT")))
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)
(global-set-key [(meta f12)] 'recentf-open-files)

;; For desktop-saving

;; Automatically save and restore sessions
(setq desktop-dirname             (getenv "MED_TBX_HOME")
      desktop-base-file-name      ".emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil)
(desktop-save-mode 0)
;; ;; save a list of open files in ~/.emacs.desktop
;; ;; save the desktop file automatically if it already exists
;; ;; (setq desktop-save 'if-exists)
;; (setq desktop-dirname "$VOB_ROOT")
;; (setq desktop-path (list desktop-dirname))
;; ;;(setq desktop-base-file-name ".emacs.desktop")
;; (desktop-save-mode 1)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

(add-hook 'occur-hook
          '(lambda ()
             (switch-to-buffer-other-window "*Occur*")))

(global-set-key (kbd "<C-tab>") 'other-window) ; cursor to other pane

;;(getenv "TBX_SOURCE")/behavc/source/bin/behavc_sis--linux-gcc620-64-vle-debug"
;;(setq gud-gdb-command-name "gdb -i=mi (expand-file-name "recentf" (getenv "TBX_SOURCE"))") 
(setq gud-gdb-command-name  (concat
                             "gdb -i=mi "
                             (getenv "TBX_SOURCE")
                             "behavc/source/bin/behavc_sis--linux-gcc472-64-vle-debug"
                             )
      )
(require 'company)
(add-hook 'c-mode-hook ' company-mode 1)
(add-hook 'c-mode-hook ' linum-mode 1)
(add-hook 'c++-mode-hook ' company-mode 1)
(add-hook 'c++-mode-hook ' linum-mode 1)
(setq cscope-use-face 1)
(add-hook 'verilog-mode-hook ' company-mode 1)
(add-hook 'verilog-mode-hook ' linum-mode 1)

(which-function-mode 1)
(electric-pair-mode 1)

;; override search key binding
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)


(setq-default indent-tabs-mode nil)
;;(c-basic-offset 4)
(c-set-offset 'substatement-open 0)

(setq verilog-auto-newline nil)

(defun my-c-mode-font-lock-if0 (limit)
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-min))
      (let ((depth 0) str start start-depth)
        (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
          (setq str (match-string 1))
          (if (string= str "if")
              (progn
                (setq depth (1+ depth))
                (when (and (null start) (looking-at "\\s-+0"))
                  (setq start (match-end 0)
                        start-depth depth)))
            (when (and start (= depth start-depth))
              (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
              (setq start nil))
            (when (string= str "endif")
              (setq depth (1- depth)))))
        (when (and start (> depth 0))
          (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
  nil)

(defun my-c-mode-common-hook ()
  (font-lock-add-keywords
   nil
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(c-set-offset 'case-label '+)

(setq select-enable-clipboard t)
