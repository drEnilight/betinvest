-module(bs02).
-export([words/1]).

words(String) ->
  lists:reverse(words(String, [<<>>])).

words(<<>>, Acc) ->
  Acc;
words(<<" ", X/utf8, Rest/binary>>, Acc) ->
  words(Rest, [<<X/utf8>>|Acc]);
words(<<X/utf8, Rest/binary>>, [Word|Tail]) ->
  words(Rest, [<<Word/binary, X/utf8>>|Tail]).
