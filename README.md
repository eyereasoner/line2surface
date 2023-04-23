# line2surface

Compiles simple statements into RDF Surfaces.

## Usage

```
./line2surface "disj(a,b)"

./line2surface "proves(conj(disj(a,b),neg(b)),a)" | eye --quiet --blogic -

./line2surface examples/example1.pml

````

## Statements

- neg(A,B)
- conj(A,B)
- disj(A,B)
- impl(A,B)
- proves(A,B)

where A and B are simple letters: a, b, c, ...
