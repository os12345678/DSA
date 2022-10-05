default:
	opam update
	opam install . --deps-only
	dune build

build:
	dune build

install:
	opam update
	opam install --yes . --deps-only
	
test:
	dune runtest 

run:
	ocaml src/tsort.ml

clean:
	dune clean
	git clean -dfX
	rm -rf docs/

doc:
	make clean
	dune build @doc
	mkdir docs/
	cp	-r ./_build/default/_doc/_html/* docs/

