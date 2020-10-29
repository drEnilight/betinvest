-module(p14).
-export([duplicate/1]).

duplicate(List) ->
  p05:reverse(duplicate(List, [])).

duplicate([], Acc) ->
  Acc;
duplicate([H|T], Acc) ->
  duplicate(T, [H, H|Acc]).
