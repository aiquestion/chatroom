-module(chatroom_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	Procs = [{room, {room, start_link, []}, permanent, 2000, worker, [room]}],
	{ok, {{one_for_one, 0, 1}, Procs}}.
