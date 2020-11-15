-module(p06_tests).

-include_lib("eunit/include/eunit.hrl").

is_palindrome_test_() ->
  [
    ?_assertEqual(p06:is_palindrome([4,6,7,6,4]), true),
    ?_assertEqual(p06:is_palindrome([1,2]), false),
    ?_assertEqual(p06:is_palindrome([]), true),
    ?_assertError(function_clause, p06:is_palindrome(1))
  ].
