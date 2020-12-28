#lang racket
(require htdp/gui)
;; pirate-namer consumes a (listof Char) and replaces characters
;; with their pirate form
;; pirate-namer: (listof Char) -> (listof Char)
(define (pirate-namer loc)
  (cond [(empty? loc) empty]
        [(char=? (first loc) #\a)
         (cons #\a (cons #\r (cons #\r (pirate-namer (rest loc)))))]
        [(char=? (first loc) #\A)
         (cons #\A (cons #\r (cons #\r (pirate-namer (rest loc)))))]
        [(char=? (first loc) #\R)
         (cons #\R (cons #\r (cons #\r (pirate-namer (rest loc)))))]
        [(char=? (first loc) #\r)
         (cons #\r (cons #\r (cons #\r (pirate-namer (rest loc)))))]
        [else (cons (first loc) (pirate-namer (rest loc)))]))

; text1 : GUI-ITEM
(define text1
  (make-text "Enterrr ye name scallywag!"))
 
; msg1 : GUI-ITEM
(define msg1
  (make-message (string-append "Ahoy," (make-string 33 #\space))))
 
; Event -> true
; draws the current contents of text1 into msg1, prepended with
; "Ahoy, "
(define (respond e)
  (draw-message msg1
                (string-append "Ahoy, "
                               (list->string (pirate-namer
                                              (string->list
                                               (text-contents
                                                text1)))))))
 
; set up window with three "lines":
;    a text field, a message, and two buttons
; fill in text and click OKAY
(define w
  (create-window
   (list
    (list text1)
    (list msg1)
    (list (make-button "Enterrr" respond)
          (make-button "Exit" (lambda (e) (hide-window w)))))))
