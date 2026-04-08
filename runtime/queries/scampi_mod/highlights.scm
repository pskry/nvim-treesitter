; Keywords
[
  "module"
  "require"
] @keyword

; Module path
(module_directive
  (module_path) @module)

(dependency
  (module_path) @string.special)

; Versions
(version) @string

; Local paths
(local_path) @string.special.path

; Indirect marker
(indirect_marker) @attribute

; Comments
(comment) @comment @spell

; Punctuation
["(" ")"] @punctuation.bracket

; Error
(ERROR) @error
