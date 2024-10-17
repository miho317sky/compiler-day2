let test_syntax s =
  print_string "[TEST syntax]\n";
  print_string "input: ";
  print_endline s;
  print_string "output: ";
  let l = Lexing.from_string s in
  Parser.start Lexer.token l
  |> Syntax.string_of_statement
  |> print_string

let test_stack_ops s =
  print_string "[TEST stack ops]\n";
  print_string "input: ";
  print_endline s;
  print_endline "output: ";
  let l = Lexing.from_string s in
  Parser.start Lexer.token l
  |> Virtual_stack.compile
  |> Virtual_stack.print_code stdout

let () =
    test_syntax "i := i + 1;";
    test_syntax "i := i - 1;";
    (* test_syntax "i := i * 1;"; *)
    (* test_syntax "i := i / 1;"; *)
    test_stack_ops "i := i + 1;";
    test_stack_ops "i := i - 1;";
    (* test_stack_ops "i := i * 1;"; *)
    (* test_stack_ops "i := i / 1;"; *)
