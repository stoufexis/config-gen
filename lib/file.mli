type in_file

type out_file

val create_in : string -> in_file

val create_out : string -> out_file

val read_lines : in_file -> string list

val write_all : out_file -> string -> Unit.t
