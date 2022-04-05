open Base

type t = String.t

let from_patterns_decleration decleration =
  match String.split ~on:'!' decleration with
  | [_; patterns] ->
      String.split ~on:',' patterns
  | _ ->
      failwith "Mallformed patterns decleration"

let to_search_pattern = String.Search_pattern.create
