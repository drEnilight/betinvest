-module(bs03).
-export([split/2]).

split(String, Trait) ->
  lists:reverse(split(String, list_to_binary(Trait), byte_size(list_to_binary(Trait)), [<<>>])).

split(<<>>, _, _, Acc) ->
  Acc;
split(String, Trait, Size, [Word|Tail] = Acc) ->
  case String of
    <<Trait:Size/binary, X/utf8, Rest/binary>> -> split(Rest, Trait, Size, [<<X/utf8>>|Acc]);
    <<X/utf8, Rest/binary>> -> split(Rest, Trait, Size, [<<Word/binary, X/utf8>>|Tail])
  end.
