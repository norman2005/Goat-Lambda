#lang racket
;Norman Mutunga
;Brian Carlson
;Joshua Caravetta
;FP4
(require racket/gui/base)
(require plot)
(require pict images/icons/control images/icons/style) ; might not use it for images

;(include "testing.rkt")
;A nice way to include /Import procedures
;(require rackunit
;         rackunit/log
;         "GUI-sin.rkt")
(require  "images.rkt")
;,,,,,,,,,,,,,,,,,,,,,String to store strings?,,,,,,,,,,,,,,,,,,,,,,,,,,
(define stringInput  " " )
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
;
;,,,,,,,,,,,,,,,,,,,,,,Goat-Lambda Canvas Back Ground,,,,,,,,,,,,,,,,,,,,
(define the-bitmap
  (make-object bitmap% " Goat-Lambda.jpg"))
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
;main frame for Goat Lambda (λ)
(define frameG (new frame% [label "Goat Lambda (λ)"]
                    [width 600]
                    [height 600]
                    [stretchable-height #t]
                    [stretchable-width #t]
                    (x 400) ( y 100)))

;,,,,,,,,,,,,,,,,,,,,,InPut Test Field,,,,,,,,,,,,,,
(define input-window (new text-field%
                          (label "EnterExpr")
                          [min-width 600]
                          [min-height 30]
                          [stretchable-width #f]
                          (parent frameG)
                          ;Gets the value gives it to out-put
                          [callback (λ (input-window event)
                                      (if (eq? (send event get-event-type)
                                               'text-field-enter);value captured on enter 
                                          ;send value to out-put text
                                          ;(send out-put set-value (send input-window get-value))(void)
                                          (send stringInput get-text (send input-window get-value))(void)
                                          ; needs to be sent to an object
                                          ))]
                          ))
;;,,,,,,,,,,,,,,,,,,,OutPut Text Filed from Input,,,,,,,,,,,,,,,,,,,,
;(define out-put (new text-field%
                     [label "UserInPut"]
                     [min-width 600]
                     [min-height 30]
                     [stretchable-width #f]
                     (parent frameG)
;                     (callback (λ ( out-put text-field )
;                                 (send  (send input-window get-editor) get-text )
;                                 (display input-window)))
                     )) ; collapsed s-expression
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

;;basic label to display on top of Compute Button....
(define msgG (new message% [parent frameG]
                  [label "Click the Compute Button"]))

;; Button to be clicked to triger an event.
;it creates this on REP : (object:button% ...)

(define compute-button (new button% [parent frameG]
                            [label "Compute"]
                            [callback (λ (button event)
                                        (send msgG set-label "Graphical OutPut")
                                        ;(send text-field get-text)
                                        (send pb set-dragable #f)
                                        (send pb erase)
                                        (send compute-button set-label  "WorkDone")
                                        ;                 (if (eq? (send event compute-button )'button )
                                        ;                     (send event )) 
                                        
                                        ; to check if the text-input has data else use default.
                                        ;Got from http://docs.racket-lang.org/plot/intro.html?q=plot#%28part._.Plotting_3.D_.Graphs%29
                                        (send compute-button set-label  "WorkDone")
                                        (send pb insert (parameterize ([plot-title  "An R × R → R function"]
                                                                       [plot-x-label "x"]
                                                                       [plot-y-label "y"]
                                                                       [plot-z-label "cos(x) sin(y)"])
                                                          (plot3d (contour-intervals3d (λ (x y) (* (cos x) (sin y)))
                                                                                       (- pi) pi (- pi) pi))) )
                                        ; (else (send pb insert (out-put))) '  ; text-input has data so this runs
                                        
                                        )]))
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
;,,,,,,,,,,,,,,,,,,,,, The graph display canvas,,,,,,,,,,,,,,,,

(define graph-display (new editor-canvas% 
                           [parent frameG]
                           [min-width 900]
                           [min-height 500]
                           [stretchable-width #f]
                           [stretchable-height #f]
                           [style '(transparent auto-hscroll auto-vscroll)]))
;Defines for pasteboard
(define pb (new pasteboard%)) ;from joshua
;(send graph-display min-client-height(send pb get-height))
;(send graph-display min-client-width (send pb get-width ))
(send graph-display set-editor pb) ;from joshua
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,GoatLambda borrowed logo on REP.
;http://docs.racket-lang.org/images/Embedding_Bitmaps_in_Compiled_Files.html?q=images

the-logo
(display "We Goat-Lambda 
;Norman Mutunga
;Brian Carlson
;Joshua Caravetta
;FP4")
;;Run Goat Lambda,,,,,,,,
(send frameG show #t)
