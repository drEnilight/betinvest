-module(cache_helper).

-export([create/1]).
-export([insert/4]).
-export([lookup/2]).
-export([lookup/3]).
-export([delete_obsolete/1]).

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
      lookup_by_key(TableName, Key);
    false ->
      error
  end.

lookup(TableName, DateFrom, DateTo) ->
  case is_exists(TableName) of
    true ->
      lookup_by_date(TableName, DateFrom, DateTo);
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

lookup_by_key(TableName, Key) ->
  case ets:member(TableName, Key) of
    true ->
      get_value(TableName, Key);
    false ->
      {error, nil}
  end.

lookup_by_date(TableName, DateFrom, DateTo) ->
  MatchSpec = [{{'$1','$2','$3'},[{'>','$3',universal_time_to_system(DateFrom)}, {'<','$3',universal_time_to_system(DateTo)}],[['$2']]}],
  lists:flatten(ets:select(TableName, MatchSpec)).

get_value(TableName, Key) ->
  [{Key, Value, ExpirationTime}] = ets:lookup(TableName, Key),

  case os:system_time(second) =< ExpirationTime of
    true ->
      {ok, Value};
    false ->
      {ok, nil}
  end.

delete_records(TableName) ->
  MatchSpec = [{{'$1','$2','$3'},[{'<','$3',os:system_time(second)}],[['$1']]}],
  delete_records(TableName, ets:select(TableName, MatchSpec)).
delete_records(_TableName, []) ->
  ok;
delete_records(TableName, [[Key]|T]) ->
  ets:delete(TableName, Key),
  delete_records(TableName, T).

is_exists(TableName) ->
  lists:member(TableName, ets:all()).

universal_time_to_system(Time) ->
  calendar:datetime_to_gregorian_seconds(Time) - 719528 * 24 * 3600.
