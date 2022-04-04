FROM ocaml/opam:debian-11-ocaml-4.12-nnp AS builder

COPY . .

USER root

RUN opam install ocamlfind base core \
    && eval `opam env` \
    && ocamlfind ocamlopt -o /opt/new_user -thread -linkpkg -package base,core main.ml

FROM frolvlad/alpine-glibc:glibc-2.34

COPY --from=builder /opt/new_user /opt/new_user

RUN mkdir /opt/templates/

WORKDIR /opt

ENTRYPOINT ["/opt/new_user"]
