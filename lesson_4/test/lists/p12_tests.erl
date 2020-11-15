-module(p12_tests).

-include_lib("eunit/include/eunit.hrl").

decode_modified_test_() ->
  [
    ?_assertEqual(p12:decode_modified([{3,a}, {3,b}, {3,a}, c, {2,d}]), [a,a,a,b,b,b,a,a,a,c,d,d]),
    ?_assertEqual(p12:decode_modified([a,b,c]), [a,b,c]),
    ?_assertEqual(p12:decode_modified([{2,a}]), [a,a]),
    ?_assertEqual(p12:decode_modified([]), []),
    ?_assertError(function_clause, p12:decode_modified(atom))
  ].
