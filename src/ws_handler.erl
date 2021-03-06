-module(ws_handler).
-behaviour(cowboy_websocket_handler).

-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

init({tcp, http}, _Req, _Opts) ->
	{upgrade, protocol, cowboy_websocket}.

websocket_init(_TransportName, Req, _Opts) ->
	ws_store:add(<<"room1">>, self()),
	{ok, Req, undefined_state}.

websocket_handle({text, Msg}, Req, State) ->
  gen_server:cast(room, {msg, Msg}),
	{ok, Req, State};
websocket_handle(_Data, Req, State) ->
	{ok, Req, State}.

websocket_info({msg, Text}, Req, State) ->
	{reply,{text, Text}, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
	ws_store:del(<<"room1">>, self()),
	ok.
