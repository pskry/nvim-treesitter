; Scopes
(source_file) @local.scope
(func_declaration) @local.scope
(decl_declaration) @local.scope
(block) @local.scope
(for_statement) @local.scope
(list_comprehension) @local.scope
(map_comprehension) @local.scope

; Definitions
(let_declaration
  (identifier) @local.definition)

(func_declaration
  (identifier) @local.definition)

(decl_declaration
  (dotted_name) @local.definition)

(type_declaration
  (identifier) @local.definition)

(attribute_type_declaration
  (identifier) @local.definition)

(enum_declaration
  (identifier) @local.definition)

(field_definition
  (identifier) @local.definition)

(for_statement
  (identifier) @local.definition)

(list_comprehension
  variable: (identifier) @local.definition)

(map_comprehension
  variable: (identifier) @local.definition)

; References
(identifier) @local.reference
