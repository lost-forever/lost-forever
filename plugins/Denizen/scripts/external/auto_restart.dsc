#| Adapted from https://paste.denizenscript.com/View/80291

auto_restart:
  type: world
  debug: false
  events:
    # TODO uncomment this in prod
    #on system time 03:00:
    #- run auto_restart_handler
    on player logs in server_flagged:auto_restart:
    - determine "KICKED:Server is restarting momentarily, please wait."

auto_restart_handler:
  type: task
  debug: false
  script:
  - wait 1m
  - define marks <list[30m|20m|15m|10m|5m|4m|3m|2m|1m|30s|15s|10s|5s].parse[as_duration]>
  - foreach <[marks]> as:mark:
    - if <server.online_players.is_empty>:
      - foreach stop
    - define display_in "<[mark].formatted.replace[s].with[ seconds].replace[m].with[ minutes].replace[1 minutes].with[1 minute]>"
    - announce "<&[negative]>Server will automatically restart in <&[emphasis]><[display_in]><&[negative]>."
    - if <[mark].in_seconds> <= 60:
      - actionbar "<&[negative]>Restart in <&[emphasis]><[display_in]><&[negative]>." targets:<server.online_players>
      - flag server auto_restart duration:<[mark].add[10s]>
    - wait <[mark].sub[<[marks].get[<[loop_index].add[1]>].if_null[0s]>].if_null[5s]>
  - flag server auto_restart duration:5s
  - announce "<&[negative]>Server restarting!"
  - ~run lf_discord_send "def:relay|<&gt>Server restarting..."
  - kick <server.online_players> "reason:Automatic restart; please wait a minute before rejoining."
  - wait 1s
  - adjust server restart
