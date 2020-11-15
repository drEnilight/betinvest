-module(p07_tests).

-include_lib("eunit/include/eunit.hrl").

flatten_test_() ->
  [
    ?_assertEqual(p07:flatten([a,[],[b,[c,d],e]]), [a,b,c,d,e]),
    ?_assertEqual(p07:flatten([[1,2], [[[[[], [a]]]]]]), [1,2,a]),
    ?_assertEqual(p07:flatten([]), []),
    ?_assertError(function_clause, p07:flatten(atom))
  ].
