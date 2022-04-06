open Base

type arg = Template.t Option.t * Template.args * File.out_file

let parse_arg arg =
  match String.split ~on:':' arg with
  | [template_file; args; output_file] ->
      let template =
        match template_file with
        | "" ->
            Option.None
        | file ->
            Option.Some (File.create_in file |> Template.from_file)
      in
      let args = Template.args_from_string args in
      let out = File.create_out output_file in
        (template, args, out)
  | _ ->
      failwith ("Malformed argument: '" ^ arg ^ "'")

let fill_and_write (t, t_args, out_f) =
  Template.fill t ~with_:t_args |> File.write_all out_f

let execute args =
  let open Option in
  let rec loop last_template = function
    | ((Some t as new_template), t_args, out_f) :: tl ->
        fill_and_write (t, t_args, out_f) ;
        loop new_template tl
    | (None, t_args, out_f) :: tl -> (
      match last_template with
      | None ->
          failwith "No initial template given"
      | Some t ->
          fill_and_write (t, t_args, out_f) ;
          loop last_template tl )
    | [] ->
        ()
  in
    loop None args
