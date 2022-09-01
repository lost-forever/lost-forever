lf_discord_send:
  type: task
  definitions: channel|message
  script:
  - ~discordmessage id:bot channel:<server.flag[discord.channels.<[channel]>]> <[message]>

lf_discord_check_link_message:
  type: task
  script:
  - define url "<element[Discord Server].on_hover[Click to join].on_click[<server.flag[discord.invite]>].type[open_url]>"
  - narrate <empty>
  - narrate "<&[error]>This action requires you to link your <&[discord]>Discord <&[error]>account."
  - narrate "<&[base]>Run <&[emphasis]>/link <&[base]>in the <&[url]><[url]><&r> <&[base]>to connect your accounts."
  - narrate <empty>

lf_discord_check_link:
  type: task
  script:
  - if not <player.has_flag[discord.link]>:
    - run discord_check_link_message
    - stop

lf_discord_check_link_cancel:
  type: task
  script:
  - if not <player.has_flag[discord.link]>:
    - run discord_check_link_message
    - determine cancelled