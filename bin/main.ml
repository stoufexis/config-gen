open Base
open Config_gen

let get_args () =
  match Array.to_list (Base.Sys.get_argv ()) with
  | _ :: args ->
      args
  | [] ->
      failwith "No arguments"

(* (1* template.ldif:uid,name,surname:output.ldif template.ldif:uid,name,surname:output.ldif template.ldif:uid,name,surname:output.ldif *1) *)

let parse_arg arg =
  match String.split ~on:':' arg with
  | [template_file; args; output_file] ->
      let template = File.create_in template_file |> Template.from_file in
      let args = Template.args_from_string args in
      let out = File.create_out output_file in
        (template, args, out)
  | _ ->
      failwith "Malformed task"

let () =
  let fill_and_write (template, args, out) =
    Template.fill template ~with_:args |> File.write_all out
  in
    List.map ~f:parse_arg (get_args ()) |> List.iter ~f:fill_and_write
