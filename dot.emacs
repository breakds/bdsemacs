;;;; ------------------------------------------------------------+
;;;; Emacs Configuration                                         |
;;;; ------------------------------------------------------------+
;;;; Author: Break Yang <breakds@gmail.com>
;;;;
;;;; References:
;;;; 1. Sacha Chua's emacs configuration (http://sach.ac/dotemacs)
;;;; 2. Eamcs as a C++ IDE (http://martinsosic.com/development/emacs/2017/12/09/emacs-cpp-ide.html)
;;;; 3. sing Emacs as a C++ IDE (https://nilsdeppe.com/posts/emacs-c++-ide2)
;;;;
;;;;
;;;; ---------- ELisp (Emacs Lisp) Notes ----------
;;;; 1. To get a REPL for Emacs Lisp, `M-x ielm`.

;;; +============================================================+
;;; | Key Bindings                                               |
;;; + -----------------------------------------------------------+
;;;
;;; * C-x <Right> and C-x <Left>
;;;   winner-mode cycle windows.
;;;
;;; * C-x p
;;;   Go back to the mark (set by C-<space>).
;;;
;;; * C-x r
;;;   Open recent files.
;;;
;;; * Org Mode Bidings
;;;   * C-c C-y
;;;     Yank the link
;;;   * C-x n s
;;;     Focus on a headline
;;;   * C-x n w
;;;     Unfocus
;;;   * C-c C-w
;;;     refile
;;;   * C-c C-x C-j
;;;     go to running clock

;;; +============================================================+
;;; | Basic Utilities for Emacs Configuration                    |
;;; +------------------------------------------------------------+

;; Enable Common Lisp
(require 'cl)

;; Set up the load path for ELPA/MELPA packages.
;; - ELPA is the Emacs Lisp Package Archive
;; - MELPA is yet another repository
;; Note that Emacs users in China mainland can use '("popkit" . "http://elpa.popkit.org/packages/")
(require 'package)
(package-initialize nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Packages for bootstrapping the configuration
(defmacro bootstrap-install (&rest packages)
  "This macro ensures that the input packages are all installed."
  `(let ((need-refresh nil))
     (loop for x in (list ,@packages)
	   when (not (package-installed-p x))
	   do (setf need-refresh t))
     (when need-refresh
       (package-refresh-contents)
       ,@(loop for x in packages
	       collect `(when (not (package-installed-p ,x))
			  (package-install ,x))))))

;; Install bootstrapping packages.
;; 1. use-package for loading packages and local directories.
(bootstrap-install 'use-package)

;; Set up use-package.
(require 'use-package)

;; Use load-dir to load the configuration directory which is set to
;; "~/.emacs.d/personal"
(use-package load-dir :ensure t)
(add-to-list 'load-dirs "~/.emacs.d/personal")
(load-dirs)

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(TeX-view-program-list (quote (("Atril" "atril %o"))))
;;  '(TeX-view-program-selection
;;    (quote
;;     (((output-dvi style-pstricks)
;;       "dvips and gv")
;;      (output-dvi "xdvi")
;;      (output-pdf "Atril")
;;      (output-html "xdg-open"))))
;;  '(ledger-reports
;;    (quote
;;     (("2018" "ledger ")
;;      ("bal" "%(binary) -f %(ledger-file) bal")
;;      ("reg" "%(binary) -f %(ledger-file) reg")
;;      ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
;;      ("account" "%(binary) -f %(ledger-file) reg %(account)"))))
;;  '(markdown-command "grip --export -")
;;  '(org-agenda-files
;;    (quote
;;     ("~/org/cron.org" "~/org/reading.org" "~/org/unsorted.org" "~/org/projects.org")))
;;  '(package-selected-packages
;;    (quote
;;     (ledger-mode nix-mode dockerfile-mode json-mode tide web-mode-edit-element clang-format cmake-ide rtags flycheck company protobuf-mode yaml-mode web-mode use-package toc-org solarized-theme smart-mode-line org-doing org-dashboard markdown-mode+ load-dir forecast fcitx exec-path-from-shell elm-mode ein cargo))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
