type t

type args

val fill : t -> with_:args -> string

val from_file : File.in_file -> t

val args_from_string : string -> args
