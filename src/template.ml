open Base

type t = Pattern.t list * string

let fill_template (patterns, template_str) ~with_ =
  let open String in
  let replace_one_pattern template (pattern, with_) =
    Search_pattern.replace_all
      (Pattern.to_search_pattern pattern)
      ~in_:template ~with_
  in
    match List.zip patterns with_ with
    | Ok l ->
        List.fold l ~init:template_str ~f:replace_one_pattern
    | Unequal_lengths ->
        failwith "Patterns and arguments of different lengths"

let from_file file =
  let lines =
    Core.In_channel.read_lines ~fix_win_eol:true ("templates/" ^ file)
  in
    match lines with
    | decleration :: template_lines ->
        let patterns = Pattern.from_patterns_decleration decleration in
        let template_str = String.concat ~sep:"\n" template_lines in
          (patterns, template_str)
    | [] ->
        failwith "Empty template"
