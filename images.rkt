#lang racket
;Norman Mutunga
;Brian Carlson
;Joshua Caravetta
;FP4
(require images/compile-time
         (for-syntax images/logos))
(provide the-logo)
;the logo print out on REP
(define the-logo (compiled-bitmap (plt-logo #:height 100)))
