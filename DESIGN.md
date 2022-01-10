## Design Goals

Below are the Lost Forever design goals that the server shall implement. These have been refined by contributors and community members alike, and credit will be provided where possible.

### Day-Night Cycle

The in-game day-night cycle shall last 10 hours in tick-time. That is, at 20TPS, each full cycle shall last 10 hours in real time. Additionally, while beds can be rested in, the night can never be skipped. Not only does this add to immersion, but it presents a unique challenge.

* Originally, this was to be 12 hours to fall into the familiar 24-hour real cycle. This would enable players from different timezones to play on the in-game time they desired.
* **Dankxiety** suggested that the cycle be 10 hours long instead; if a player could only join at a certain time of day, they would only experience one in-game time. Offsetting the cycle to not be a factor of 24 would provide variation over time even if players joined at the same time every day, while preserving the original goal.

### Death System

The death system is inspired by Rust. When a player dies, they do not get the "You Died!" screen and have to respawn; instead, they are put in a "dying" state, laying on the ground and unable to move. Other players can loot or revive the player. Further details are outlined in the [mortal project README](https://github.com/acikek/mortal).

Combined with a permanent consequence for a true death, this system enhances immersion and gives players a chance to demonstrate loyalty to one another. Additionally, the graves system eliminates the rush to get back to dropped items in fear of them despawning, and instead lets players approach the situation on their own time.

#### Max Health System

The max health system is an addon to the death system provided by `mortal` that introduces an actual consequence for true deaths. Each time a player truly dies (only available via the `mortem` command), if they are not on the minimum already, their max health gets decreased by 2 hearts. Their original max health is restored automatically as the server enters a new real day.

As mentioned, this makes dying an actual threat, while not entirely eliminating the player from the game. As the player dies, dying more becomes easier, which gives a greater incentive to not die at all. If a player does get low on max health, they can use this as downtime from more dangerous situations and focus on other tasks. The grave system also allows for this, since there's no rush to get items back as soon as possible.

* Originally, the player would have 3 lives per day, and if they ran out, they would be put in spectator until they regained lives. This was an attempt at emulating the hardcore difficulty, with the knowledge that servers had that true hardcore were meant to be temporary. However, this approach was problematic for a number of reasons:
  * When a player lost all their lives, there was nothing else to do. Sure, they would still be able to chat with other players, but gameplay-wise, it wouldn't be worth it to stay on the server.
  * It encouraged tactical use of player lives. In other words, dying itself wouldn't have any actual consequence beyond decreasing a number. The player could be assured that they could use 2 lives and there wouldn't be any negative outcome.
* **Presidential Egg** suggested that the player instead loses some max health on every death. His original suggestion included an item that replenishes lost max health, but this would actually detriment the system; for richer players, dying wouldn't have a consequence anymore. Without a way to restore max health, it ensures that there is an incentive for everyone to avoid death, regardless of their gear.

### Kingdoms

The kingdoms system is a work in progress. This section will be updated once significant changes and/or decisions have been made.

### Transparency and Monetization

I (acikek) will speak from my perspective in this section. One of the primary goals of Lost Forever is to be a completely open-source and transparent project. I want players to know what's going on behind the scenes and provide feedback, as I believe this is the best way to develop a Minecraft server. So far, this has worked; even early into the development process, the ideas that members have contributed have significantly impacted how I want to approach the goals of the server.

Personally, I do not care if people choose to fork this project, close it off, and monetize it. More than anything, this is a passion project and a demonstration of how Minecraft servers could be organized ideally in my perspective.

However, I guarantee that the Lost Forever instance that I host will be completely free-to-play for authenticated Minecraft users. Of course, I plan on accepting donations in the future, but that system will be disconnected from the server insofar as gameplay.

### Daxz

Daxz wanted their name here.