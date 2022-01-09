mortal_actions:
  type: world
  events:
    after player right clicks block flagged:!mortal.reviving:
    - inject mortal_find_dying_player
    # Revive if sneaking
    - if <player.is_sneaking>:
      - inject mortal_revive
    # Loot otherwise
    - else:
      - inventory open d:<[target].flag[mortal.copy].inventory>
    after player right clicks block location_flagged:mortal.grave:
    - inventory open d:<context.location.flag[mortal.grave]>
    - flag <player> mortal.looting:<context.location>
    after player closes inventory flagged:mortal.looting:
    - if <context.inventory.is_empty>:
      - modifyblock <player.flag[mortal.looting]> air
      - flag <player> mortal.looting:!
    on player breaks block location_flagged:mortal.grave:
    - determine passively cancelled
    - narrate "<red>Loot this grave completely to remove it."

mortal_cancel_state:
  type: world
  events:
    on player steps on block flagged:mortal.dying:
    - determine cancelled
    on player spectates entity flagged:mortal.dying:
    - determine cancelled
    on player steps on block flagged:mortal.reviving:
    - flag <player> mortal.reviving:!