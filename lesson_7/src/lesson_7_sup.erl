-module(lesson_7_sup).
-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
    SupFlags = #{
        strategy => one_for_one,
        intensity => 10,
        period => 10},

    ChildSpecs =
        [#{id => cache_server,
           start => {cache_server, start_link, [cache_table, [{drop_interval, 600}]]},
           restart => permanent,
           shutdown => 2000,
           type => worker,
           modules => [cache_server]}],
    {ok, {SupFlags, ChildSpecs}}.
