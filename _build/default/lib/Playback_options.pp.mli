Caml1999N022����            8lib/Playback_options.mli����  �      ������1ocaml.ppx.context��&_none_A@ �A����������)tool_name���.migrate_driver@@����,include_dirs����"[]@@����)load_path!����
%@%@����,open_modules*����.@.@����+for_package3����$None8@8@����%debug=����%falseB@B@����+use_threadsG����
K@K@����-use_vmthreadsP����T@T@����'cookiesY����"::^����������,library-name@i@����#Mpd@��.<command-line>A@@�A@E@@@r@�����\w@w@@w@w@@@w@@w@w�����*ocaml.text��}A@ ��~A@ �A�������	2 functions that configure all the playbackoptions @��8lib/Playback_options.mliS���S�.@@@��S���S�.@@��S���S�.@���Р'consume��U04�U0;@��@�����&Client!t��U0=�U0E@@��U0=� U0E@@��@����$bool��)U0I�*U0M@@��,U0I�-U0M@@�����(Protocol(response��6U0Q�7U0b@@��9U0Q�:U0b@@��<U0I�=U0b@@��?U0=�@U0b@@@���)ocaml.doc���A@ ���A@ �A�������	� Sets consume state to STATE, STATE should be false or true.
    When consume is activated, each song played is removed from playlist. @��QVcc�RW��@@@��TVcc�UW��@@@��WU00�XU0b@��ZU00�[U0b@���Р)crossfade��cY���dY��@��@�����&Client!t��oY� �pY�@@��rY� �sY�@@��@����#int��|Y��}Y�@@��Y���Y�@@�����(Protocol(response���Y���Y�$@@���Y���Y�$@@���Y���Y�$@@���Y� ��Y�$@@@���S�� A@ ��!A@ �A�������	! Sets crossfading between songs. @���Z%%��Z%K@@@���Z%%��Z%K@@@���Y����Y�$@���Y����Y�$@���Р)mixrampdb���\MQ��\MZ@��@�����&Client!t���\M\��\Md@@���\M\��\Md@@��@����#int���\Mh��\Mk@@���\Mh��\Mk@@�����(Protocol(response���\Mo��\M�@@���\Mo��\M�@@���\Mh��\M�@@���\M\��\M�@@@������rA@ ��sA@ �A�������
   Sets the threshold at which songs will be overlapped.
    Like crossfading but doesn't fade the track volume, just overlaps. The
    songs need to have MixRamp tags added by an external tool. 0dB is the
    normalized maximum volume so use negative values, I prefer -17dB.
    In the absence of mixramp tags crossfading will be used.
    See http://sourceforge.net/projects/mixramp @���]����b�@@@���]����b�@@@���\MM��\M�@���\MM��\M�@���A�    �*mixrampd_t��d�	d@@@��Р#Nan��d�d@�@@��d�d@@�Р'Seconds��d�d&@������%float��%d*�&d/@@��(d*�)d/@@@@��+d�,d/@������A@ ���A@ �A�������	O Type for the command mixrampdelay, it can be float number for seconds or nan. @��<e00�=e0�@@@��?e00�@e0�@@@@A@@��Bd�Cd/@@��Ed�Fd/@���Р,mixrampdelay��Ng���Og��@��@�����&Client!t��Zg���[g��@@��]g���^g��@@��@����*mixrampd_t��gg���hg��@@��jg���kg��@@�����(Protocol(response��tg���ug��@@��wg���xg��@@��zg���{g��@@��}g���~g��@@@���>��A@ ��A@ �A�������	� Additional time subtracted from the overlap calculated by mixrampdb. A
    value of "nan" disables MixRamp overlapping and falls back to crossfading. @���h����i`@@@���h����i`@@@���g����g��@���g����g��@���Р&random���kbf��kbl@��@�����&Client!t���kbn��kbv@@���kbn��kbv@@��@����$bool���kbz��kb~@@���kbz��kb~@@�����(Protocol(response���kb���kb�@@���kb���kb�@@���kbz��kb�@@���kbn��kb�@@@������]A@ ��^A@ �A�������	; Sets random state to STATE, STATE should be true or false @���l����l��@@@���l����l��@@@���kbb��kb�@���kbb��kb�@���Р&repeat���n����n��@��@�����&Client!t���n����n��@@��n���n��@@��@����$bool��n���n��@@��n���n��@@�����(Protocol(response��n���n�@@��n���n�@@��n���n�@@��!n���"n�@@@������A@ ���A@ �A�������	< Sets repeat state to STATE, STATE should be false or true. @��2o�3oI@@@��5o�6oI@@@��8n���9n�@��;n���<n�@���Р&setvol��DqKO�EqKU@��@�����&Client!t��PqKW�QqK_@@��SqKW�TqK_@@��@����#int��]qKc�^qKf@@��`qKc�aqKf@@�����(Protocol(response��jqKj�kqK{@@��mqKj�nqK{@@��pqKc�qqK{@@��sqKW�tqK{@@@���4��A@ ��A@ �A�������	3 Sets volume to VOL, the range of volume is 0-100. @���r||��r|�@@@���r||��r|�@@@���qKK��qK{@���qKK��qK{@���Р&single���t����t��@��@�����&Client!t���t����t��@@���t����t��@@��@����$bool���t����t��@@���t����t��@@�����(Protocol(response���t����t��@@���t����t��@@���t����t��@@���t����t��@@@������SA@ ��TA@ �A�������	� Sets single state to STATE, STATE should be 0 or 1. When single is
    activated, playback is stopped after current song, or song is repeated if
    the 'repeat' mode is enabled. @���u����w	}	�@@@���u����w	}	�@@@���t����t��@���t����t��@���A�    �+gain_mode_t���y	�	���y	�	�@@@��Р#Off���z	�	���z	�	�@�@@���z	�	���z	�	�@@�Р%Track���{	�	���{	�	�@�@@�� {	�	��{	�	�@@�Р%Album��|	�	��|	�	�@�@@��|	�	��|	�	�@@�Р$Auto��}	�	��}	�	�@�@@��}	�	��}	�	�@���װ��A@ ���A@ �A�������	2 gain_mode type for the command replay_gain_mode. @��'~	�	��(~	�
@@@��*~	�	��+~	�
@@@@A@@��-y	�	��.}	�	�@@��0y	�	��1}	�	�@���Р0replay_gain_mode��9 @

�: @

(@��@�����&Client!t��E @

*�F @

2@@��H @

*�I @

2@@��@����+gain_mode_t��R @

6�S @

A@@��U @

6�V @

A@@�����(Protocol(response��_ @

E�` @

V@@��b @

E�c @

V@@��e @

6�f @

V@@��h @

*�i @

V@@@���)���A@ ���A@ �A�������	� Sets the replay gain mode. One of off, track, album, auto.
    Changing the mode during playback may take several seconds, because the
    new settings does not affect the buffered data.
    This command triggers the options idle event. @��y A
W
W�z DJ@@@��| A
W
W�} DJ@@@�� @

�� @

V@��� @

�� @

V@@