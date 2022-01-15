;;; Custom indent and de-indent functions
;;;
;;; These were mainly written to ease working with
;;; PureScript's significant whitespace.
;;;
;;; **** KEYBINDINGS ****
;;;
;;; NOTE: the keybindings will be written differently on Linux/Windows and Mac.
;;;
;;; The last few lines create keybindings for these functions:
;;;
;;; Ctrl-Tab    - indents the line or region by the default of two spaces
;;; Shift-Tab   - de-indents the line or region by the default of two spaces
;;; Ctrl-Return - insert a new line with indentation matching the current line
;;; Ctrl-Enter  - ""
;;;
;;; On Mac the keybindings are for M-TAB, Shift-TAB, and M-RET .
;;;
;;; **** TODO ****
;;;
;;; - Region indent and de-indent is not working

(defun jpo-region ()
  (let ((beg (region-beginning)) (end (region-beginning)))
    (if (> end beg)
	(list beg end)
      (list end beg))))

(defun jpo-count-lines (beg end)
  (+ 1 (- (line-number-at-pos end) (line-number-at-pos beg))))

(defun jpo-indent-line (chars)
  (back-to-indentation)
  (dotimes (i chars)
    (insert " ")))

(defun jpo-deindent-line (chars)
  (back-to-indentation)
  (if (dotimes (i chars)
	(if (< (current-column) 1)
	    (return 1)
	  (delete-backward-char 1)))
      ;; non-zero return
      (progn
	(display-error-message-or-buffer "No more room to deindent")
	nil)
    t))

;; TODO: not doing multiple lines
;; TODO: create activate mark function
(defun jpo-id-region (beg end chars indent-fun adjust-fun)
  (let ((linecount (jpo-count-lines beg end)))
    (deactivate-mark)
    (goto-char beg)
    (dotimes (i linecount)
      (funcall indent-fun chars)
      (forward-line))
    (goto-char end)
    (funcall adjust-fun (* linecount chars))))

(defun jpo-room-to-deindent (chars)
  (save-excursion
    (back-to-indentation)
    (>= (current-column) chars)))

(defun jpo-room-to-deindent-region (beg end chars)
  (save-excursion
    (setq linecount (jpo-count-lines beg end))
    (goto-char beg)
    (not (dotimes (i linecount)
	   (if (not (jpo-room-to-deindent chars))
	       (return 1))
	   (forward-line)))))

(defun jpo-room ()
  (interactive)
  (let ((beg-end (jpo-region)))
    (let ((beg (car beg-end)) (end (car (cdr beg-end))))
      (let ((linecount (jpo-count-lines beg end)))
	(if (jpo-room-to-deindent-region beg linecount 2)
	    (display-message-or-buffer "Yes")
	  (display-message-or-buffer "No"))))))
	  
(defun jpo-deindent (chars)
  (if (use-region-p)
      (let ((reg (jpo-region)))
	(let ((beg (car reg)) (end (car (cdr reg))))
	  (if (jpo-room-to-deindent-region beg end chars)
	      (jpo-id-region beg end chars #'jpo-deindent-line #'backward-char)
	    (display-message-or-buffer "No room to deindent"))))
    (if (jpo-room-to-deindent chars)
	(jpo-deindent-line chars)
      (display-message-or-buffer "No room to deindent"))))

(defun jpo-indent (chars)
  (if (use-region-p)
      (let ((reg (jpo-region)))
	(let ((beg (car reg)) (end (car (cdr reg))))
	  (jpo-id-region beg end chars #'jpo-indent-line #'forward-char)))
    (jpo-indent-line chars)))

(defun jpo-newline-indent ()
  (let ((col
	 (save-excursion
	   (back-to-indentation)
	   (current-column))))
    (newline)
    (dotimes (i col)
      (insert " "))))

(global-set-key [backtab] '(lambda () (interactive) (jpo-deindent 2)))
(global-set-key (kbd "C-<tab>") '(lambda () (interactive) (jpo-indent 2)))
(global-set-key (kbd "C-<return>") '(lambda () (interactive) (jpo-newline-indent)))

;; Mac bindings
;; C-h k followed by a key sequence will show how to write the keybinding.
;;
;; The M-SPC binding overrides the interesting function just-one-space .
;;
;; (global-set-key [backtab] '(lambda () (interactive) (jpo-deindent 2)))
;; (global-set-key (kbd "C-<tab>") '(lambda () (interactive) (jpo-indent 2)))
;; (global-set-key (kbd "M-SPC") 'completion-at-point)
;; (global-set-key (kbd "M-RET") '(lambda () (interactive) (jpo-newline-indent)))
;; (global-set-key (kbd "C-M-c") '(lambda () (interactive) (jpo-newline-indent)))
