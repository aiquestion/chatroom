-module(chatroom_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
  Dispatch = cowboy_router:compile([
    {'_', [{"/", http_handler, []}]}
  ]),
  cowboy:start_http(my_http_listener, 100, [{port, 8081}],
    [{env, [{dispatch, Dispatch}]}]
  ),
  chatroom_sup:start_link().

stop(_State) ->
  ok.
