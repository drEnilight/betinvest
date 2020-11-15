-module(p08_tests).

-include_lib("eunit/include/eunit.hrl").

compress_test_() ->
  [
    ?_assertEqual(p08:compress([a,a,a,b,b,b,a,a,a,c,d,d,d]), [a,b,a,c,d]),
    ?_assertEqual(p08:compress([a,b,c]), [a,b,c]),
    ?_assertEqual(p08:compress([]), []),
    ?_assertError(function_clause, p08:compress(atom))
  ].
