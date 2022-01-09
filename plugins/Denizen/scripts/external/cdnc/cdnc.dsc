cdnc_config:
  type: data
  world: world
  ticks: 36

cdnc:
  type: world
  events:
    after server start:
    - define config <script[cdnc_config]>
    - define world <world[<[config].data_key[world]>]>
    # If world has daylight cycle, set it to false
    - if <[world].gamerule[doDaylightCycle]>:
      - gamerule <[world]> doDaylightCycle false
    # Set to enabled if flag not present
    - if !<server.has_flag[cdnc.enabled]>:
      - flag server cdnc.enabled:true
    # Start modifying time
    - if <server.flag[cdnc.enabled]>:
      - run cdnc_modify_time def:<[config]>|<[world]>

cdnc_modify_time:
  type: task
  definitions: config|world
  debug: false
  script:
  - debug log "<green>Beginning time modification for world <yellow><[world].name><green>.<&r>"
  # For each tick, loop over each world and set the time properly
  - define tick <[world].time>
  - while <server.flag[cdnc.enabled].if_null[false]>:
    - time <[world]> <[tick]>t
    # Reset tick value on overflow
    - define tick:++
    - if <[tick]> > 24000:
      - define tick 0
    # Wait specified amount of ticks
    - wait <[config].data_key[ticks]>t
  # If ends, send confirmation message
  - debug log "<red>CDNC disabled. Stopping modification for world <yellow><[world].name><red>.<&r>"

cdnc_command:
  type: command
  name: cdnc
  description: Controls CDNC status
  usage: /cdnc (enable|disable|status)
  tab completions:
    1: <server.flag[cdnc.enabled].if_true[disable].if_false[enable]>|status
  permission: cdnc.command
  script:
  - define config <script[cdnc_config]>
  - define world <world[<[config].data_key[world]>]>

  - if <context.args.is_empty>:
    - narrate "<gray>Use <yellow>/cdnc enable <gray>to resume time modification."
    - narrate "<gray>Use <yellow>/cdnc disable <gray>to stop time modification."
    - narrate "<gray>Use <yellow>/cdnc status <gray>to view current CDNC values."

  - else if <context.args.first> == enable:
    - if <server.flag[cdnc.enabled]>:
      - narrate "<red>CDNC is already enabled."
      - stop
    # Set server flag and run modification task
    - flag server cdnc.enabled:true
    - run cdnc_modify_time def:<[config]>|<[world]>
    # Confirmation message
    - narrate "<green>CDNC enabled. Check console for details."

  - else if <context.args.first> == disable:
    - if !<server.flag[cdnc.enabled]>:
      - narrate "<red>CDNC is already disabled."
      - stop
    # Set server flag - will be cancelled on next loop
    - flag server cdnc.enabled:false
    - narrate "<green>CDNC will disable upon next iteration."

  - else if <context.args.first> == status:
    - narrate "<gray>CDNC is currently <server.flag[cdnc.enabled].if_true[<green>enabled].if_false[<red>disabled]> <gray>on world <yellow><[world].name> <gray>with <gold><[config].data_key[ticks]> <gray>ticks."

  - else:
    - narrate "<red>Invalid instruction."