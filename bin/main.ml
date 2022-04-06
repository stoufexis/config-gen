open Base
open Mylib

let get_args () =
  match Array.to_list (Base.Sys.get_argv ()) with
  | _ :: args ->
      args
  | [] ->
      failwith "No arguments"

let () =
  get_args ()
  |> List.map ~f:Execute.parse_arg
  |> Execute.execute
