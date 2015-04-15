#lang racket
;Norman Mutunga
;Brian Carlson
;Joshua Caravetta
;FP4
(require racket/gui/base)
(require plot)
;A nice way to include /Import procedures
;(require rackunit
;         rackunit/log
;         "GUI-sin.rkt")
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
(define stringInput "" )
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
;main frame for Goat Lambda (λ)
(define frameG (new frame% [label "Goat Lambda (λ)"]
                    [width 600]
                    [height 600]
                    [stretchable-height #t]
                    [stretchable-width #t]
                    (x 400) ( y 100)))

;,,,,,,,,,,,,,,,,,,,,,InPut Test Field,,,,,,,,,,,,,,
(define input-window (new text-field%
                          (label "UserInPut")
                          [min-width 600]
                          [min-height 30]
                          [stretchable-width #f]
                          (parent frameG)
                          ;(init-value "Expression")
                          ;this should return the current text of the editor
                          (callback (λ (input-window event)
                                      ; (send input-window get-text) ;this should work ??                           
                                      (send input-window show #t)           
                                      ;(send frameG on-traverse-char #f)
                                      (send input-window get-editor)
                                      ;(send input-window erase)
                                      ; (send event get-text)
                                      
                                      ))
                          ))
;,,,,,,,,,,,,,,,,,,,OutPut Text Filed from Input,,,,,,,,,,,,,,,,,,,,
(define out-put (new text-field%
                     [label "InPutExpr"]
                     [min-width 600]
                     [min-height 30]
                     [stretchable-width #f]
                     (parent frameG)
                     (callback (λ ( out-put text-field )
                                 (send  (send input-window get-editor) get-text )
                                 (display input-window)))))
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
;(define out-put2 (new text-field%
;                     [label "UserInPut2"]
;                     (parent frameG)
;                     (callback (λ ( out-put event)
;                                  ;; Make the editor have a maximum width:
;                                 (send  (send out-put2 get-editor) auto-wrap #f)
;                                  ;; Keep the caret visible:
;                                 (send (send out-put2 get-editor ) set-padding 0 0 2 0)
;                                  ;; Right-align the first paragraph:
;                                 (send (send out-put2 get-editor) set-paragraph-alignment 500 'right)))))
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

;;basic label to display on top of Compute Button....
(define msgG (new message% [parent frameG]
                  [label "Click the Compute Button"]))

;; Button to be clicked to triger an event.
;it creates this on REP : (object:button% ...)
(new button% [parent frameG]
     [label "Compute"]
     [callback (λ (button event)
                 (send msgG set-label "Graphical OutPut")
                 ;(send text-field get-text)
                 (send pb set-dragable #f)
                 (send pb erase)
                 ;Got from http://docs.racket-lang.org/plot/intro.html?q=plot#%28part._.Plotting_3.D_.Graphs%29
                 (send pb insert (parameterize ([plot-title  "An R × R → R function"]
                                                [plot-x-label "x"]
                                                [plot-y-label "y"]
                                                [plot-z-label "cos(x) sin(y)"])
                                   (plot3d (contour-intervals3d (λ (x y) (* (cos x) (sin y)))
                                                                (- pi) pi (- pi) pi))) )
                 ;Got from http://docs.racket-lang.org/plot/intro.html?q=plot#%28part._.Plotting_3.D_.Graphs%29
                 ;                 (send pb insert (plot3d-snip
                 ;                                  (surface3d (λ
                 ;                                                 (x y) (* 1 (sin x)))
                 ;                                             (- 10) 10 (- 10) 10)
                 ;                                  #:title "sin(x)"
                 ;                                  #:x-label "x" #:y-label "y" #:z-label "sin(x)") 0 0)
                 )])
;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
;,,,,,,,,,,,,,,,,,,,,, The graph display canvas,,,,,,,,,,,,,,,,

(define graph-display (new editor-canvas% 
                           [parent frameG]
                           [min-width 600]
                           [min-height 500]
                           [stretchable-width #f]
                           [stretchable-height #f]
                           [style '(transparent auto-hscroll auto-vscroll)]
                           ))
;Defines for pasteboard
(define pb (new pasteboard%)) ;from joshua
;(define t (new text%)) ;from joshua
(send graph-display set-editor pb) ;from joshua

;;Run Goat Lambda,,,,,,,,
(send frameG show #t)
