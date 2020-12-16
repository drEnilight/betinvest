-module(cache_server_handler).
-behavior(cowboy_handler).

-export([init/2]).

-define(TTL, 6000).

init(Req0, Opts) ->
	Method = cowboy_req:method(Req0),
	HasBody = cowboy_req:has_body(Req0),
	Req = match_query(Method, HasBody, Req0),
	{ok, Req, Opts}.

match_query(<<"POST">>, true, Req0) ->
	{ok, [{Body, _}], Req} = cowboy_req:read_urlencoded_body(Req0),
	process(jsone:decode(Body), Req);
match_query(<<"POST">>, false, Req) ->
	cowboy_req:reply(400, [], <<"Missing body.">>, Req);
match_query(_, _, Req) ->
	cowboy_req:reply(405, Req).

process(#{<<"action">> := <<"insert">>, <<"key">> := Key, <<"value">> := Value}, Req) ->
  cache_server:insert(Key, Value, ?TTL),
  response(jsone:encode(#{<<"result">> => <<"ok">>}), Req);
process(#{<<"action">> := <<"lookup">>, <<"key">> := Key}, Req) ->
  {ok, Value} = cache_server:lookup(Key),
  response(jsone:encode(#{<<"result">> => Value}), Req);
process(#{<<"action">> := <<"lookup_by_date">>, <<"date_from">> := DateFrom, <<"date_to">> := DateTo}, Req) ->
  DateFromTimestamp = ec_date:parse(binary:bin_to_list(DateFrom)),
  DateToTimestamp = ec_date:parse(binary:bin_to_list(DateTo)),
  {ok, Value} = cache_server:lookup_by_date(DateFromTimestamp, DateToTimestamp),
  response(jsone:encode(#{<<"result">> => Value}), Req).

response(Body, Req) ->
	cowboy_req:reply(200, #{
		<<"content-type">> => <<"application/json">>
	}, Body, Req).
