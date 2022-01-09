mortal_find_dying_player:
  type: task
  script:
  # Find the first NPC within 2 blocks of the player's location
  - define target <player.location.find_npcs_within[2].first.if_null[null]>
  # Stop if the NPC wasn't found or doesn't have the proper flag
  - if <[target]> == null || !<[target].has_flag[mortal.copy]>:
    - stop

mortal_true_death:
  type: task
  script:
  - inject mortal_find_dying_player
  # Add grave
  - run mortal_create_grave def:<[target].location>
  # Kill player
  - adjust <player> gamemode:survival
  - hurt <player.health>
  - flag <player> mortal.dying:!
  # Remove NPC
  - remove <[target]>