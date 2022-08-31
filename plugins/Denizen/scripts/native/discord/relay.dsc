lf_discord_relay:
  type: world
  events:
    after custom event id:global_chat:
    - define role <server.flag[discord.roles.ranks.<player.flag[rank]>]>
    - define message "<[role].mention> **<player.name>**: <context.message>"
    - run lf_discord_send def:relay|<[message]>
    after custom event id:mortal_mortem:
    - run lf_discord_send "def:relay|<&gt> ***<player.name>** met their own blade*"
    after player joins:
    - run lf_discord_send "def:relay|<&gt> ***<player.name>** joined*"
    after player quits:
    - run lf_discord_send "def:relay|<&gt> ***<player.name>** left*"