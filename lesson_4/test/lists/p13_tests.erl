-module(p13_tests).

-include_lib("eunit/include/eunit.hrl").

decode_test_() ->
  [
    ?_assertEqual(p13:decode([{3,a}, {3,b}, {3,a}, {1,c}, {2,d}]), [a,a,a,b,b,b,a,a,a,c,d,d]),
    ?_assertEqual(p13:decode([{1,a}, {1,b}, {1,c}]), [a,b,c]),
    ?_assertEqual(p13:decode([{2,a}]), [a,a]),
    ?_assertEqual(p13:decode([]), []),
    ?_assertError(function_clause, p13:decode(atom))
  ].
