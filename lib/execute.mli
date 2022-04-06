open Base

type arg

val parse_arg: string -> arg
(** parses args with the structure:
    template_file:arg,arg2,arg3:output_file *)

val execute: arg list -> Unit.t
(** t referes to template
    allows every following reference to the same template to be omitted, e.g.
    template_file:arg,arg,arg:output_file
    :arg,arg,arg:output_file
    :arg,arg,arg:output_file *)
