; extends

(assignment
  left: (identifier) @variable
  (#lua-match? @variable ".*[sS][qQ][lL].*")
  right: (string (string_content) @injection.content)
  (#set! injection.language "sql"))

(assignment
  left: (identifier) @variable
  (#lua-match? @variable ".*[qQ][uU][eE][rR][yY].*")
  right: (string (string_content) @injection.content)
  (#set! injection.language "sql"))

(call
  function: (attribute
    attribute: (identifier) @method
    (#lua-match? @method "^[eE][xX][eE][cC][uU][tT][eE]"))
  arguments: (argument_list
    (string (string_content) @injection.content)
    (#set! injection.language "sql")))
