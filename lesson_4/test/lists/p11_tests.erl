-module(p11_tests).

-include_lib("eunit/include/eunit.hrl").

encode_modified_test_() ->
  [
    ?_assertEqual(p11:encode_modified([a,a,a,b,b,b,a,a,a,c,d,d]), [{3,a}, {3,b}, {3,a}, c, {2,d}]),
    ?_assertEqual(p11:encode_modified([a,b,c]), [a,b,c]),
    ?_assertEqual(p11:encode_modified([a,a]), [{2,a}]),
    ?_assertEqual(p11:encode_modified([]), []),
    ?_assertError(function_clause, p11:encode_modified(atom))
  ].
