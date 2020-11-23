-module(benchee).
-export([run/0]).
-export([map_insert/1, proplist_insert/1, dict_insert/1, process_dict_insert/0, record_insert/0, ets_insert/0]).
-export([map_update/1, proplist_update/1, dict_update/1, process_dict_update/0, record_update/1, ets_update/0]).
-export([map_read_by_matching/1]).
-export([times/1]).

-define(COUNT, 100000).

-record(person, {name="Jerry", age="17", gender="m"}).

run() ->
  {Map, Proplist, Dict, Record} = prepare(),
  create(Map, Proplist, Dict),
  update(Map, Proplist, Dict, Record),
  read_by_matching(Map, Proplist, Dict, Record),
  read_by_function(Map, Proplist, Dict, Record).

prepare() ->
  Map = prepare_map(),
  Proplist = prepare_proplist(),
  Dict = prepare_dict(),
  Record = prepare_record(),
  prepare_ets(),
  prepare_process_dict(),
  {Map, Proplist, Dict, Record}.

create(Map, Proplist, Dict) ->
  {MapTime, _} = timer:tc(?MODULE, times, [map_insert(Map)]),
  {ProplistTime, _} = timer:tc(?MODULE, times, [proplist_insert(Proplist)]),
  {DictTime, _} = timer:tc(?MODULE, times, [dict_insert(Dict)]),
  {ProcessDictTime, _} = timer:tc(?MODULE, times, [process_dict_insert()]),
  {RecordTime, _} = timer:tc(?MODULE, times, [record_insert()]),
  {EtsTime, _} = timer:tc(?MODULE, times, [ets_insert()]),
  write_result([{map_insert, avg_time(MapTime)},
                {proplist_insert, avg_time(ProplistTime)},
                {dict_insert, avg_time(DictTime)},
                {process_dict_insert, avg_time(ProcessDictTime)},
                {record_insert, avg_time(RecordTime)},
                {ets_insert, avg_time(EtsTime)}]).

update(Map, Proplist, Dict, Record) ->
  {MapTime, _} = timer:tc(?MODULE, times, [map_update(Map)]),
  {ProplistTime, _} = timer:tc(?MODULE, times, [proplist_update(Proplist)]),
  {DictTime, _} = timer:tc(?MODULE, times, [dict_update(Dict)]),
  {ProcessDictTime, _} = timer:tc(?MODULE, times, [process_dict_update()]),
  {RecordTime, _} = timer:tc(?MODULE, times, [record_update(Record)]),
  {EtsTime, _} = timer:tc(?MODULE, times, [ets_update()]),
  write_result([{map_update, avg_time(MapTime)},
                {proplist_update, avg_time(ProplistTime)},
                {dict_update, avg_time(DictTime)},
                {process_dict_update, avg_time(ProcessDictTime)},
                {record_update, avg_time(RecordTime)},
                {ets_update, avg_time(EtsTime)}]).

read_by_matching(Map, Proplist, _Dict, Record) ->
  {MapTime, _} = timer:tc(?MODULE, times, [map_read_by_matching(Map)]),
  {ProplistTime, _} = timer:tc(?MODULE, times, [proplist_read_by_matching(Proplist)]),
  {RecordTime, _} = timer:tc(?MODULE, times, [record_read_by_matching(Record)]),
  write_result([{map_read_by_matching, avg_time(MapTime)},
                {proplist_read_by_matching, avg_time(ProplistTime)},
                {record_read_by_matching, avg_time(RecordTime)}]).

read_by_function(Map, Proplist, Dict, Record) ->
  {MapTime, _} = timer:tc(?MODULE, times, [map_read_by_function(Map)]),
  {ProplistTime, _} = timer:tc(?MODULE, times, [proplist_read_by_function(Proplist)]),
  {DictTime, _} = timer:tc(?MODULE, times, [dict_read_by_function(Dict)]),
  {ProcessDictTime, _} = timer:tc(?MODULE, times, [process_dict_read_by_function()]),
  {RecordTime, _} = timer:tc(?MODULE, times, [record_read_by_function(Record)]),
  {EtsTime, _} = timer:tc(?MODULE, times, [ets_read_by_function()]),
  write_result([{map_read_by_function, avg_time(MapTime)},
                {proplist_read_by_function, avg_time(ProplistTime)},
                {dict_read_by_function, avg_time(DictTime)},
                {process_dict_read_by_function, avg_time(ProcessDictTime)},
                {record_read_by_function, avg_time(RecordTime)},
                {ets_read_by_function, avg_time(EtsTime)}]).

map_insert(Map) ->
  maps:put(key, value, Map).
map_update(Map) ->
  Map#{name => "Vlad"}.
map_read_by_matching(Map) ->
  #{name := _Name} = Map.
map_read_by_function(Map) ->
  maps:get(name, Map).

proplist_insert(Proplist) ->
  [{key, value}|Proplist].
proplist_update(Proplist) ->
  {value, {age, _}, Options} = lists:keytake(age, 1, Proplist),
  [{age, 22}|Options].
proplist_read_by_matching(Proplist) ->
  [_, {age, _Age}, _] = Proplist.
proplist_read_by_function(Proplist) ->
  {value, {age, _Age}, _} = lists:keytake(age, 1, Proplist).

dict_insert(Dict) ->
  dict:append(key, value, Dict).
dict_update(Dict) ->
  dict:store(key, new_value, Dict).
dict_read_by_function(Dict) ->
  dict:fetch(name, Dict).

process_dict_insert() ->
  put(key, value).
process_dict_update() ->
  put(key, new_value).
process_dict_read_by_function() ->
  get(key).

record_insert() ->
  #person{}.
record_update(Record) ->
  Record#person{name = "Vlad"}.
record_read_by_matching(Record) ->
  #person{name=_Name} = Record.
record_read_by_function(Record) ->
  Record#person.name.

ets_insert() ->
  ets:insert(?MODULE, {key, value}).
ets_update() ->
  ets:insert(?MODULE, {key, new_value}).
ets_read_by_function() ->
  ets:lookup(?MODULE, key).

prepare_map() ->
  #{name => "Jerry", age => 17, gender => "m"}.
prepare_proplist() ->
  [{name, "Jerry"}, {age, 17}, {gender, "m"}].
prepare_dict() ->
  Dict = dict:new(),
  Dict2 = dict:append(name, "Jerry", Dict),
  Dict3 = dict:append(age, 17, Dict2),
  dict:append(gender, "m", Dict3).
prepare_process_dict() ->
  put(name, "Jerry"),
  put(age, 17),
  put(gender, "m").
prepare_ets() ->
  ets:new(?MODULE, [public, named_table]),
  ets:insert(?MODULE, [{name, "Jerry"}, {age, 17}, {gender, "m"}]).
prepare_record() ->
  #person{}.

write_result([]) ->
  io:fwrite("----------------------------~n");
write_result([{FunctionName, Time}|T]) ->
  io:fwrite("|~-30s|~10s|~n", [io_lib:write(FunctionName), io_lib:write(Time)]),
  write_result(T).

times(F) ->
  times(F, ?COUNT).

times(F, 0) ->
  F;
times(F, N) ->
  times(F, N-1).

avg_time(Time) ->
  Time / ?COUNT.
