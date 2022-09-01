lf_discord_create_link_command:
  type: task
  script:
  - definemap options:
      1:
        type: string
        name: username
        description: Your Minecraft username
        required: true

  - ~discordcommand id:bot create group:<server.flag[discord.group]> name:link "description:Links your Discord account to your Minecraft user." options:<[options]>

lf_discord_create_user_link_command:
  type: task
  script:
  - ~discordcommand id:bot create group:<server.flag[discord.group]> type:user "name:Linked Account"