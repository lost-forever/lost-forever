lf_discord_format_creation_event:
  type: procedure
  definitions: type|name
  script:
  - choose <[type]>:
    - case capital_kingdom:
      - determine "It is the **Capital** of the new **<[name]>** kingdom."
    - case capital_free:
      - determine "It is a **Free** settlement, functioning as its own **Capital**."
    - default:
      - determine "Its allegiance lies with the kingdom of **<[name]>**."

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
    after custom event id:kdm_create:
    - define first "**<discord_user[<player.flag[discord.link]>].mention>** has founded the new settlement **<context.settlement.get[names].first>**."
    - define second <proc[lf_discord_format_creation_event].context[<context.type>|<context.kingdom_name>]>
    - run lf_discord_send def:events|<[first]><n><[second]>