#lang scribble/text

Eventually I'm going to turn this documentation page into some kind of [Gatsby](https://www.gatsbyjs.com/) enabled static site.

If you're looking at this repo directly, that day is not today.

# Technologies used here

The first approach for this site is to use Github as a (decent!) markdown rendering platform for individual files.

Some files are preprocessed via [Racket's scribble library](https://docs.racket-lang.org/scribble/index.html) documentation tool. Then I checkin / commit the generated files so they are viewed via its rendered Github generated markdown

# File Index

Because while you see all the files listed above.... if you're on mobile you don't.

@(define (display-file-list)
   (map
    (lambda (current) (string-append "  * [" (path->string current) "](https://github.com/rwilcox/my-learnings-docs/blob/master/" (path->string current) ")\n"))
    (filter
     (lambda (current) (string-suffix? (path->string current) ".md"))
     (directory-list "." #:build? #f))))

@(display-file-list)
