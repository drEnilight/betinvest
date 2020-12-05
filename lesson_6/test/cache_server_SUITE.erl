-module(cache_server_SUITE).

-include_lib("common_test/include/ct.hrl").

-compile(export_all).

all() ->
  [
    new_table,
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
  cache_server:new(cache_server),
  Config.

new_table(Config) ->
  ok = cache_server:new(new_table).

insert_into(Config) ->
  TableName = ?config(table_name, Config),
  cache_server:new(new_table),
  ok = cache_server:insert(TableName, key, value, 600).

lookup_by_key(Config) ->
  TableName = ?config(table_name, Config),
  cache_server:insert(TableName, age, 40, 600),
  {ok, 40} = cache_server:lookup(TableName, age).

lookup_by_date(Config) ->
  TableName = ?config(table_name, Config),
  cache_server:insert(TableName, age, 40, 600),
  {ok, [40]} = cache_server:lookup_by_date(TableName, {{2015,1,1},{00,00,00}}, {{2020,12,31},{00,00,00}}).
