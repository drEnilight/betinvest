-module(p08).
-export([compress/1]).

compress(List) ->
  p05:reverse(compress(List, [])).

compress([], Acc) ->
  Acc;
compress([H|T], [H|_]=Acc) ->
  compress(T, Acc);
compress([H|T], Acc) ->
  compress(T, [H|Acc]).
