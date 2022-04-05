FROM ocaml/opam:debian-11-ocaml-4.12-nnp AS builder

COPY . .

USER root

RUN opam install ocamlfind base core \
    && eval `opam env` \
    && ./build.sh /opt/

FROM frolvlad/alpine-glibc:glibc-2.34

COPY --from=builder /opt/program /opt/program

RUN mkdir /opt/templates/

WORKDIR /opt

ENTRYPOINT ["/opt/program"]
