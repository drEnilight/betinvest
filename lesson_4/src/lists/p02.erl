-module(p02).
-export([but_last/1]).

but_last([]) ->
  [];
but_last([_] = L) ->
  L;
but_last([_, _] = L) ->
  L;
but_last([_|T]) ->
  but_last(T).
