-module(bs03_tests).

-include_lib("eunit/include/eunit.hrl").

split_test_() ->
  [
    ?_assertEqual(bs03:split(<<"Col1-:-Col2-:-Col3-:-Col4">>, "-:-"), [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>]),
    ?_assertEqual(bs03:split(<<"Wake up Neo">>, " "), [<<"Wake">>, <<"up">>, <<"Neo">>]),
    ?_assertEqual(bs03:split(<<"string">>, " "), [<<"string">>]),
    ?_assertEqual(bs03:split(<<"">>, ""), [<<"">>]),
    ?_assertError(undef, bs03:split([]))
  ].
