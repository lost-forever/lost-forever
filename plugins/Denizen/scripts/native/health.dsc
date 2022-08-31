lf_health_config:
  type: data
  min: 4
  max: 20
  decrement: 4

lf_health:
  type: world
  events:
    on custom event id:mortal_mortem:
    - announce "<player.name> met their own blade"
    - determine output:keep_flag
    after player respawns flagged:mortal.mortem:
    - flag <player> mortal.mortem:!
    # If the player doesn't already have the minimum max health, decrement it
    - if <player.health_max> > <script[lf_health_config].data_key[min]>:
      - adjust <player> max_health:<player.health_max.sub[<script[lf_health_config].data_key[decrement]>]>

lf_health_refresh:
  type: world
  events:
    after system time 00:00:
    - run lf_lives_refresh path:function
  function:
  - define value <script[lf_health_config].data_key[max]>
  # Loop over each player and refresh their max health
  - foreach <server.players> as:__player:
    - if <player.health_max> != <[value]>:
      - adjust <player> max_health:<[value]>
      - heal <player>
      # Confirmation message
      - if <player.is_online>:
        - narrate "<green>You stood the test of time."
        - narrate "<gray><italic>Your max health has been restored."