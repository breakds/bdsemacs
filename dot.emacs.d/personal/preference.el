;;;; ============================================================+
;;;; Minor preferences                                           |
;;;; ------------------------------------------------------------+

;;; +============================================================+
;;; | Key Bindings                                               |
;;; + -----------------------------------------------------------+
;;;
;;; * M-p
;;;   Delete trailing whitespaces.

;;; Remove the trailing white spaces to tidy the code/article.
(global-set-key (kbd "M-p") 'delete-trailing-whitespace)

(setq browse-url-generic-program "google-chrome")
(setq browse-url-browser-function 'browse-url-generic)
