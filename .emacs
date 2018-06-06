;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; === SETUP ===
(require 'package) ;; You might already have this line

(setq  package-archives
     '(("melpa" . "http://melpa.org/packages/")
     ("org"         . "http://orgmode.org/elpa/")
;    ("gnu"         . "http://elpa.gnu.org/packages/")
))



;; === CUSTOM CHECK FUNCTION ===
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it's not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (unless (package-installed-p package)
       (package-install package)))
     packages)
)
(package-initialize)
;; === List my packages ===
;; simply add package names to the list
(ensure-package-installed
 'helm
 'helm-etags-plus
 'yasnippet
 'smartparens
 'moe-theme
 'helm-themes
 'helm-smex
 'helm-gtags
 'helm-fuzzy-find
 'helm-fuzzier
 'helm-cscope
 'helm-company
 'color-theme-solarized
 'color-theme-sanityinc-tomorrow
 'xcscope
 'calc
 'company
 'recentf
 'xcscope
 'yasnippet
 )
(load-file "~/.emacs.d/vishwa.el")
(load-file "~/.emacs.d/vinay.el")
(load-file "~/.emacs.d/vishwa_helm.el")
(load-file "~/.emacs.d/tbx.el")

(require 'xcscope)
(cscope-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#373b41"))
 '(beacon-color "#ff9da4")
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "b9cbfb43711effa2e0a7fbc99d5e7522d8d8c1c151a3194a4b176ec17c9a8215" "a19265ef7ecc16ac4579abb1635fd4e3e1185dcacbc01b7a43cf7ad107c27ced" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "b9a06c75084a7744b8a38cb48bc987de10d68f0317697ccbd894b2d0aca06d2b" default)))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(font-use-system-font nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode t)
 '(package-selected-packages
   (quote
    (helm helm-etags-plus yasnippet smartparens moe-theme helm-themes helm-smex helm-package helm-gtags helm-fuzzy-find helm-fuzzier helm-cscope helm-company color-theme-solarized color-theme-sanityinc-tomorrow)))
 '(select-active-regions t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "unknown" :slant normal :weight normal :height 100 :width normal)))))
(put 'erase-buffer 'disabled nil)
