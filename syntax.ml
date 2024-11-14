(* https://www.cs.cmu.edu/~aldrich/courses/15-819O-13sp/resources/ *)
(* Whie言語の文法を定義する *)
(* 具体的には、 type 宣言を使ってデータ型を定義する *)

open Printf

type id = string
type num = int

(* arithmetic expressions *)
type a =
  | Var of id                   (* Var 型。引数は文字列 id *)
  | Num of num                  (* Num 型。引数は数値 num *)
  | Add of a * a                (* Add 型。引数はタプル (arith, arith)。*)
(* 再帰的な定義も可能 *)

(* boolean predicates *)
type p =
    True                        (* True 型。引数はなし。 *)
  | False
  | Not of p
  | And of p * p
  | Or of p * p                 (* Or 型。 (x | y) に相当。 *)
  | LT of a * a                 (* LT 型。 (x < y) に相当。 *)

(* statements *)
type s =
  | Skip
  | Assign of id * a           (* Assign型。 x := 1; に相当。*)
  | Print of a                 (* Print 型。 print 1 に相当 *)

(* デバッグ用の補助関数。 Syntax を文字列として表示する *)
let rec string_of_arith a =
  match a with
  | Var id ->  "Var(" ^ id ^ ")"
  | Num n -> "Num(" ^ (string_of_int n) ^ ")"
  | Add (a1, a2) -> "Add(" ^ (string_of_arith a1) ^ ", " ^ (string_of_arith a2) ^ ")"

let rec string_of_predicate p =
  match p with
  | True -> "true"
  | False -> "false"
  | Not p -> "not " ^ (string_of_predicate p)
  | And (p1, p2) -> (string_of_predicate p1) ^ " and " ^ (string_of_predicate p2)
  | Or (p1, p2) -> (string_of_predicate p1) ^ " or " ^ (string_of_predicate p2)
  | LT (a1, a2) -> (string_of_arith a1) ^ " < " ^ (string_of_arith a2)

let rec string_of_statement s =
  match s with
  | Assign (id, a) -> "Assign(" ^ id ^ ", " ^ (string_of_arith a) ^ ")\n"
  | Skip -> sprintf "Skip;\n"
  | Print (a) -> "Print(" ^ (string_of_arith a) ^ ")\n"