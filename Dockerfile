FROM ocaml/opam:debian-11-ocaml-4.12-nnp AS builder

COPY . /opt

USER root

RUN opam install ocamlfind base core dune \
    && eval `opam env` \
    && cd /opt \
    && dune build

FROM frolvlad/alpine-glibc:glibc-2.34

COPY --from=builder /opt/_build/default/bin/main.exe /opt/run

RUN mkdir /opt/templates/

WORKDIR /opt

ENTRYPOINT ["/opt/run"]
