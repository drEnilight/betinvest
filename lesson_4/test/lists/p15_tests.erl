-module(p15_tests).

-include_lib("eunit/include/eunit.hrl").

replicate_test_() ->
  [
    ?_assertEqual(p15:replicate([a,b,c], 3), [a,a,a,b,b,b,c,c,c]),
    ?_assertEqual(p15:replicate([1], 4), [1,1,1,1]),
    ?_assertEqual(p15:replicate([], 2), []),
    ?_assertError(function_clause, p15:replicate(atom, 2))
  ].
