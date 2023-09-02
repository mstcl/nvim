;;extends
(("return" @keyword)
  (#set! conceal "↦"))

(("in" @keyword)
  (#set! conceal "∈"))
;
(("lambda" @keyword)
  (#set! conceal "λ"))

(("!=" @keyword)
  (#set! conceal "≠"))

(("==" @keyword)
  (#set! conceal "≡"))

((">=" @keyword)
  (#set! conceal "≥"))

(("<=" @keyword)
  (#set! conceal "≤"))

(("or" @keyword)
  (#set! conceal "∨"))

(("and" @keyword)
  (#set! conceal "∧"))
