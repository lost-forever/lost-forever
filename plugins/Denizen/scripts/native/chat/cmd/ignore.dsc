lf_chat_ignore:
  type: command
  name: ignore
  description: Ignores a player's messages
  usage: /ignore <&lt>player<&gt>
  required: 1
  permission: chat.ignore
  tab completions:
    1: <server.players_flagged[chat.ignore].exclude[<player>].filter_tag[<[filter_value].flag[chat.ignore].contains[<player>].not>].parse[name]>
  script:
  - inject cmd_args

  - define user <context.args.first>
  - inject cmd_player

  - if <[user]> == <player>:
    - define reason "You can't ignore yourself!"
  - else if <[user].has_flag[chat.ignore]> and <player> not in <[user].flag[chat.ignore]>:
    - define reason "You're already ignoring this player!"

  - inject cmd_err

  - if !<[user].has_flag[chat.ignore]>:
    - flag <[user]> chat.ignore:<list>

  - flag <[user]> chat.ignore:->:<player>
  - narrate "<green>Now ignoring <yellow><[user].name><green>."

lf_chat_unignore:
  type: command
  name: unignore
  description: Does something
  usage: /unignore <&lt>player<&gt>
  required: 1
  permission: chat.ignore
  tab completions:
    1: <server.players_flagged[chat.ignore].exclude[<player>].filter_tag[<[filter_value].flag[chat.ignore].contains[<player>]>].parse[name]>
  script:
  - inject cmd_args

  - define user <context.args.first>
  - inject cmd_player

  - if !<[user].has_flag[chat.ignore]> or <player> not in <[user].flag[chat.ignore]>:
    - narrate "<red>You aren't ignoring this player!"
    - stop

  - flag <[user]> chat.ignore:<-:<player>
  - if <[user].flag[chat.ignore].is_empty>:
    - flag <[user]> chat.ignore:!

  - narrate "<green>Un-ignored <yellow><[user].name><green>."