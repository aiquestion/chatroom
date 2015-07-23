-module(chatroom_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
  % init store
  ws_store:init(),
  Dispatch = cowboy_router:compile([
    {'_', [
      % http handler
      {"/http", http_handler, []},
      % websocket handler
      {"/websocket", ws_handler, []},
      %static files
      {"/res/[...]", cowboy_static, {priv_dir, chatroom, "", [{mimetypes, cow_mimetypes, all}]}}

    ]}
  ]),

  cowboy:start_http(my_http_listener, 100, [{port, 8081}],
    [{env, [{dispatch, Dispatch}]}]
  ),

  chatroom_sup:start_link().

stop(_State) ->
  ok.
