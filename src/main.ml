let get_args () = Array.to_list (Base.Sys.get_argv ())

let () =
  match get_args () with
  | _ :: template_file :: args ->
      Template.from_file template_file
      |> Template.fill_template ~with_:args
      |> Stdlib.print_endline
  | [_] ->
      failwith "Not enough arguments"
  | [] ->
      failwith "Something went wrong"
