-module(ws_store).
-author("panda").
-define(WSTABLE, ws_table_name).

%% API
-export([init/0,add/2, del/2, lookup/1]).

init() ->
  ets:new(?WSTABLE, [public, bag, named_table]).

add(Room, Ws) ->
  ets:insert(?WSTABLE, {Room, Ws}).

del(Room, Ws) ->
  ets:delete(?WSTABLE, {Room, Ws}).

lookup(Room) ->
  ets:lookup(?WSTABLE, Room).

