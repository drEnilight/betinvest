-module(cache_server_SUITE).

-include_lib("common_test/include/ct.hrl").

-compile(export_all).

all() ->
  [
    insert_into,
    lookup_by_key,
    lookup_by_date
  ].

init_per_suite(Config) ->
  [{table_name, cache_server}| Config].

end_per_suite(_Config) ->
  ok.

init_per_testcase(Case, Config) ->
  TableName = ?config(table_name, Config),
  cache_server:start_link(TableName, [{drop_interval, 600000}]),
  Config.

insert_into(Config) ->
  TableName = ?config(table_name, Config),
  ok = cache_server:insert(key, value, 600).

lookup_by_key(Config) ->
  TableName = ?config(table_name, Config),
  cache_server:insert(age, 40, 600),
  {ok, 40} = cache_server:lookup(age).

lookup_by_date(Config) ->
  TableName = ?config(table_name, Config),
  cache_server:insert(age, 40, 600),
  {ok, [40]} = cache_server:lookup_by_date({{2015,1,1},{00,00,00}}, {{2020,12,31},{00,00,00}}).
