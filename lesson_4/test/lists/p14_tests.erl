-module(p14_tests).

-include_lib("eunit/include/eunit.hrl").

duplicate_test_() ->
  [
    ?_assertEqual(p14:duplicate([a,b,c,c,d]), [a,a,b,b,c,c,c,c,d,d]),
    ?_assertEqual(p14:duplicate([1]), [1,1]),
    ?_assertEqual(p14:duplicate([]), []),
    ?_assertError(function_clause, p14:duplicate(atom))
  ].
