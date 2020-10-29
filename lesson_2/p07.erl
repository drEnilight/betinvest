-module(p07).
-export([flatten/1]).

flatten(List) ->
  p05:reverse(flatten(List, [])).

flatten([], Acc) ->
  Acc;
flatten([[]|T], Acc) ->
  flatten(T, Acc);
flatten([[_|_]=H|T], Acc) ->
  flatten(T, flatten(H, Acc));
flatten([H|T], Acc) ->
  flatten(T, [H|Acc]).
