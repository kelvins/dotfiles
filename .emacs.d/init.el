;;; package --- My personal Emacs configuration
;;; Commentary:
;;; https://github.com/kelvins/dotfiles

;;; Code:

;; Relax the conservative garbage collector to speed up startup time:
;; https://www.emacswiki.org/emacs/OptimizingEmacsStartup

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (expt 2 23))))

;; Set package archives and initialize package

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; The auto-package-update package helps us keep our Emacs packages up to date!
;; It will prompt you after a certain number of days either at startup or at a
;; specific time of day to remind you to update your packages

;; You can also use M-x auto-package-update-now to update right now!

(use-package auto-package-update
  :custom
  (auto-package-update-interval 30)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; Basic Settings

;; Disable tooltip and bars
(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq visible-bell t)
(setq inhibit-startup-message t)
(setq show-trailing-whitespace t)

;; Open window maximized
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Set default column to 120
(add-hook 'prog-mode-hook (lambda () (setq-default fill-column 120)))
(add-hook 'python-mode-hook (lambda () (setq-default fill-column 80)))

;; Enable column indicator for prog-mode
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; Set a frame title
(setq-default frame-title-format (format "Emacs (%s)" emacs-version))

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Improve Scrolling
(setq scroll-step 1)
(setq scroll-margin 1)

;; Line Numbers

;; Display line numbers
(global-display-line-numbers-mode -1)
(column-number-mode)

;; Enable line numbers for some modes
(dolist (mode '(prog-mode-hook text-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode t))))

(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))

;; Font
;; Install all-the-icons with: M-x all-the-icons-install-fonts

;; Set default font size
(defvar efs/default-font-size 120)

(set-face-attribute 'default nil :height efs/default-font-size)

;; Set font face to "Fira Code" when available
(when (member "Fira Code Retina" (font-family-list))
  (set-face-attribute 'default nil :font "Fira Code Retina")
  (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina")
  (set-face-attribute 'variable-pitch nil :font "Fira Code Retina"))

;; Check if font exists
(defun my/font-exists (font)
  "Check if a given FONT exists."
  (if (null (x-list-fonts font)) nil t))

;; Set frame font if available
(when (window-system)
  (cond ((my/font-exists "Fira Code Retina") (set-frame-font "Fira Code Retina:spacing=100:size=16" nil t))))

(defun my/zoom (operator)
  "Perform zoom in and out based on the provided OPERATOR."
  (interactive)
  (set-face-attribute 'default nil :height (funcall operator (face-attribute 'default :height) 10)))

(global-set-key (kbd "C->") (lambda () (interactive) (my/zoom '+)))
(global-set-key (kbd "C-<") (lambda () (interactive) (my/zoom '-)))

;; Fix indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Find references
(global-set-key (kbd "C-c r") 'lsp-find-references)

;; Disable backup files
(setq make-backup-files nil)

;; Disable lock files
(setq create-lockfiles nil)

;; Dashboard
;; https://github.com/emacs-dashboard/emacs-dashboard

(defvar dashboard-title
  (format "Welcome to Emacs (%s)" emacs-version))

(defvar dashboard-date-time
  (format "%s" (format-time-string "%A, %B %e, %Y")))

(defun ensure-trailing-slash (text)
  "Ensure that TEXT ends with a slash."
  (if (not (string-suffix-p "/" text))
    (concat text "/")
    text))

(defun my/open-project ()
  "Open a new project."
  (interactive)
  (projectile-switch-open-project)
  (treemacs-hide-gitignored-files-mode t)
  (treemacs-add-and-display-current-project-exclusively)
  (treemacs-select-window)
  (let ((readme (expand-file-name "README.md" (projectile-project-root))))
    (if (file-exists-p readme)
        (find-file readme)
      (message "No README.md found in the project"))))

(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-items '((recents . 5)
                            (projects . 5)
                            (agenda . 5)))
    (setq dashboard-set-file-icons t)
    (setq dashboard-footer-icon nil)
    (setq dashboard-center-content t)
    (setq dashboard-show-shortcuts nil)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-startup-banner 'logo)
    (setq dashboard-icon-type 'all-the-icons)
    (setq dashboard-banner-logo-title dashboard-title)
    (setq dashboard-footer-messages (list dashboard-date-time))
    (setq dashboard-projects-switch-function 'my/open-project))
  :config
  (dashboard-setup-startup-hook))

;; Org Mode
;; Make sure org mode is updated and add some customization.

;; Bindings:
;; toggle todo: C-c C-t
;; org-schedule: C-c C-s

;; https://orgmode.org
;; https://github.com/sabof/org-bullets
;; https://github.com/joostkremers/visual-fill-column

(defun efs/org-mode-setup ()
  "Define the org-mode-setup."
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :pin org
  :hook (org-mode . efs/org-mode-setup)
  :custom
  (org-ellipsis " ▾")
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-hide-emphasis-markers t)
  (org-agenda-start-with-log-mode t)
  (org-agenda-files
   '("~/github/org-files/Tasks.org"
     "~/github/org-files/Birthdays.org"
     "~/github/org-files/Holidays.org"))
  (org-refile-targets
   '(("Archive.org" :maxlevel . 1)
     ("Tasks.org"   :maxlevel . 1)))
  (org-todo-keywords
        '((sequence "TODO(t)" "DOING(o)" "NEXT(n)" "|" "DONE(d!)" "CANCELED(c)"))))

(advice-add 'org-refile :after 'org-save-all-org-buffers)

(defun efs/org-mode-visual-fill ()
  "Align text when in \"org-mode\"."
  (setq visual-fill-column-width 100)
  (setq visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Theme
;; https://draculatheme.com

(use-package dracula-theme
  :init (load-theme 'dracula t))

;; Modeline
;; https://github.com/seagle0128/doom-modeline

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 24)
  (doom-modeline-vcs-max-length 64)
  (doom-modeline-buffer-file-name-style 'file-name))

;; Evil Mode
;; https://github.com/emacs-evil/evil

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ;;(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;;(define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(evil-define-key 'normal dired-mode-map (kbd "<return>") 'dired-find-file)
(evil-define-key 'normal dired-mode-map (kbd "TAB") 'dired-find-file)

;; Completion

;; Ivy is an excellent completion framework for Emacs.
;; It provides a minimal yet powerful selection menu that appears when you open files, switch buffers,
;; and for many other tasks in Emacs. Counsel is a customized set of commands to replace `find-file` with
;; `counsel-find-file`, etc which provide useful commands for each of the default completion commands.

;; ivy-rich adds extra columns to a few of the Counsel commands to provide more information about each item.

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

;; Treemacs
;; Treemacs is a tree layout file explorer for Emacs

;; Bindings:
;; open treemacs: C-x t t
;; select directory: C-x t d

(use-package treemacs
  :ensure t
  :defer t
  :bind
  (:map global-map
        ("C-x t t"   . treemacs)
        ("C-x t C-t" . treemacs-find-file)
        ("M-0"       . treemacs-select-window)
        ("C-x t d"   . treemacs-select-directory))
  :config
  (setq treemacs-hide-gitignored-files-mode t))

(add-hook 'treemacs-mode-hook (lambda () (setq mode-line-format nil)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;; Magit
;; Common Git operations are easy to execute quickly using Magit’s command panel system.

;; Bindings:
;; magit status: C-x g

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Projectile
;; Projectile is a project management library for Emacs which makes it a lot easier to navigate around
;; code projects for various languages. Many packages integrate with Projectile so it’s a good idea to
;; have it installed even if you don’t use its commands directly.
;; https://github.com/bbatsov/projectile

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

;; Term Mode

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "zsh")
  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

;; Helpers
;; https://github.com/justbur/emacs-which-key
;; https://github.com/Fanael/rainbow-delimiters

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.8))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Golden Ratio
;; https://github.com/roman/golden-ratio.el

(use-package golden-ratio
  :ensure t
  :init (golden-ratio-mode))

(setq golden-ratio-exclude-modes '(magit-status-mode org-mode cider-repl-mode))

;; Spell Checking
;; Spell checking using flyspell and ispell.
;; To install ispell use brew install ispell or apt-get install ispell.

;; Key bindings:
;; open suggestions: z =
;; add to dictionary: z = i

(dolist (mode '(prog-mode-hook
                text-mode-hook))
  (add-hook mode (lambda () (flyspell-mode 1))))

(defun flyspell-portuguese ()
  "Apply flyspell using brazilian dictionary."
  (interactive)
  (ispell-change-dictionary "brazilian")
  (flyspell-buffer))

(defun flyspell-english ()
  "Apply flyspell using default (english) dictionary."
  (interactive)
  (ispell-change-dictionary "default")
  (flyspell-buffer))

(setq ispell-personal-dictionary "~/.emacs.d/ispell/english")

;; Programming
;; Settings and packages related to programming.

;; Remove Trailing Whitespaces
;; Automatically remove trailing whitespaces when saving a file in prog-mode.

(defun my/remove-trailing-whitespace ()
  "Remove trailing whitespaces."
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))

(add-hook 'before-save-hook 'my/remove-trailing-whitespace)

;; Syntax Checking
;; https://github.com/flycheck/flycheck

;; Bindings:
;; next-error: M-g n
;; previous-error: M-g p

(use-package flycheck
  :defer t
  :init (global-flycheck-mode))

(setq flycheck-markdown-markdownlint-cli-config "~/.emacs.d/flycheck/markdownlint.json")

;; Smartparens

(use-package smartparens-mode
  :ensure smartparens
  :hook (prog-mode text-mode markdown-mode)
  :config
  (require 'smartparens-config))

;; Commenter
;; https://github.com/redguardtoo/evil-nerd-commenter

;; Bindings:
;; comment: M-;

(use-package evil-nerd-commenter
  :defer t)

;; Language Server Protocol (LSP)

;; We use the excellent lsp-mode to enable IDE-like functionality for many different programming
;; languages via “language servers” that speak the Language Server Protocol. Before trying to set up
;; lsp-mode for a particular language, check out the documentation for your language so that you can
;; learn which language servers are available and how to install them.

;; The lsp-keymap-prefix setting enables you to define a prefix for where lsp-mode’s default keybindings
;; will be added. I highly recommend using the prefix to find out what you can do with lsp-mode in a buffer.

;; The which-key integration adds helpful descriptions of the various keys so you should be able to learn a
;; lot just by pressing C-c l in a lsp-mode buffer and trying different things that you find there.

;; Bindings:
;; rename: C-c l r r
;; organize imports: C-c l r o
;; find references: C-c l g r
;; find definitions: C-c l g g

(defun efs/lsp-mode-setup ()
  "Configure LSP mode."
  (setq lsp-headerline-arrow ">")
  (setq lsp-headerline-breadcrumb-segments '(project path-up-to-project file))
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  (setq lsp-headerline-breadcrumb-icons-enable nil)
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

;; lsp-ui
;; lsp-ui is a set of UI enhancements built on top of lsp-mode which make Emacs feel even more like an IDE.
;; Check out the screenshots on the lsp-ui homepage (linked at the beginning of this paragraph) to see examples
;; of what it can do.

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

;; lsp-treemacs
;; lsp-treemacs provides nice tree views for different aspects of your code like symbols in a file,
;; references of a symbol, or diagnostic messages (errors and warnings) that are found in your code.

;; Try these commands with M-x:
;; lsp-treemacs-symbols - Show a tree view of the symbols in the current file
;; lsp-treemacs-references - Show a tree view for the references of the symbol under the cursor
;; lsp-treemacs-error-list - Show a tree view for the diagnostic messages in the project

;; This package is built on the treemacs package which might be of some interest to you if you
;; like to have a file browser at the left side of your screen in your editor.

(use-package lsp-treemacs
  :after lsp)

;; lsp-ivy
;; lsp-ivy integrates Ivy with lsp-mode to make it easy to search for things by name in your code.
;; When you run these commands, a prompt will appear in the minibuffer allowing you to type part of
;; the name of a symbol in your code. Results will be populated in the minibuffer so that you can
;; find what you’re looking for and jump to that location in the code upon selecting the result.

;; Try these commands with M-x:
;; lsp-ivy-workspace-symbol - Search for a symbol name in the current project workspace
;; lsp-ivy-global-workspace-symbol - Search for a symbol name in all active project workspaces

(use-package lsp-ivy
  :after lsp)

;; Company Mode
;; Company Mode provides a nicer in-buffer completion interface than completion-at-point which is more
;; reminiscent of what you would expect from an IDE. We add a simple configuration to make the keybindings
;; a little more useful (TAB now completes the selection and initiates completion at the current location if needed).

;; We also use company-box to further enhance the look of the completions with icons and better overall presentation.

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; Debugging

;; Use the Debug Adapter Protocol for running tests and debugging
(use-package dap-mode
  :defer t
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode))

;; YAML

(use-package yaml-mode
  :defer t)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

;; Enable highlight-indentation-mode only for yaml-mode
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)

;; Docker

(use-package dockerfile-mode
  :defer t)

;; Python
;; https://github.com/jorgenschaefer/elpy

(use-package elpy
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; Scala

;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :defer t
  :interpreter ("scala" . scala-mode))

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :defer t
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
  (setq sbt:program-options '("-Dsbt.supershell=false")))

;; Add metals backend for lsp-mode
(use-package lsp-metals
  :ensure t
  :custom
  (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"
                            "-J-Dmetals.icons=unicode"
                            "-J-Dscalafix.rewrite.onSave=true"
                            "--scalafix-rules=core.RemoveUnused,core.RedundantBraces,style.SortImports,style.groupedImports"))
  (lsp-metals-enable-semantic-highlighting t)
  :hook (scala-mode . lsp))

(add-hook 'scala-mode-hook
          (lambda () (add-hook 'after-save-hook 'lsp-metals-run-scalafix)))

;; Clojure
;; To install clojure-lsp run: M-x lsp-install-server RET clojure-lsp

;; Bindings:
;; REPL: C-c M-j

(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)

(use-package cider
  :ensure t
  :custom
  (cider-repl-display-help-banner nil))

(add-hook 'cider-repl-mode-hook (lambda () (display-line-numbers-mode 0)))

(defun my/cider-ns-refresh ()
  "Use Cider to refresh namespace."
  (interactive)
  (cider-switch-to-last-clojure-buffer)
  (cider-repl-set-ns (cider-current-ns))
  (cider-switch-to-repl-buffer)
  (cider-ns-refresh))

(defun my/cider-run-tests ()
  "Use Cider to run project tests."
  (interactive)
  (cider-ns-refresh)
  (cider-test-run-project-tests nil))

(defun my/cider-run-ns-tests ()
  "Use Cider to run namespace tests."
  (interactive)
  (cider-ns-refresh)
  (cider-test-run-ns-tests nil))

;; Rust
;; Add support for programming in Rust, using the following packages:

;; rust-mode: add rust-mode to emacs and provides some functionalities such as syntax highlighting,
;; indentation and integration with Cargo and rustfmt.
;; cargo.el: provides a minor mode for integration with Cargo
;; rustic: provides additional features to rust-mode such as multiline error parsing, cargo popup,
;; automatic LSP configuration with eglot or lsp-mode, and so on.

;;Key bindings:
;; C-c C-c C-u: rust-compile
;; C-c C-c C-k: rust-check
;; C-c C-c C-t: rust-test
;; C-c C-c C-r: rust-run

(use-package rust-mode
  :defer t)

(use-package rustic
  :defer t)

(use-package cargo
  :defer t)

;; Indentation
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))

;; Run rustfmt when saving a rust file
(setq rust-format-on-save t)

;; Prettifying
(add-hook 'rust-mode-hook
        (lambda () (prettify-symbols-mode)))

(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;;; init.el ends here
