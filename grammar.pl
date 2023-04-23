expr --> term, [or], expr.
expr --> term.

term --> factor, [and], term.
term --> factor.

factor --> [not], factor.
factor --> [true].
factor --> [false].
factor --> variable.
factor --> ['(', expr, ')'].
factor --> variable, [implies], factor.

variable --> [X], { atom(X), \+ member(X, [true, false, not, and, or, implies]) }.