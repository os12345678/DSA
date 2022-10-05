# 41052 Advanced Algorithms Assignment 1: Topological Sort

## Tutorials

Accompanying this repo are two tutorials:

- [Dune](https://mukulrathi.netlify.app/ocaml-tooling-dune/)
- [OCaml Testing and CI](https://mukulrathi.netlify.app/ocaml-testing-frameworks/)

## The Makefile

The Makefile consists of a list of useful commands:

`make install` installs all the opam dependencies needed to use this repo

`make build` runs the dune build system

`make test` runs test suite

`make doc` generates the documentation and copies it into a `docs/` folder in the root of the repo`.

## Generating Documentation: TODO

The repo uses GitHub Pages to display the [generated documentation](http://ocamltest.os12345678.com/).

## About the algorithm

The algorithm is implemented using a modified depth-first search algorithm. The input is a directed graph, and the output is a list of vertices in topological order. The algorithm works by performing a depth-first search on the graph, and adding each vertex to the output list in reverse order of when it is finished being explored. This is done by using a stack to store the vertices in the order they are finished being explored. The algorithm is implemented in the `tsort` function in `src/tsort.ml`.

- Input `graph`: (int \* int list) list --> i.e [(1, [2; 3]); (2, [5; 4])];;

- Output `tsort`: int list --> i.e [1; 2; 3; 5; 4];;

For more information about the algorithm, its implementation, complexity, limitations, and assumptions, see the [report](https://github.com/os12345678/DSA/blob/master/40152%20Advanced%20Algorithms%20Assignment%201.docx)

## Compiling the program

First run `make build` to build the project. There should be no errors or warnings.

Then run `make run` to run the program. This command will run the program and print out the topological sort of the graph.

To run the program with different graphs, it can be done by either:

- Changing the `graph` definition in `tsort.ml`, and re-running `make run`

- (Recommended) In the command line type `utop` to open up OCaML's universal toplevel. This is for testing out small snippets of code. Then type `#use "tsort.ml"` to load the code from `tsort.ml`. Then type `tsort [graph of choice]` to run the program with custom graphs. Refer to the type of graph needed to be passed into the tsort function, above.

## Testing

The tests are located in the `test/` folder. The tests are written using the Jane Streets' `ppx_expect` testing framework which mimics the existing inline tests framework with the `let%expect` construct.

To run the tests, run `make test`.
