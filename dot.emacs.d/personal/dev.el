;;;; ============================================================+
;;;; Development Environment                                     |
;;;; ------------------------------------------------------------+
;;;;
;;;; This includes the configuration for various languages.

;;; +============================================================+
;;; | C/C++                                                      |
;;; +------------------------------------------------------------+


;; Please treat .h as C++ code!
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Please respect C++11, C++14, C++17, C++20
(use-package modern-cpp-font-lock :ensure t)
(modern-c++-font-lock-global-mode t)

;; Global clang-format key
(require 'clang-format)
(global-set-key [C-M-tab] 'clang-format-region)

(defun clang-format-buffer-and-back-to-indentation ()
  "Call clang-format to format the whole buffer, and move the
  cursor to the first non-space character of the current line."
    (interactive)
    (clang-format-buffer)
    (back-to-indentation))
  
(defun clang-format-bindings ()
  "Hijack the tab key to perform the function defined above,
  which is `clang-format-buffer-and-back-to-indentation`."
  (define-key c++-mode-map [tab]
    'clang-format-buffer-and-back-to-indentation))

(add-hook 'c++-mode-hook 'clang-format-bindings)

;;; +============================================================+
;;; | LSP (Language Server Protocol) Support                     |
;;; +------------------------------------------------------------+
;;;
;;; There are two different flavors of lsp client for emacs.
;;; 1) lsp-mode
;;; 2) eglot
;;;
;;; The argument on github: https://github.com/joaotavora/eglot/issues/180
;;;
;;; Below is the configuration for `lsp-mode`.
;;;
;;; Note: I am using this with clangd as lsp server for C++ (YMMV).

(use-package yasnippet :ensure t)

(use-package flycheck :ensure t)

(use-package company
  :ensure t
  :diminish company-mode
  :config (progn
            (add-hook 'after-init-hook 'global-company-mode)
            (setq company-idle-delay 0)))

(use-package company-lsp :ensure t)

(use-package lsp-ui :ensure t)

(use-package lsp-mode
  :ensure t
  ;; Auto-enabled for c++ major mode
  :hook (c++-mode . lsp)
  :commands lsp
  :init (progn
          (setq lsp-auto-guess-root t)
          ;; Automatically configure company-lsp and lsp-ui
          (setq lsp-auto-configure t))
  :config (progn
            (push 'company-lsp company-backends)))

