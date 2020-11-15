-module(p09_tests).

-include_lib("eunit/include/eunit.hrl").

pack_test_() ->
  [
    ?_assertEqual(p09:pack([a,a,a,b,b,b,a,a,a,c,d,d]), [[a,a,a],[b,b,b],[a,a,a],[c],[d,d]]),
    ?_assertEqual(p09:pack([a,b,c]), [[a],[b],[c]]),
    ?_assertEqual(p09:pack([]), []),
    ?_assertError(function_clause, p09:pack(atom))
  ].
