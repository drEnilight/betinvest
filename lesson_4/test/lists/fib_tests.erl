-module(fib_tests).

-include_lib("eunit/include/eunit.hrl").

result_test_() ->
  [
    ?_assertEqual(fib:result(10), 55),
    ?_assertEqual(fib:result(20), 6765),
    ?_assertError(badarg, fib:result([]))
  ].
