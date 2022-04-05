type in_file = string

type out_file = string

let base_path = "templates/"

let create name = base_path ^ name

let create_in = create

let create_out = create

let read_lines file = Core.In_channel.read_lines ~fix_win_eol:true file

let write_all file data = Core.Out_channel.write_all ~data file 


