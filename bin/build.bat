@echo off
set OCAMLLIB=.\win64ocaml\lib\ocaml

set ocamlyacc=.\win64ocaml\bin\ocamlyacc.exe
set ocamllex=.\win64ocaml\bin\ocamllex.exe
set ocamlc=.\win64ocaml\bin\ocamlc.exe

%ocamlyacc% .\parser.mly
%ocamllex% .\lexer.mll
%ocamlc% -c .\*.mli
%ocamlc% .\parser.ml .\lexer.ml .\calc.ml -o .\calc