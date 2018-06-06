;
; TBX routines for emacs

;
; Instructions:
;
; Add the following line to your Emacs init file ~/.emacs .
;
;   (load-file "<PATH>/tbx.el")
;
; Edit <PATH> as appropriate.
;
; Restart Emacs or load tbx.el manually (M-x load-file)
;
;
; The commands are now available using M-x tbx-...
;

;
; Load xcscope mode
                                        ;

(defun tbx-clean-build-behavc-debug-fast ()

  "Clean and Build Behavc(debug)"

  (interactive)
  (save-excursion
    (setq bufname "*behavc build (debug-fast)*")
    (set-buffer(get-buffer-create bufname))
    (setq buffer-read-only nil)
    (erase-buffer)
    (pop-to-buffer bufname)
    (compilation-mode)
    (message "Building behavc (debug engine)")(sit-for 0)
    (start-process "tbx_build_behavc_debug" bufname "~/build/behavc_build.sh" "-d" "-f")))

(defun tbx-clean-build-behavc-opt-fast ()

  "Clean and Build Behavc(Opt)"

  (interactive)
  (save-excursion
    (setq bufname "*behavc build (opt-fast)*")
    (set-buffer(get-buffer-create bufname))
    (setq buffer-read-only nil)
    (erase-buffer)
    (pop-to-buffer bufname)
    (compilation-mode)
    (message "Building behavc (opt engine)")(sit-for 0)
    (start-process "tbx_build_behavc_opt" bufname "~/build/behavc_build.sh" "-f")))

(defun tbx-clean-build-behavc-debug-veryfast ()

  "Clean and Build Behavc(debug)"

  (interactive)
  (save-excursion
    (setq bufname "*behavc build (debug-fast)*")
    (set-buffer(get-buffer-create bufname))
    (setq buffer-read-only nil)
    (erase-buffer)
    (pop-to-buffer bufname)
    (compilation-mode)
    (message "Building behavc (debug engine)")(sit-for 0)
    (start-process "tbx_build_behavc_debug" bufname "~/build/behavc_build.sh" "-d" "-vf")))

(defun tbx-clean-build-behavc-opt-veryfast ()

  "Clean and Build Behavc(Opt)"

  (interactive)
  (save-excursion
    (setq bufname "*behavc build (opt-fast)*")
    (set-buffer(get-buffer-create bufname))
    (setq buffer-read-only nil)
    (erase-buffer)
    (pop-to-buffer bufname)
    (compilation-mode)
    (message "Building behavc (opt engine)")(sit-for 0)
    (start-process "tbx_build_behavc_opt" bufname "~/build/behavc_build.sh" "-vf")))

(defun tbx-clean-build-behavc-debug ()

  "Clean and Build Behavc(debug)"

  (interactive)
  (save-excursion
    (setq bufname "*behavc build (debug)*")
    (set-buffer(get-buffer-create bufname))
    (setq buffer-read-only nil)
    (erase-buffer)
    (pop-to-buffer bufname)
    (compilation-mode)
    (message "Building behavc (debug engine)")(sit-for 0)
    (start-process "tbx_build_behavc_debug" bufname "~/build/behavc_build.sh" "-d")))

(defun tbx-clean-build-behavc-opt ()

  "Clean and Build Behavc(Opt)"

  (interactive)
  (save-excursion
    (setq bufname "*behavc build (opt)*")
    (set-buffer(get-buffer-create bufname))
    (setq buffer-read-only nil)
    (erase-buffer)
    (pop-to-buffer bufname)
    (compilation-mode)
    (message "Building behavc (opt engine)")(sit-for 0)
    (start-process "tbx_build_behavc_opt" bufname "~/build/behavc_build.sh")))

(defun tbx-clean-build-behavc-both ()

  "Clean and Build Behavc(debug and opt)"

  (interactive)
  (save-excursion
    (setq bufname "*behavc build (debug and opt)*")
    (set-buffer(get-buffer-create bufname))
    (setq buffer-read-only nil)
    (erase-buffer)
    (pop-to-buffer bufname)
    (compilation-mode)
    (message "Building behavc (debug and opt engine)")(sit-for 0)
    (tbx-clean-build-behavc-debug)
    (tbx-clean-build-behavc-opt)))
