lf_chat_channel:
  type: command
  name: channel
  description: Switches your current channel
  usage: /channel <&lt>name<&gt>
  aliases:
  - c
  - chat
  permission: chat.channel
  tab completions:
    1: <script[lf_chat_config].data_key[channels].keys>
  script:
  - if <context.args.is_empty>:
    - narrate "<yellow>/channel global <gray>to target all players."
    - narrate "<yellow>/channel kingdom <gray>to target the players in your kingdom."
    - narrate "<yellow>/channel near <gray>to target players in a 50-block radius."
    - stop

  - if <context.args.first> not in <script[lf_chat_config].data_key[channels].keys>:
    - narrate "<red>That channel doesn't exist!"
    - stop

  - flag <player> chat.channel:<context.args.first>
  - narrate "<green>Now chatting in <yellow><context.args.first.to_lowercase><green>."