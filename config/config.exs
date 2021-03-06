# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

config :taihou, token: "kOIDQ35D18n9STwY2WJVNJY0"
config :taihou, imgur_client_id: "adc7e7b1c8d38f9"
config :taihou, imgur_client_secret: "afccde3664c18e98797b850e91c3a1d81a84c5d3"
config :taihou, imgur_api: "https://api.imgur.com/3/album/"

# You can configure your application as:
#
#     config :taihou, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:taihou, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"

import_config "#{Mix.env()}.exs"
