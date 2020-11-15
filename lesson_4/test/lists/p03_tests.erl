-module(p03_tests).

-include_lib("eunit/include/eunit.hrl").

element_at_test_() ->
  [
    ?_assertEqual(p03:element_at([4,6,7], 2), 6),
    ?_assertEqual(p03:element_at([], 5), undefined),
    ?_assertError(function_clause, p03:element_at(<<>>, 2))
  ].
