#lang racket

(require threading) ; package threading-lib
(require racket/format)
(require racket/file)
(require racket/pretty)

(provide quote-highlight quote-note)

(define (short-str-join s)
  (string-join s ""))


(define (add-attribution strs-as-lists title is-book? author page-num url )
  ; (pretty-print strs-as-lists)
  (append strs-as-lists
          (~a "\n> \n> - From " title " by " author " on page " (number->string page-num)  " (" url ")" )
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
                          . body)
    (write-to-file
            #:title           title
            #:is-book?        is-book?
            #:author          author
            #:page-number     page-num
            #:url             url
            #:highlight-lines (list highlight)
            ; turn highlight into a list so there's no difference in object types between the content this way or from quote-highlight
            ; (where semantically this is the same information: the highlighted text)
            #:note-lines      body
            #:kind            "note")
   (~> (add-highlight-and-info body title is-book? author page-num url (list highlight))
      (flatten)
      (short-str-join)))


(define (write-to-file #:title           title
                       #:is-book?        [is-book? 'f]
                       #:author          author
                       #:page-number     page-num
                       #:kind            kind
                       #:highlight-lines [body ""]
                       #:note-lines      [notes ""]
                       #:url             [url ""]
                          )

    ;(define out (open-output-file "extracted-refs.txt" #:exists 'append #:mode 'text))
    (display-lines-to-file
        (list (string-join (list "TITLE" title ""))
          (string-join (list "AUTHOR" author ""))
          (string-join (list "PAGE-NUMBER" (number->string page-num) ""))
          (string-join (list "KIND" kind ""))
          (string-join (list "URL" url ""))
          "HIGHLIGHT"
         (string-join body "\n> ")
          ""
          "NOTES"
          ""
          notes
          ""
          "END OF ENTRY\n==============================================")

        "extracted-refs.txt" #:exists 'append #:mode 'text))



(define (quote-highlight #:title title
                         #:is-book? [is-book? 'f]
                         #:author author
                         #:page-number page-num
                         #:url [url ""]
                         . body-in)
  (let ([body (if (string? body-in) (list body-in) body-in)])

        (write-to-file
            #:title           title
            #:is-book?        is-book?
            #:author          author
            #:page-number     page-num
            #:url             url
            #:highlight-lines body
            #:kind            "quote")

        ;(pretty-print body-in)
        (~> (append-map (lambda (arg) (if (string=? arg "\n") (list "") (list "\n> " arg))) body)
           (add-attribution title is-book? author page-num url)
           (flatten)
           (short-str-join))))
