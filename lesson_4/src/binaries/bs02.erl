-module(bs02).
-export([words/1]).

words(String) ->
  lists:reverse(words(String, <<>>, [])).

words(<<>>, <<>>, Acc) ->
  Acc;
words(<<>>, Word, Acc) ->
  [Word|Acc];
words(<<" ", Rest/binary>>, <<>>, Acc) ->
  words(Rest, <<>>, Acc);
words(<<" ", Rest/binary>>, Word, Acc) ->
  words(Rest, <<>>, [Word|Acc]);
words(<<X/utf8, Rest/binary>>, Word, Acc) ->
  words(Rest, <<Word/binary, X/utf8>>, Acc).
