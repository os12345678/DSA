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

## About the algorithm

The algorithm is implemented using a modified depth-first search algorithm. The input is a directed graph, and the output is a list of vertices in topological order. The algorithm works by performing a depth-first search on the graph, and adding each vertex to the output list in reverse order of when it is finished being explored. This is done by using a stack to store the vertices in the order they are finished being explored. The algorithm is implemented in the `tsort` function in `src/tsort.ml`.

- Input `graph`: (int \* int list) list --> i.e [(1, [2; 3]); (2, [5; 4])];;

- Output `tsort`: int list --> i.e [1; 2; 3; 5; 4];;

For more information about the algorithm, its implementation, complexity, limitations, and assumptions, see the [report](https://github.com/os12345678/DSA/blob/master/report.tex)

## Compiling the program

First run `make install` to install all required dependencies. If ther is an error, double check your ocaml compiler is up to date. Running `opam switch list` will show you which version of the compiler you are using. For reference, the compiler version used to develop this program is `4.14.0`.

Then run `make build` to build the program.

Then run `make run` to run the program. This command will run the program and print out the topological sort of the graph.

To run the program with different graphs, it can be done by either:

- Changing the `graph` definition in `tsort.ml`, and re-running `make build` and then `make run`

- (Recommended) In the command line type `utop` to open up OCaML's universal toplevel. This is for testing out small snippets of code. Then type `#use "tsort.ml"` to load the code from `tsort.ml`. Then type `tsort [graph of choice]` (for example `tsort [(1, [2; 3]); (2, [5; 4])];;`)to run the program with different input graphs. Refer to the type of graph needed to be passed into the tsort function, above.

## Testing

The tests are located in the `test/` folder. The tests are written using the Jane Streets' `ppx_expect` testing framework which mimics the existing inline tests framework with the `let%expect` construct. The expectations of the tests were built using the `ppx_expect` auto-generated test output. The library generates `.ml.corrected` files in the `_build/` directory when the tets are run. This is done using the command `dune runtest --auto-promote`.

To run the tests, run `make test`.

The tests are not exhaustive, and are only meant to test the basic functionality of the program.

P.s I am unsure how to test for exceptions without including a backtrace in the testing expectation, the compiler screams at me for doing so. I have commented those particular tests out for now, but the program does throw exceptions when it is supposed to.
