open Syntax

(* 仮想スタックマシンの命令の宣言 *)
type t =
  | LPush of string
  | RValue of string
  | Push of int
  | PLUS
  | MINUS
  | TIMES
  | DIV
  | LabelTest of string * string (* test, out *)
  | LabelOut of string * string  (* test, out *)
  | GoTo of string
  | GoFalse of string
  | NOT
  | AND
  | OR
  | TRUE
  | FALSE
  | EQ
  | LT
  | LE
  | GT
  | GE
  | PRINT

(* While言語の変数、数値や演算を仮想スタックマシンの命令へ変換する *)
let rec compile_arith (arith : a) : t list =
  match arith with
  | Var id -> [RValue (id)]
  | Num n -> [Push n]
  | Add (lhs, rhs) ->
    (compile_arith lhs) @ (compile_arith rhs) @ [PLUS]

(* While言語の条件式を仮想スタックマシンの命令へ変換する *)
let rec compile_predicate (predicate : p) : t list =
  match predicate with
  | True -> [TRUE]
  | False -> [FALSE]
  | Not (p) -> (compile_predicate p) @ [NOT]
  | And (p1, p2) -> (compile_predicate p1) @ (compile_predicate p2) @ [AND]
  | Or (p1, p2) -> (compile_predicate p1) @ (compile_predicate p2) @ [OR]
  | LT (a1, a2) -> (compile_arith a1) @ (compile_arith a2) @ [LT]

let count = ref (-1)
let gen_label () =
  count := !count + 1;
  "L." ^ (string_of_int !count)

let reset () =
  count := (-1)

(* While言語の文を仮想スタックマシンの命令へ変換する *)
let rec compile_statement (statement : s) : t list =
  match statement with
  | Assign (id, arith) ->
    (compile_arith arith) @ [LPush (id)]
  | Skip -> []
  (* | Block s ->  s を compile_statement でコンパイルした結果を返す *)
  (* | Seq (s1, s2) ->  s1 と s2 をコンパイルした結果を連結する *)
  (* | While (pred, stmt) -> *)
  (* 以下、実装の手順を示す *)
  (* gen_label () を実行して test ラベルを生成 *)
  (* gen_label () を実行して out ラベルを生成 *)
  (* 以下の順番でバイトコードを組み立てる *)
  (* LabeLtest (test, out) *)
  (* predicate を compile_predicate でコンパイルした結果 *)
  (* GoFalse out *)
  (* stmt を compile_statement でコンパイルした結果 *)
  (* Goto test *)
  (* LabelOut (test, out) *)
  | Print (arith) ->
    (compile_arith arith) @ [PRINT]
  | _ -> failwith "Unsupported statement"


let compile statement =
  reset ();
  compile_statement statement

let print_t oc t =
  match t with
  | LPush (id) -> Printf.fprintf oc "lpush\t%s\n" id
  | RValue (id) -> Printf.fprintf oc "rvalue\t%s\n" id
  | Push (n) -> Printf.fprintf oc "push\t%d\n" n
  | PLUS -> Printf.fprintf oc "+\n"
  | MINUS -> Printf.fprintf oc "-\n"
  | TIMES -> Printf.fprintf oc "*\n"
  | DIV -> Printf.fprintf oc "/\n"
  | LT -> Printf.fprintf oc "<\n"
  | LE -> Printf.fprintf oc "<=\n"
  | GT -> Printf.fprintf oc ">\n"
  | GE -> Printf.fprintf oc ">=\n"
  | EQ -> Printf.fprintf oc ">=\n"
  | NOT -> Printf.fprintf oc "not\n"
  | AND -> Printf.fprintf oc "and\n"
  | OR -> Printf.fprintf oc "or\n"
  | TRUE-> Printf.fprintf oc "true\n"
  | FALSE-> Printf.fprintf oc "false\n"
  | LabelTest (l, m) -> Printf.fprintf oc "label\t%s\n" l
  | LabelOut (l, m) -> Printf.fprintf oc "label\t%s\n" m
  | GoFalse (l) -> Printf.fprintf oc "gofalse\t%s\n" l
  | GoTo (l) -> Printf.fprintf oc "goto\t%s\n" l
  | PRINT -> Printf.fprintf oc "print\n"

let rec print_code oc code =
  match code with
  | [] -> ()
  | hd :: tl -> print_t oc hd; print_code oc tl
