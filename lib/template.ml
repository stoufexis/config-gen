open Base

(* (patterns * template) *)
type t = string list * string

type args = string list

let args_from_string = String.split ~on:','

let fill (patterns, template_str) ~with_ =
  let open String in
  let replace_one_pattern template (pattern, with_) =
    Search_pattern.replace_all
      (Search_pattern.create pattern)
      ~in_:template ~with_
  in
    match List.zip patterns with_ with
    | Ok l ->
        List.fold l ~init:template_str ~f:replace_one_pattern
    | Unequal_lengths ->
        failwith "Patterns and arguments of different lengths"

let patterns_from_decleration decleration =
  match String.split ~on:'!' decleration with
  | [_; patterns] ->
      String.split ~on:',' patterns
  | _ ->
      failwith "Mallformed patterns decleration"

let from_file file =
  match File.read_lines file with
  | decleration :: template_lines ->
      ( patterns_from_decleration decleration
      , String.concat ~sep:"\n" template_lines )
  | [] ->
      failwith "Empty template"
