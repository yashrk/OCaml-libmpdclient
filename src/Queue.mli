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

(** Module for Mpd current playlist manipulation. *)

(** Playlist type. *)
type p =
  | PlaylistError of string
  | Playlist of Song.s list

(** Adds the file URI to the playlist (directories add recursively). URI can
    also be a single file. *)
val add:
  Client.c -> string -> Protocol.response

(** Adds a song to the playlist (non-recursive) and returns the song id.
    URI is always a single file or URL. *)
val addid:
  Client.c -> string -> int -> int

(** Clears the current playlist. *)
val clear:
  Client.c -> Protocol.response

(** Deletes a song or a set of songs from the playlist. The song or the range
    of songs are identified by the position in the playlist. *)
val delete:
  Client.c -> int -> ?position_end:int -> unit -> Protocol.response

(** Deletes the song SONGID from the playlist. *)
val deleteid:
  Client.c -> int -> Protocol.response

(** Moves the song at FROM or range of songs at START:END to TO in
    the playlist. *)
val move:
  Client.c -> int -> ?position_end:int -> int -> unit -> Protocol.response

(** Moves the song with FROM (songid) to TO (playlist index) in the playlist.
    If TO is negative, it is relative to the current song in the playlist
    (if there is one). *)
val moveid:
  Client.c -> int -> int -> Protocol.response

(** Get the songs in the playlist *)
val playlist:
  Client.c -> p

(** Get information for one song *)
val playlistid:
  Client.c -> int -> p

(** Finds songs in the current playlist with strict matching.*)
val playlistfind:
  Client.c -> string -> string -> p

(** Searches case-insensitively for partial matches in the current playlist. *)
val playlistsearch:
  Client.c -> string -> string -> p

(** Swaps the positions of SONG1 and SONG2. *)
val swap:
  Client.c -> int -> int -> Protocol.response

(** Shuffles the current playlist. START:END is optional and specifies a range
    of songs. *)
val shuffle:
  Client.c -> ?range:(int * int) -> unit -> Protocol.response

(** Set the priority of the specified songs. A higher priority means that it
    will be played first when "random" mode is enabled.
    A priority is an integer between 0 and 255. The default priority of new
    songs is 0. *)
val prio:
  Client.c -> int -> ?range:(int * int) -> unit -> Protocol.response

(** Same as prio, but address the songs with their id. *)
val prioid:
  Client.c -> int -> int list -> Protocol.response

(** Swaps the positions of SONG1 and SONG2 (both song ids). *)
val swapid:
  Client.c -> int -> int -> Protocol.response

(** Specifies the portion of the song that shall be played. START and END are
  offsets in seconds (fractional seconds allowed); both are optional. Omitting
  both (i.e. sending just ":") means "remove the range, play everything". A song
  that is currently playing cannot be manipulated this way. *)
val rangeid:
  Client.c -> int -> ?range:(float * float) -> unit -> Protocol.response

(** Removes tags from the specified song. If TAG is not specified, then all tag
    values will be removed. Editing song tags is only possible for remote songs.
*)
val cleartagid:
  Client.c -> int -> string -> Protocol.response

(*
  plchanges {VERSION} [START:END]
  plchangesposid {VERSION} [START:END]
  addtagid {SONGID} {TAG} {VALUE}
*)