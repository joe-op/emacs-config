;; company
;;
;; allow inserting a newline exiting the suggestion box
;; instead of enter, Tab or Ctrl-SPC selects a suggestion.
;;
;; On Mac C-SPC may need to be C-@ .
;;
;; Also see https://company-mode.github.io/manual/Customization.html#Customization

(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "C-<return>") nil)
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (define-key company-active-map (kbd "C-SPC") #'company-complete-selection))

;; based on some advice from
;; https://www.monolune.com/configuring-company-mode-in-emacs/
(setq company-idle-delay 0.8) ;; delay in seconds
(setq company-minimum-prefix-length 3)
(setq company-selection-wrap-around t)
