-module(p02_tests).

-include_lib("eunit/include/eunit.hrl").

but_last_test_() ->
  [
    ?_assertEqual(p02:but_last([1,2,3]), [2,3]),
    ?_assertEqual(p02:but_last(["A", "B", "C"]), ["B", "C"]),
    ?_assertEqual(p02:but_last([1]), [1]),
    ?_assertEqual(p02:but_last([]), []),
    ?_assertError(function_clause, p02:but_last(true))
  ].
