let test_syntax s =
  let l = Lexing.from_string s in
  Parser.start Lexer.token l
  |> Syntax.string_of_statement
  |> print_endline

let test_stack_ops s =
  let l = Lexing.from_string s in
  Parser.start Lexer.token l
  |> Virtual_stack.compile
  |> Virtual_stack.print_code stdout

let () =
    test_syntax "i := i + 1;";
    (* test_syntax "i := i - 1;"; *)
    (* test_syntax "i := i * 1;"; *)
    (* test_syntax "i := i / 1;"; *)
    test_stack_ops "i := i + 1;";
    (* test_stack_ops "i := i - 1;"; *)
    (* test_stack_ops "i := i * 1;"; *)
    (* test_stack_ops "i := i / 1;"; *)
