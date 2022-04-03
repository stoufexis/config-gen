open Base

let template =
  "dn: uid=?uid,ou=users,dc=draive,dc=gr\n"
  ^ "objectclass: top\n"
  ^ "objectclass: person\n"
  ^ "objectclass: organizationalPerson\n"
  ^ "objectclass: inetOrgPerson\n"
  ^ "objectclass: PostfixBookMailAccount\n"
  ^ "uid: ?uid\n"
  ^ "givenName: ?n\n"
  ^ "sn: ?sn\n"
  ^ "cn: ?uid\n"
  ^ "mail: ?uid@draive.gr\n"
  ^ "userPassword: secret\n"
  ^ "mailHomeDirectory: /var/mail/\n"
  ^ "mailUidNumber: 5000\n"
  ^ "mailGidNumber: 5000\n"
  ^ "mailStorageDirectory: maildir:~/MailDir\n"


open String.Search_pattern

let uid = create "?uid"

let name = create "?n"

let surname = create "?sn"

let run pttrs withs =
  match List.zip pttrs withs with
  | Ok l ->
      List.fold l ~init:template ~f:(fun t (p, w) ->
          replace_all p ~in_:t ~with_:w )
  | Unequal_lengths ->
      failwith "Patterns and arguments of different lengths"


let () =
  let open Array in
  match Array.to_list @@ Sys.get_argv () with
  | hd :: tl -> run [ uid; name; surname ] tl |> Stdlib.print_endline
  | [] -> failwith "Unreachable case"
