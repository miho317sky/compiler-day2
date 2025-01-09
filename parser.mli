type token =
  | BEGIN
  | END
  | SEMICOLON
  | TRUE
  | FALSE
  | NOT
  | AND
  | OR
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | EQ
  | LT
  | GT
  | LE
  | GE
  | ASSIGN
  | WHILE
  | DO
  | SKIP
  | IF
  | THEN
  | ELSE
  | PRINT
  | NUMBER of (int)
  | VARIANT of (string)
  | EOF

val start :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Syntax.s
val predicate :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Syntax.p
