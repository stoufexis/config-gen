FROM ocaml/opam:debian-11-ocaml-4.12-nnp AS builder

COPY . .

USER root

RUN opam install ocamlfind base \
    && eval `opam env` \
    && ocamlfind ocamlopt -o /opt/new_user -linkpkg -package base main.ml

FROM debian:buster-slim

COPY --from=builder /opt/new_user /opt/new_user

ENTRYPOINT ["/opt/new_user"]
