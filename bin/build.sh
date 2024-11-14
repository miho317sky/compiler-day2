#/bin/sh
export OCAMLLIB=./win64ocaml/lib/ocaml
OCAMLC=./win64ocaml/bin/ocamlc.exe 

echo "generating lexer.ml" && 
	./win64ocaml/bin/ocamllex.exe lexer.mll && \
	echo "generate parser.ml" && \
	./win64ocaml/bin/ocamlyacc.exe parser.mly && 
	echo "compile ocaml sources" && \
	${OCAMLC} -c parser.mli && \
	${OCAMLC} syntax.ml parser.ml lexer.ml virtual_stack.ml main.ml -o while_lang

