lf_discord_config:
  type: data
  group: Lost Forever: Codename Kingdoms
  invite: https://discord.gg/vCYuCrYXMW
  roles:
    unlinked: Unlinked
  channels:
  - relay
  - events

lf_discord_config_add_role:
  type: task
  debug: false
  definitions: path|group|name
  script:
  - if <[name]> not in <[group].roles.parse[name]>:
    - debug error "Role '<[name]>' not found in group '<[group].name>'"
    - stop
  - flag server discord.roles.<[path]>:<[group].role[<[name]>]>

lf_discord_config_reload:
  type: world
  debug: false
  events:
    after server start:
    - ~discordconnect id:bot token:<secret[bot_token]>
    - run lf_discord_config_reload.reload_config
    - run lf_discord_send "def:relay|<&gt> ***Server starting...***"
    after reload scripts:
    - run lf_discord_config_reload.reload_config
  reload_config:
  - debug log "Reloading Discord config..."

  - define config <script[lf_discord_config]>
  - define bot <discord[bot]>
  - define group_name <[config].parsed_key[group]>

  - if <[group_name]> not in <[bot].groups.parse[name]>:
    - debug error "Group '<[group_name]>' not found"
    - stop

  - define group <[bot].group[<[group_name]>]>

  - flag server discord.group:<[group]>
  - flag server discord.invite:<[config].parsed_key[invite]>

  - foreach <[config].data_key[roles]> key:role as:name:
    - run lf_discord_config_add_role def:<[role]>|<[group]>|<[name]>
  - foreach <script[rank_config].data_key[ranks]> key:name as:rank:
    - run lf_discord_config_add_role def:ranks.<[name]>|<[group]>|<[rank].get[name]>

  - flag server discord.link.role:<[group].role[]>

  - foreach <[config].data_key[channels]> as:channel:
    - if <[channel]> not in <[group].channels.parse[name]>:
      - debug error "Channel '<[channel]>' not found in group '<[group].name>'"
      - foreach next
    - flag server discord.channels.<[channel]>:<[group].channel[<[channel]>]>