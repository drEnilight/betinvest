-module(p09).
-export([pack/1]).

pack(List) ->
  p05:reverse(pack(List, [])).

pack([], Acc) ->
  Acc;
pack([H|T], [[H|_]|_]=Acc) ->
  [Head|Tail] = Acc,
  pack(T, [[H|Head]|Tail]);
pack([H|T], Acc) ->
  pack(T, [[H]|Acc]).
