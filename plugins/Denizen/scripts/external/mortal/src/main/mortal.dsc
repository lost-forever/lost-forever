mortal:
  type: world
  events:
    on player dies flagged:!mortal.dying|!mortal.mortem:
    - determine passively cancelled
    # Put the player in spectator mode - can still look around but not present
    - adjust <player> gamemode:spectator
    # Create an NPC of the player
    - create player <player.name> save:copy
    - adjust <entry[copy].created_npc> skin_blob:<player.skin_blob>
    # Spawn after skin loaded
    - spawn <entry[copy].created_npc> <player.location>
    # Adjust the NPC to not be affected by gravity
    - adjust <entry[copy].created_npc> gravity:false
    - animate <entry[copy].created_npc> sleep
    # Flag the player in the "dying" state
    - flag <player> mortal.dying
    - flag <entry[copy].created_npc> mortal.copy:<player>
    # Narrate eath message
    - narrate "<red>You're dying! Wait for someone to revive you, or use <yellow>/mortem <red>to end your life."
    on player dies flagged:mortal.mortem:
    - determine passively no_message
    - customevent id:mortal_mortem save:result
    # Don't un-flag player if event determines 'keep_flag'
    - if keep_flag not in <entry[result].determination_list>:
      - flag <player> mortal.mortem:!