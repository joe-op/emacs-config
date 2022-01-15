;; Purescript

;; compiled from source
(add-to-list 'load-path "~/.emacs.d/elisp/psc-ide-emacs")
(require 'psc-ide)
;; don't think I got this to work
;;(require 'lsp-mode)

;; disable lockfiles - I think the creation / deletion was triggering spago builds
(defun disable-lockfiles ()
     "Disable lockfiles in the current buffer"
     (make-local-variable 'create-lockfiles)
     (setq create-lockfiles nil))

(add-hook 'purescript-mode-hook
	  (lambda ()
	    (psc-ide-mode)
	    ;; see company.emacs for important configuration
	    (company-mode)
	    (purescript-indentation-mode)
	    ;; flycheck mode is nice but it shows too many errors when
	    ;; making a file from scratch
	    ;;	    (flycheck-mode)
	    (format-all-mode)
	    (turn-on-purescript-indentation)
	    (column-number-mode)
	    (auto-revert-mode)
	    (disable-lockfiles)))
