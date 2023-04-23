# line2surface

Compiles simple statements into RDF Surfaces.

## Usage

```
./line2surface "disj(a,b)"

./line2surface "proves(conj(disj(a,b),neg(b)),a)" | eye --quiet --blogic -

````

## Statements

- conj(A,B)
- disj(A,B)
- impl(A,B)
- proves(A,B)
