mortal_mortem:
  type: command
  name: mortem
  description: Commit suicide
  usage: /mortem
  aliases:
  - suicide
  script:
  - flag <player> mortal.mortem
  - if <player.has_flag[mortal.dying]>:
    - run mortal_true_death
  - else:
    - run mortal_create_grave def:<player.location>
    - hurt <player> <player.health>