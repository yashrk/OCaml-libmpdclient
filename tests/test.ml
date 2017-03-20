(* ocamlfind ocamlc -o test -package oUnit,str -linkpkg -g mpd_responses.ml mpd.ml test.ml *)
(* ocamlfind ocamlc -o test -package oUnit,str,libmpdclient -linkpkg -g test.ml *)

open OUnit2
open Mpd
open Protocol

let test_simple_ok test_ctxt =  assert_equal true (let response = Protocol.parse_response "OK\n" in
match response with
| Ok _ -> true
| Error _ -> false
)

let test_request_ok test_ctxt =  assert_equal true (let response = Protocol.parse_response "test: this is a complex\nresponse: request\nOK\n" in
match response with
| Ok (mpd_response) -> if (mpd_response = "test: this is a complex\nresponse: request\n") then true else false
| Error _ -> false
)
let test_error_50 test_ctxt =  assert_equal true (let response = Protocol.parse_response "ACK [50@1] {play} error while playing\n" in
match response with
| Ok _ -> false
| Error (er_val, cmd_num, cmd, message) -> er_val = No_exist && cmd_num = 1 && cmd = "play" &&
message = "error while playing"
)

let test_error_1 test_ctxt =  assert_equal true (let response = Protocol.parse_response "ACK [1@12] {play} error while playing\n" in
match response with
| Ok _ -> false
| Error (er_val, cmd_num, cmd, message) -> er_val = Not_list && cmd_num = 12 && cmd = "play" &&
message = "error while playing"
)

open Mpd_utils

let test_num_on_num_parse_simple_int test_ctxt =
  let simple_int = "3" in
  match Mpd_utils.num_on_num_parse simple_int with
  | Mpd_utils.Simple n -> assert_equal  3 n
                                        ~msg:"Simple int value"
                                        ~printer:string_of_int
  | _ -> assert_equal false true

let test_num_on_num_parse_num_on_num test_ctxt =
  let simple_int = "3/10" in
  match Mpd_utils.num_on_num_parse simple_int with
  | Mpd_utils.Num_on_num (a, b) -> assert_equal 3 a
                                        ~msg:"Simple int value"
                                        ~printer:string_of_int;
                                    assert_equal  10 b
                                        ~msg:"Simple int value"
                                        ~printer:string_of_int

  | _ -> assert_equal false true

let test_read_key_val test_ctxt =
  let key_val = "mykey: myvalue" in
  let {key = k; value = v} = Mpd_utils.read_key_val key_val in
  assert_equal "mykey" k;
  assert_equal "myvalue" v

let song1 = "file: Bjork-Volta/11 Earth Intruders (Mark Stent Exten.m4a
Last-Modified: 2009-09-21T14:25:52Z
Artist: Björk
Album: Volta
Title: Earth Intruders (Mark Stent Extended Mix)
Track: 11/13
Genre: Alternative
Date: 2007
Composer: Björk
Disc: 1/1
AlbumArtist: Björk
Time: 266
duration: 266.472
Pos: 10
Id: 11"

let song2 = "file: Nile - What Should Not Be Unearthed (2015)/08 Ushabti Reanimator.mp3
Last-Modified: 2015-08-13T09:56:32Z
Artist: Nile
Title: Ushabti Reanimator
Album: What Should Not Be Unearthed
Track: 8
Date: 2015
Genre: Death Metal
Time: 91
duration: 90.958
Pos: 19
Id: 20"

let test_song_parse test_ctxt =
  let song = Mpd.Song.parse (Mpd_utils.split_lines song1) in
  assert_equal "Björk" (Mpd.Song.artist song);
  assert_equal "Volta" (Mpd.Song.album song);
  assert_equal "Earth Intruders (Mark Stent Extended Mix)" (Mpd.Song.title song);
  assert_equal "11/13" (Mpd.Song.track song);
  assert_equal "Alternative" (Mpd.Song.genre song);
  assert_equal "2007" (Mpd.Song.date song);
  assert_equal "Björk" (Mpd.Song.composer song);
  assert_equal "1/1" (Mpd.Song.disc song);
  assert_equal "Björk" (Mpd.Song.albumartist song);
  assert_equal "2009-09-21T14:25:52Z" (Mpd.Song.last_modified song);
  assert_equal 266 (Mpd.Song.time song);
  assert_equal 266.472 (Mpd.Song.duration song);
  assert_equal 11 (Mpd.Song.id song)

let mpd_responses_parsing_tests =
    "Mpd responses parsing tests" >:::
      ["test simple OK" >:: test_simple_ok;
     "test request OK" >:: test_request_ok;
     "test error 50" >:: test_error_50;
     "test error 1" >:: test_error_1;
     "test Mpd.utils.num_on_num_parse simple int" >:: test_num_on_num_parse_simple_int;
     "test Mpd.utils.num_on_num_parse num_on_num" >:: test_num_on_num_parse_num_on_num;
     "test Mpd.utils.read_key_value" >:: test_read_key_val;
     "test Mpd.Song.parse" >:: test_song_parse ]

  let () =
    run_test_tt_main mpd_responses_parsing_tests
