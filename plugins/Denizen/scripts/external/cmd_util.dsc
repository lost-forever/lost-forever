#| https://forum.denizenscript.com/resources/command-utilities.78/

#| -- Command Utilities --
#| Easy injections to keep command scripts concise
#|
#| Original by Behr, adapted by acikek
#|
#| @date 1/28/22
#| @license MIT

cmd_args:
  type: task
  debug: false
  script:
  - define amount <queue.script.data_key[required].if_null[1]>
  - if <context.args.size> < <[amount]>:
    - inject cmd_syntax

cmd_syntax:
  type: task
  debug: false
  script:
  - narrate <&[emphasis]><queue.script.data_key[usage].parsed>
  - narrate <&[base]><queue.script.data_key[description]>
  - stop

cmd_err:
  type: task
  debug: false
  definitions: reason
  script:
  - if <[reason].exists>:
    - define hover "<&[error]>Attempted: <&[base]>/<context.alias> <context.raw_args>"
    - narrate <&[error]><[reason].on_hover[<[hover]>]>
    - stop

cmd_player:
  type: task
  debug: false
  definitions: user
  script:
  - if !<server.match_player[<[user]>].exists>:
    - define reason "That player doesn't exist or is offline!"
    - inject cmd_err
  - define user <server.match_player[<[user]>]>

cmd_offline_player:
  type: task
  debug: false
  definitions: user
  script:
  - if !<server.match_offline_player[<[user]>].exists>:
    - define reason "That player doesn't exist!"
    - inject cmd_err
  - define user <server.match_offline_player[<[user]>]>