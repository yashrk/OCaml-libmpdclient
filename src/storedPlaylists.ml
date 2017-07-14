(*
 * Copyright 2017 Cedric LE MOIGNE, cedlemo@gmx.com
 * This file is part of OCaml-libmpdclient.
 *
 * OCaml-libmpdclient is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OCaml-libmpdclient is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCaml-libmpdclient.  If not, see <http://www.gnu.org/licenses/>.
 *)

let listplaylists client =
  match Mpd.Client.send client "listplaylists" with
  | Protocol.Error (ack_val, ack_cmd_num, ack_cmd, ack_message)-> None
  | Protocol.Ok (response) -> Some (Mpd_utils.read_list_playlists response)

let load client playlist ?range () =
  let request = match range with
    | None -> "load " ^ playlist
    | Some (s, e) -> let r = String.concat ":" [string_of_int s; string_of_int e] in
      String.concat " " ["load"; playlist; r]
  in
  Mpd.Client.send client request

let playlistadd client playlist uri =
  let request = String.concat " " ["playlistadd"; playlist; uri] in
  Mpd.Client.send client request

let playlistclear client playlist =
  let request = "playlistclear " ^ playlist in
  Mpd.Client.send client request

let playlistdelete client playlist position =
  let request = String.concat " " ["playlistclear";
                                   playlist;
                                   string_of_int position] in
  Mpd.Client.send client request
