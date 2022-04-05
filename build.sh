cd src

build_dir=$1

ocamlfind ocamlopt -o $build_dir/program -thread -linkpkg \
  -package base,core \
  pattern.mli \
  pattern.ml \
  template.mli \
  template.ml \
  main.ml

mv -t $build_dir *.cmi *.cmx *.o
