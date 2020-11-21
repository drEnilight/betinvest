-module(bs02_tests).

-include_lib("eunit/include/eunit.hrl").

words_test_() ->
  [
    ?_assertEqual(bs02:words(<<"Hello world">>), [<<"Hello">>, <<"world">>]),
    ?_assertEqual(bs02:words(<<"   Hello    world    ">>), [<<"Hello">>, <<"world">>]),
    ?_assertEqual(bs02:words(<<"welcome">>), [<<"welcome">>]),
    ?_assertEqual(bs02:words(<<"">>), []),
    ?_assertError(function_clause, bs02:words([]))
  ].
