;;; package --- My personal emacs configuration
;;; Commentary:
;;; all settings can be found here https://github.com/kelvins/dotfiles

;;; Code:

(defvar org-babel-file-path "~/.emacs.d/config.org" "Path to the org-babel config file.")

(defvar emacs-lisp-file-path "~/.emacs.d/config.el" "Path to the Emacs Lisp config file.")

(defvar org-babel-file-last-mod
  (file-attribute-modification-time (file-attributes org-babel-file-path))
  "The modification time of org-babel file.")

(defvar emacs-lisp-file-last-mod
  (file-attribute-modification-time (file-attributes emacs-lisp-file-path))
  "The modification time of config.el file.")

(defun config-file-does-not-exist ()
  "Check if the config.el file does not exist."
  (not (file-exists-p emacs-lisp-file-path)))

(defun config-file-outdated ()
  "Check if the config.el file is outdated."
  (time-less-p emacs-lisp-file-last-mod org-babel-file-last-mod))

(if (or (config-file-does-not-exist) (config-file-outdated))
    (org-babel-load-file org-babel-file-path)
    (load-file emacs-lisp-file-path))

;;; init.el ends here
