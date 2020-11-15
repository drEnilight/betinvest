-module(fib).

-define(FI, (1 + math:sqrt(5)) / 2).

-export([result/1]).

result(N) ->
  binet_formula(N).

binet_formula(N) when N >= 0 ->
  round(math:pow(?FI, N) / math:sqrt(5));
binet_formula(N) ->
  undefined.
