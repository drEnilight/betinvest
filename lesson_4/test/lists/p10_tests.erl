-module(p10_tests).

-include_lib("eunit/include/eunit.hrl").

encode_test_() ->
  [
    ?_assertEqual(p10:encode([a,a,a,b,b,b,a,a,a,c,d,d]), [{3,a}, {3,b}, {3,a}, {1,c}, {2,d}]),
    ?_assertEqual(p10:encode([a,b,c]), [{1,a}, {1,b}, {1,c}]),
    ?_assertEqual(p10:encode([a,a]), [{2,a}]),
    ?_assertEqual(p10:encode([]), []),
    ?_assertError(function_clause, p10:encode(atom))
  ].
