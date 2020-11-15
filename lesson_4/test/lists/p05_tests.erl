-module(p05_tests).

-include_lib("eunit/include/eunit.hrl").

reverse_test_() ->
  [
    ?_assertEqual(p05:reverse([4,6,7]), [7,6,4]),
    ?_assertEqual(p05:reverse([]), []),
    ?_assertError(function_clause, p05:reverse(123))
  ].
