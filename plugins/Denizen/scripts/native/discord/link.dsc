lf_discord_handle_link:
  type: task
  definitions: id
  script:
  - if not <player.has_flag[discord.link_request]>:
    - stop
  - flag <player> discord.link_request:!
  - if <[id]> == null:
    - narrate "<red>You declined the request."
    - stop

  - define user <server.flag[discord.group].member[<[id]>]>
  - flag <[user]> link:<player.name>
  - flag <player> discord.link:<[user]>

  - ~discord id:bot remove_role group:<server.flag[discord.group]> role:<server.flag[discord.roles.unlinked]> user:<[user]>

  - narrate "<green>You accepted the request."

lf_discord_link:
  type: world
  events:
    after discord user joins for:bot:
    - if <context.group> != <server.flag[discord.group]>:
      - stop
    - ~discord id:bot add_role group:<server.flag[discord.group]> role:<server.flag[discord.roles.unlinked]> user:<context.user>
    on discord slash command name:link for:bot:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral

    - define __player <server.match_player[<context.options.get[username]>].if_null[null]>

    - if not <player.exists>:
      - define err "Invalid player! Make sure you're logged in to the server."
    - else if <player.has_flag[discord.link_request]>:
      - define err "This player already has a link request!"
    - else if <player.has_flag[discord.link]>:
      - define err "This player is already linked!"

    - if <[err].exists>:
      - ~discordinteraction reply interaction:<context.interaction> <[err]>
      - stop

    - define user <context.interaction.user>
    - define tag <[user].name>#<[user].discriminator>

    - clickable lf_discord_handle_link def:<[tag]> until:5m usages:1 save:accept
    - define accept "<element[ACCEPT].on_hover[<green>Click to accept].on_click[<entry[accept].command>]>"
    - clickable lf_discord_handle_link def:null until:5m usages:1 save:decline
    - define decline "<element[DECLINE].on_hover[<red>Click to decline].on_click[<entry[decline].command>]>"

    - ~discordinteraction reply interaction:<context.interaction> "I sent a private message to **<player.name>**. Check Minecraft for details."

    - narrate <empty>
    - narrate "<&[emphasis]><[tag]> <gold>wants to link to your account."
    - narrate "<green><bold><underline><[accept]><&r> <gray>or <red><bold><underline><[decline]>"
    - narrate <empty>

    - flag <player> discord.link_request:true expire:5m
    on discord user command for:bot:
    - if <context.command.name> == "linked account":
      - define user <context.interaction.target_user>
      - if <[user].has_flag[link]>:
        - define message "<[user].mention> is **<[user].flag[link]>** in-game."
      - else:
        - define message "<[user].mention> isn't linked!"
      - ~discordinteraction reply interaction:<context.interaction> <[message]> ephemeral