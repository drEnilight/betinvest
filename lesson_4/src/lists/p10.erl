-module(p10).
-export([encode/1]).

encode(List) ->
  p05:reverse(encode(List, [])).

encode([], Acc) ->
  Acc;
encode([H|T], [{Count, H}|_]=Acc) ->
  [_|Tail] = Acc,
  encode(T, [{Count+1, H}|Tail]);
encode([H|T], Acc) ->
  encode(T, [{1, H}|Acc]).
