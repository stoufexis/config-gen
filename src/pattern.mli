open Base

type t = String.t

val from_patterns_decleration: string -> t list

val to_search_pattern: ?case_sensitive:bool -> t -> Base.String.Search_pattern.t
