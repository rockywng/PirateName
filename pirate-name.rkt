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
        [else (cons (first loc) (pirate-namer (rest loc)))]))

; text1 : GUI-ITEM
(define text1
  (make-text "Enterrr ye name scallywag!"))
 
; msg1 : GUI-ITEM
(define msg1
  (make-message (make-string 99 #\space)))
 
; Event -> true
; draws the current contents of text1 into msg1, prepended with
; "Ahoy, "
(define (respond e)
  (local [(define pirate-name (list->string (pirate-namer
                                              (string->list
                                               (text-contents
                                                text1)))))]
  (cond [(string=? (text-contents text1) pirate-name)
         (draw-message msg1 "Darrrn, ye pirate name be the same as ye regular name.")]
        [else (draw-message msg1 (string-append "Ahoy, " pirate-name))])))
 
; set up window with three "lines":
;    a text field, a message, and two buttons
; fill in text and click Enterrr
(define w
  (create-window
   (list
    (list text1)
    (list msg1)
    (list (make-button "Enterrr" respond)
          (make-button "Exit" (lambda (e) (hide-window w)))))))

