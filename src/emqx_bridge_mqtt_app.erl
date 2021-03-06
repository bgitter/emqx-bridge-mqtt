%%--------------------------------------------------------------------
%% Copyright (c) 2020 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_bridge_mqtt_app).

-emqx_plugin(bridge).

-behaviour(application).

-include_lib("emqx/include/logger.hrl").

-export([start/2, stop/1]).

-logger_header("[Bridge]").

start(_StartType, _StartArgs) ->
  ?LOG(warning, "emqx_bridge_mqtt_app start..."),
  emqx_ctl:register_command(bridges, {emqx_bridge_mqtt_cli, cli}, []),
  ?LOG(warning, "emqx_bridge_mqtt_app emqx_ctl=>register_command success..."),
  emqx_bridge_worker:register_metrics(),
  ?LOG(warning, "emqx_bridge_mqtt_app emqx_bridge_worker=>register_metrics success..."),
  emqx_bridge_mqtt_sup:start_link().

stop(_State) ->
  ?LOG(warning, "emqx_bridge_mqtt_app stop..."),
  emqx_ctl:unregister_command(bridges),
  ok.

