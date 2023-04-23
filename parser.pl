indent(String,N,Result) :-
    indent(String,N,'',Result).

indent(_,0,Result,Result).

indent(String,N,Acc,Result) :-
    N > 0 ,
    N1 is N - 1 ,
    atom_concat(Acc,String,AccNew),
    indent(String,N1,AccNew,Result) .

concat_strings(Strings,I,Result) :-
    concat_strings(Strings,I,[],T),
    reverse(T,T1),
    atomic_list_concat(T1,'',Result).

concat_strings([], _, Result, Result).

concat_strings([H|T],I,Acc,Result) :-
    indent(" ",I,Is),
    atom_concat(Is,H,T1),
    ( length(T,0) -> T2 = T1 ; atom_concat(T1,"~n",T2) ),
    concat_strings(T,I,[T2|Acc],Result).

indent_fixer(A,I,B) :-
  split_string(A,"\n","",T),
  concat_strings(T,I,B).

parse(_,X,Y) :-
  X =.. L ,
  length(L,1),
  format(atom(Y),":~w a :Verb .",L).

parse(I,X,Y) :-
  X =.. L ,
  length(L,2) ,
  nth0(0,L,A) ,
  nth0(1,L,B) ,
  atom_string(A,"neg"),
  parse(I,B,R),
  J is I + 4,
  indent_fixer(R,J,RS),
  concat_strings([
    "() log:onNegativeSurface {" ,
    RS , 
    "} ."
  ],I,F),
  format(atom(Y),F,[]).

parse(I,X,Y) :-
  X =.. L ,
  length(L,3) ,
  nth0(0,L,A) ,
  nth0(1,L,B) ,
  nth0(2,L,C) ,
  atom_string(A,"conj"),
  parse(I,B,R1) ,
  parse(I,C,R2) ,
  concat_strings([
    "~w",
    "~w"
  ], I, F),
  format(atom(Y),F,[R1,R2]).

parse(I,X,Y) :-
  X =.. L ,
  length(L,3) ,
  nth0(0,L,A) ,
  nth0(1,L,B) ,
  nth0(2,L,C) ,
  atom_string(A,"disj"),
  parse(I,B,R1) ,
  parse(I,C,R2) ,
  J is I + 8,
  indent_fixer(R1,J,R1S),
  indent_fixer(R2,J,R2S),
  concat_strings([
    "() log:onNegativeSurface {",
    "   () log:onNegativeSurface {",
    R1S,
    "   } .",
    "   () log:onNegativeSurface {",
    R2S,
    "   } .",
    "} ."
  ], I, F),
  format(atom(Y),F,[]).

parse(I,X,Y) :-
  X =.. L ,
  length(L,3) ,
  nth0(0,L,A) ,
  nth0(1,L,B) ,
  nth0(2,L,C) ,
  atom_string(A,"impl"),
  parse(I,B,R1) ,
  parse(I,C,R2) ,
  J is I + 4,
  K is I + 8,
  indent_fixer(R1,J,R1S),
  indent_fixer(R2,K,R2S),
  concat_strings([
    "() log:onNegativeSurface {" ,
    R1S ,
    "    () log:onNegativeSurface {",
    R2S ,
    "    } .",
    "} ."
  ], I, F),
  format(atom(Y),F,[]).

parse(I,X,Y) :-
  X =.. L ,
  length(L,3) ,
  nth0(0,L,A) ,
  nth0(1,L,B) ,
  nth0(2,L,C) ,
  atom_string(A,"proves"),
  parse(I,B,R1) ,
  parse(I,C,R2) ,
  J is I + 4,
  indent_fixer(R2,J,R2S),
  concat_strings([
    R1,
    "() log:onQuerySurface {",
    R2S ,
    "}." 
  ],I,F),
  format(atom(Y),F,[]).

run(Formula) :-
  writeln("@prefix : <urn:example:> .") ,
  writeln("@prefix log: <http://www.w3.org/2000/10/swap/log#> .") , 
  parse(0,Formula,String),
  writeln(String),
  fail ; true .
