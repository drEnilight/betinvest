-module(p04_tests).

-include_lib("eunit/include/eunit.hrl").

len_test_() ->
  [
    ?_assertEqual(p04:len([4,6,7]), 3),
    ?_assertEqual(p04:len([]), 0),
    ?_assertError(function_clause, p04:len(123))
  ].
