-module(cache_server).
-behaviour(gen_server).

%% API.
-export([start_link/2]).
-export([new/1]).
-export([stop/0]).
-export([insert/4]).
-export([lookup/2]).
-export([lookup_by_date/3]).

%% Callbacks.
-export([init/1]).
-export([handle_info/2]).
-export([handle_cast/2]).
-export([handle_call/3]).
-export([terminate/2]).

% API

start_link(TableName, [{drop_interval, Interval}]) ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [TableName, Interval], []).

stop() ->
	gen_server:call(?MODULE, stop).

new(TableName) ->
  gen_server:cast(?MODULE, {new, TableName}).

insert(TableName, Key, Value, TTL) ->
  gen_server:cast(?MODULE, {insert, TableName, Key, Value, TTL}).

lookup(TableName, Key) ->
  gen_server:call(?MODULE, {lookup, TableName, Key}).

lookup_by_date(TableName, DateFrom, DateTo) ->
  gen_server:call(?MODULE, {lookup_by_date, TableName, DateFrom, DateTo}).

% Callbacks

init([TableName, Interval]) ->
  erlang:send_after(Interval, self(), {delete_obsolete, {TableName, Interval}}),
  {ok, self()}.

handle_info({delete_obsolete, {TableName, Interval}}, State) ->
  cache_helper:delete_obsolete(TableName),
  erlang:send_after(Interval, self(), {delete_obsolete, {TableName, Interval}}),
  {noreply, State};
handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

handle_cast({new, TableName}, State) ->
  cache_helper:create(TableName),
  {noreply, State};
handle_cast({insert, TableName, Key, Value, TTL}, State) ->
  cache_helper:insert(TableName, Key, Value, TTL),
  {noreply, State}.

handle_call({lookup, TableName, Key}, _From, State) ->
  Result = cache_helper:lookup(TableName, Key),
  {reply, Result, State};
handle_call({lookup_by_date, TableName, DateFrom, DateTo}, _From, State) ->
  Values = cache_helper:lookup(TableName, DateFrom, DateTo),
  {reply, {ok, Values}, State};
handle_call(stop, _From, State) ->
	{stop, normal, stopped, State};
handle_call(_Request, _From, State) ->
	{reply, ignored, State}.
