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

(** Module for Mpd current playlist manipulation in Lwt threads. *)

(** Playlist type *)
type p =
  | PlaylistError of string
  | Playlist of Song.s list

(** Adds the file URI to the playlist (directories add recursively). URI can
    also be a single file. *)
val add:
  Mpd.LwtClient.c -> string -> Protocol.response Lwt.t

(** Adds a song to the playlist (non-recursive) and returns the song id.
    URI is always a single file or URL. For example: *)
val addid:
  Mpd.LwtClient.c -> string -> int -> int Lwt.t

(** Clears the current playlist. *)
val clear:
  Mpd.LwtClient.c -> Protocol.response Lwt.t

(** Deletes a song or a set of songs from the playlist. The song or the range
    of songs are identified by the position in the playlist. *)
val delete:
  Mpd.LwtClient.c -> int -> ?position_end:int -> unit -> Protocol.response Lwt.t

(** Deletes the song SONGID from the playlist. *)
val deleteid:
  Mpd.LwtClient.c -> int -> Protocol.response Lwt.t

(** Moves the song at FROM or range of songs at START:END to TO in
    the playlist. *)
val move:
  Mpd.LwtClient.c -> int -> ?position_end:int -> int -> unit -> Protocol.response Lwt.t

(** Moves the song with FROM (songid) to TO (playlist index) in the playlist.
    If TO is negative, it is relative to the current song in the playlist
    (if there is one). *)
val moveid:
  Mpd.LwtClient.c -> int -> int -> Protocol.response Lwt.t

(** Get a list of Song.s that represents all the songs in the current
    playlist. *)
val playlist:
  Mpd.LwtClient.c -> p Lwt.t

(** Get a list with the Song.s of the song id in the playlist *)
val playlistid:
  Mpd.LwtClient.c -> int -> p Lwt.t

(** Finds songs in the current playlist with strict matching.*)
val playlistfind:
  Mpd.LwtClient.c -> string -> string -> p Lwt.t

(** Searches case-insensitively for partial matches in the current playlist. *)
val playlistsearch:
  Mpd.LwtClient.c -> string -> string -> p Lwt.t

(** Swaps the positions of SONG1 and SONG2. *)
val swap:
  Mpd.LwtClient.c -> int -> int -> Protocol.response Lwt.t

(** Shuffles the current playlist. START:END is optional and specifies a range
    of songs. *)
val shuffle:
  Mpd.LwtClient.c -> ?range:(int * int) -> unit -> Protocol.response Lwt.t

(** Set the priority of the specified songs. A higher priority means that it
    will be played first when "random" mode is enabled.
    A priority is an integer between 0 and 255. The default priority of new
    songs is 0. *)
val prio:
  Mpd.LwtClient.c -> int -> ?range:(int * int) -> unit -> Protocol.response Lwt.t

(** Same as prio, but address the songs with their id. *)
val prioid: Mpd.LwtClient.c -> int -> int list -> Protocol.response Lwt.t


