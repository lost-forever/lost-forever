lf_chat_config:
  type: data
  channels:
    global:
      targets: <server.online_players>
      color: <white>
    kingdom:
      targets: <server.online_players>
      color: <aqua>
    near:
      targets: <player.location.find_players_within[50]>
      color: <light_purple>

lf_chat_prefix:
  type: procedure
  debug: false
  script:
  # Placeholder for when kingdoms are implemented
  - define kingdom <dark_gray>[<gray>Kingdom<dark_gray>]
  - define rank <player.flag[rank].proc[rank_get]>
  - define color <[rank].get[color].parsed>
  # Display rank info when hovering over the player's name - color is distinguishable by itself
  - define name <[color]><player.name.on_hover[<[color]><[rank].get[name]>]>
  - determine "<[kingdom]> <[name]><gray>:"

lf_chat:
  type: world
  debug: false
  events:
    after player joins flagged:!chat.channel:
    - flag <player> chat.channel:global
    on player chats:
    - determine passively cancelled
    # Stop message relay if player is muted
    - if <player.has_flag[chat.muted]>:
      - narrate "<red>You are muted!"
      - stop
    # Hover text doesn't work when determing chat - need to cancel and narrate manually
    - define channel <script[lf_chat_config].data_key[channels].get[<player.flag[chat.channel]>]>
    # Targets are the channel's players excluding the ones that the player is ignored by
    - define targets <[channel].get[targets].parsed.exclude[<player.flag[chat.ignore].if_null[<list>]>]>
    - narrate "<proc[lf_chat_prefix]> <[channel].get[color].parsed><context.message>" targets:<[targets]>