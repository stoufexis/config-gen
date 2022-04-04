open Base

let replace ~patterns ~replacements template =
  let open String in
  match List.zip patterns replacements with
  | Ok l ->
      List.fold l ~init:template ~f:(fun t (p, w) ->
          Search_pattern.replace_all p ~in_:t ~with_:w )
  | Unequal_lengths ->
      failwith "Patterns and arguments of different lengths"

let read_lines_file = Core.In_channel.read_lines ~fix_win_eol:true

let split_patterns_line p =
  match String.split ~on:'!' p with
  | [_; patterns] ->
      String.split ~on:',' patterns
  | _ ->
      failwith "Mallformed patterns line"

let () =
  let open Array in
  let open String in
  match Array.to_list @@ Sys.get_argv () with
  | _ :: template_file :: args -> (
    match read_lines_file @@ "templates/" ^ template_file with
    | patterns :: template ->
        let search_patterns =
          List.map ~f:Search_pattern.create @@ split_patterns_line patterns
        in
          String.concat ~sep:"\n" template
          |> replace ~patterns:search_patterns ~replacements:args
          |> Stdlib.print_endline
    | [] ->
        failwith "Empty template" )
  | [_] ->
      failwith "Not enough arguments"
  | [] ->
      (*Should be unreachable*)
      failwith "Something went wrong"
