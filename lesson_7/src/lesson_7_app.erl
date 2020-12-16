-module(lesson_7_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
  Dispatch = cowboy_router:compile([
		{'_', [
			{"/api/cache_server", cache_server_handler, []}
		]}
	]),

	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}),

  lesson_7_sup:start_link().

stop(_State) ->
	ok = cowboy:stop_listener(http).
