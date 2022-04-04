
module Pattern : sig
  open Base

  type t

  val from_patterns_decleration : string -> t list

  val to_search_pattern : ?case_sensitive:bool -> t -> String.Search_pattern.t
end = struct
  open Base

  type t = String.t

  let from_patterns_decleration decleration =
    match String.split ~on:'!' decleration with
    | [_; patterns] ->
        String.split ~on:',' patterns
    | _ ->
        failwith "Mallformed patterns decleration"

  let to_search_pattern = String.Search_pattern.create
end

open Base

let replace_all ~patterns ~with_ template_str =
  let open String in
  let replace_one_pattern template (pattern, with_) =
    Search_pattern.replace_all pattern ~in_:template ~with_
  in
    match List.zip patterns with_ with
    | Ok l ->
        List.fold l ~init:template_str ~f:replace_one_pattern
    | Unequal_lengths ->
        failwith "Patterns and arguments of different lengths"

let read_lines_file = Core.In_channel.read_lines ~fix_win_eol:true

let get_and_replace_with ~template_file args =
  let open String in
  match read_lines_file ("templates/" ^ template_file) with
  | decleration :: template ->
      let search_patterns =
        List.map ~f:Pattern.to_search_pattern
          (Pattern.from_patterns_decleration decleration)
      in
        String.concat ~sep:"\n" template
        |> replace_all ~patterns:search_patterns ~with_:args
        |> Stdlib.print_endline
  | [] ->
      failwith "Empty template"

let get_args () = Array.to_list (Sys.get_argv ())

let () =
  let open Array in
  match get_args () with
  | _ :: template_file :: args ->
      get_and_replace_with ~template_file args
  | [_] ->
      failwith "Not enough arguments"
  | [] ->
      failwith "Something went wrong"
