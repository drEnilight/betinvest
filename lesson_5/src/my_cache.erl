-module(my_cache).
-export([create/1, insert/4, lookup/2, delete_obsolete/1]).

create(TableName) when is_atom(TableName) ->
  case is_exists(TableName) of
    true ->
      already_exists;
    false ->
      ets:new(TableName, [public, named_table]),
      ok
  end;
create(_TableName) ->
  error.

insert(TableName, Key, Value, TTL) when is_integer(TTL) ->
  case is_exists(TableName) of
    true ->
      ets:insert(TableName, {Key, Value, os:system_time(second) + TTL}),
      ok;
    false ->
      error
  end;
insert(_TableName, _Key, _Value, _TTL) ->
  error.

lookup(TableName, Key) ->
  case is_exists(TableName) of
    true ->
      table_lookup(TableName, Key);
    false ->
      error
  end.

delete_obsolete(TableName) ->
  case is_exists(TableName) of
    true ->
      delete_records(TableName),
      ok;
    false ->
      error
  end.

table_lookup(TableName, Key) ->
  case ets:member(TableName, Key) of
    true ->
      get_value(TableName, Key);
    false ->
      {error, nil}
  end.

get_value(TableName, Key) ->
  [{Key, Value, ExpirationTime}] = ets:lookup(TableName, Key),

  case os:system_time(second) =< ExpirationTime of
    true ->
      {ok, Value};
    false ->
      {ok, nil}
  end.

delete_records(TableName) ->
  MatchSpec = [{{'$1','$2', '$3'},[{'<','$3',os:system_time(second)}],[['$1']]}],
  delete_records(TableName, ets:select(TableName, MatchSpec)).
delete_records(TableName, []) ->
  ok;
delete_records(TableName, [[Key]|T]) ->
  ets:delete(TableName, Key),
  delete_records(TableName, T).

is_exists(TableName) ->
  lists:member(TableName, ets:all()).
