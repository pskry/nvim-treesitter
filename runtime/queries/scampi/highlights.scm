; Keywords
[
  "module"
  "import"
  "pub"
  "let"
  "type"
  "enum"
  "decl"
] @keyword

[
  "func"
] @keyword.function

[
  "return"
] @keyword.return

[
  "if"
  "else"
] @keyword.conditional

[
  "for"
  "in"
] @keyword.repeat

; Literals
(true) @boolean
(false) @boolean
(none) @constant.builtin
(self) @variable.builtin
(integer) @number
(string) @string
(multiline_string) @string
(escape_sequence) @string.escape
(multiline_escape_sequence) @string.escape
(interpolation
  "${" @punctuation.special
  "}" @punctuation.special)
(comment) @comment @spell

; Declarations
(module_declaration
  (identifier) @module)

(import_declaration
  (string) @string.special)

(type_declaration
  (identifier) @type.definition)

(attribute_type_declaration
  "@" @attribute
  (identifier) @attribute)

(enum_declaration
  (identifier) @type.definition)

(func_declaration
  (identifier) @function)

(decl_declaration
  (dotted_name) @function)

(let_declaration
  (identifier) @variable)

; Attributes (prefix annotations on field definitions)
(attribute
  "@" @attribute
  (dotted_name
    (identifier) @attribute))

(attribute_named_argument
  name: (identifier) @property)

; Fields and parameters
(field_definition
  (identifier) @variable.parameter)

(field_initializer
  name: (identifier) @property)

(keyword_argument
  name: (identifier) @property)

; Type expressions
(named_type
  (dotted_name
    (identifier) @type))

(generic_type
  (identifier) @type)

(optional_type
  "?" @punctuation.special)

; Struct literal type: only the LAST identifier in the dotted_name is the
; "type" — earlier identifiers are namespaces (e.g. in `posix.firewall { ... }`,
; `posix` is the module and `firewall` is the type). The `.` anchor constrains
; the captured identifier to be the last child of the dotted_name.
(struct_literal
  type: (dotted_name
    (identifier) @type .))

; Expressions
;
; NOTE on query order: nvim-treesitter resolves overlapping captures with
; "last match wins" semantics. The @property query at the bottom matches every
; `selector_expression field`, so anything that should override it must come
; AFTER it. Order here is intentional:
;   1. plain method calls         → @function.method.call
;   2. plain function calls       → @function.call
;   3. fallback for any selector  → @property
;   4. builtin calls              → @function.builtin (overrides @function.call)
;   5. block-expression targets   → @function.builtin (overrides everything above)

(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (selector_expression
    field: (identifier) @function.method.call))

(selector_expression
  field: (identifier) @property)

; Builtin function calls
((call_expression
  function: (identifier) @function.builtin)
 (#any-of? @function.builtin "len" "int"))

; Block expressions reify a block on top of a call (e.g. `std.deploy(...) { ... }`).
; Highlight the trailing identifier of the call's target as @function.builtin so it
; visually distinguishes from plain method calls — this is a special construct
; that takes both arguments and a body. @function.builtin renders orange in most
; colorschemes (gruvbox, tokyonight, catppuccin). This query MUST come after
; the @property and @function.method.call rules so its capture wins.
(block_expression
  target: (call_expression
    function: (selector_expression
      field: (identifier) @function.builtin)))

(block_expression
  target: (call_expression
    function: (identifier) @function.builtin))

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "%"
  "=="
  "!="
  "<"
  ">"
  "<="
  ">="
  "&&"
  "||"
  "!"
  "="
] @operator

; Punctuation
["(" ")" "[" "]" "{" "}"] @punctuation.bracket
["," "." ":" "?"] @punctuation.delimiter

; Error
(ERROR) @error
