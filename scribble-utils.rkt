#lang racket

(require threading) ; package threading-lib
(require racket/format)
(require racket/file)

(provide quote-highlight quote-note)

(define (short-str-join s)
  (string-join s ""))


(define (add-attribution strs-as-lists title is-book? author page-num url )
  (append strs-as-lists
          (~a "\n> \n" "> - From " title " by " author " on page " (number->string page-num)  " (" url ")" )
           ))


(define (add-highlight-and-info strs-as-list title is-book? author page-num url original)
  (list
          "\n> " original "\n> - From " title " by " author " on page " (number->string page-num) " (" url ")"
          "\n\n"
          "My thoughts: "
          strs-as-list))


(define (quote-note #:title title
                          #:is-book? [is-book? 'f]
                          #:author author
                          #:page-number page-num
                          #:url [url ""]
                          #:original-highlight [highlight ""]
                          . body) (begin (
    (write-to-file
            #:title           title
            #:is-book?        is-book?
            #:author          author
            #:page-number     page-num
            #:url             url
            #:highlight-lines highlight
            #:note-lines      body
            #:kind            "note")
   ~> (add-highlight-and-info body title is-book? author page-num url highlight)
      (flatten)
      (short-str-join))))


(define (write-to-file #:title           title
                       #:is-book?        [is-book? 'f]
                       #:author          author
                       #:page-number     page-num
                       #:kind            kind
                       #:highlight-lines [body (list "")]
                       #:note-lines      [notes (list "")]
                       #:url             [url ""]
                          )
  (begin
    ;(define out (open-output-file "extracted-refs.txt" #:exists 'append #:mode 'text))
    (display-lines-to-file 
        (list (string-join (list "TITLE" title "")) 
          (string-join (list "AUTHOR" author ""))
          (string-join (list "PAGE-NUMBER" (number->string page-num) ""))
          (string-join (list "KIND" kind ""))
          (string-join (list "URL" url ""))
          "HIGHLIGHT"
          (string-join body "")
          ""
          "NOTES"
          ""
          
          (string-join notes "")
          ""
          "END OF ENTRY\n=============================================="
          )
        "extracted-refs.txt" #:exists 'append #:mode 'text))
  )
        


(define (quote-highlight #:title title
                         #:is-book? [is-book? 'f]
                         #:author author
                         #:page-number page-num
                         #:url [url ""]
                         . body) (
    begin
        (write-to-file
            #:title           title
            #:is-book?        is-book?
            #:author          author
            #:page-number     page-num
            #:url             url
            #:highlight-lines body
            #:kind            "quote")
        
        (~> (append-map (lambda (arg) (if (string=? arg "\n") (list arg) (list "> " arg))) body)
           (add-attribution title is-book? author page-num url)
           (flatten)
           (short-str-join))))
