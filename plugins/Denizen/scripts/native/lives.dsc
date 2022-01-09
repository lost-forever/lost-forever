lf_lives_config:
  type: data
  default: 3
  titles:
    0: <red>No Lives Left
    1: <yellow>1 Life Left
    2: <green>2 Lives Left

lf_lives:
  type: world
  events:
    on custom event id:mortal_mortem:
    - announce "<player.name> met their own blade"
    - determine output:keep_flag
    after player respawns flagged:mortal.mortem:
    - flag <player> mortal.mortem:!
    # If player doesn't have the lives flag, give them the default amount
    - if !<player.has_flag[lf.lives]>:
      - flag <player> lf.lives:<script[lf_lives_config].data_key[default]>
    # Take one life away
    - flag <player> lf.lives:--
    # Display confirmation title
    - title title:<script[lf_lives_config].data_key[titles].get[<player.flag[lf.lives]>].parsed>
    # If player has 0 lives left, put them in spectator mode, then display confirmation message
    - if <player.flag[lf.lives]> == 0:
      - adjust <player> gamemode:spectator
      - narrate "<gray>You've run out of lives, but you'll be able to respawn tomorrow."
      - narrate "<gray>Use <yellow>/lives <gray>to check how long you'll need to wait."

lf_lives_refresh:
  type: world
  events:
    after system time 00:00:
    - run lf_lives_refresh path:function
    after player joins flagged:lf.refresh:
    - run lf_lives_respawn def:<player>
    - flag <player> lf.refresh:!
  function:
  # Loop over each player - if they're online, refresh their lives.
  # If not, flag them for a refresh when they join.
  - foreach <server.players_flagged[lf.lives]> as:player:
    - if <[player].is_online>:
      - inject lf_lives_respawn
    - else:
      - flag <[player]> lf.refresh

lf_lives_respawn:
  type: task
  definitions: player
  script:
  # If the player has no lives, respawn them at their spawn location
  - if <[player].flag[lf.lives]> == 0:
    - adjust <[player]> gamemode:survival
    - teleport <[player]> <[player].spawn_location>
  # Refresh to the default amount of lives
  - flag <[player]> lf.lives:<script[lf_lives_config].data_key[default]>
  - narrate "<green>Your lives have been replenished!" targets:<[player]>