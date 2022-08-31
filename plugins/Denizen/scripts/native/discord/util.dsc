lf_discord_send:
  type: task
  definitions: channel|message
  script:
  - ~discordmessage id:bot channel:<server.flag[discord.channels.<[channel]>]> <[message]>