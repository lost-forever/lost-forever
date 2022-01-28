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
  script:
  # Placeholder for when kingdoms are implemented
  - define kingdom <dark_gray>[<gray>Kingdom<dark_gray>]
  - define rank <player.flag[rank].proc[rank_get]>
  - define color <[rank].get[color].parsed>
  # Display rank info when hovering over the player's name - color is distinguishable by itself
  - define name <[color]><player.name.on_hover[<[color]><[rank].get[name]>]>
  - determine "<[kingdom]> <[name]><gray>:"

lf_chat_handler:
  type: world
  events:
    on player chats:
    - determine passively cancelled
    # Hover text doesn't work when determing chat - need to cancel and narrate manually
    - define channel <script[lf_chat_config].data_key[channels].get[<player.flag[lf.chat.channel]>]>
    - narrate "<proc[lf_chat_prefix]> <[channel].get[color].parsed><context.message>" targets:<[channel].get[targets].parsed>
    after player joins flagged:!lf.chat.channel:
    - flag <player> lf.chat.channel:global

lf_chat:
  type: command
  name: chat
  description: Changes the chat channel
  usage: /chat <&lt>channel<&gt>
  tab completions:
    1: global|kingdom|near
  script:
  - if <context.args.is_empty>:
    - narrate "<yellow>/chat global <gray>to target all players."
    - narrate "<yellow>/chat kingdom <gray>to target the players in your kingdom."
    - narrate "<yellow>/chat near <gray>to target players in a 50-block radius."
    - stop

  - if <context.args.first> not in <script[lf_chat_config].data_key[channels].keys>:
    - narrate "<red>That channel doesn't exist!"
    - stop

  - flag <player> lf.chat.channel:<context.args.first>
  - narrate "<green>Now chatting in <yellow><context.args.first.to_lowercase><green>."