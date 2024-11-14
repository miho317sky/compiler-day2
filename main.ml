open Syntax

(* 入力文字列が構文木に変換できるか確かめる*)  
let test_syntax s =
  print_string "[TEST syntax]\n";
  print_string "input: ";
  print_endline s;
  print_string "output: ";
  let l = Lexing.from_string s in
  Parser.start Lexer.token l
  |> Syntax.string_of_statement
  |> print_string

(* 入力文字列が仮想スタック命令に変換できるか確かめる*)  
let test_stack_ops s =
  print_string "[TEST stack ops]\n";
  print_string "input: ";
  print_endline s;
  print_endline "output: ";
  let l = Lexing.from_string s in
  Parser.start Lexer.token l
  |> Virtual_stack.compile
  |> Virtual_stack.print_code stdout

(* predicate の構文木を自分で定義し、実際に文字列に変換できるか確かめる *)
let test_syntax_predicate _ =  
  print_string "[TEST predicate]\n";
  let p = LT(Var("i"), Num(2)) in (* i < 2 *)
  print_string (Syntax.string_of_predicate p);
  print_newline ();
  let p = LT (Var ("i"), Add (Var ("i"), Num (2))) in
  print_string (Syntax.string_of_predicate p);
  print_newline ();
  ()

let () =
    test_syntax "i := i + 1;";
    test_syntax "i := i - 1;";
    (* test_syntax "i := i * 1;"; *)
    test_syntax_predicate ();
    test_stack_ops "i := i + 1;";
    (* test_stack_ops "i := i - 1;"; *)
    (* test_stack_ops "i := i * 1;"; *)
    (* test_stack_ops "i := i / 1;"; *)
