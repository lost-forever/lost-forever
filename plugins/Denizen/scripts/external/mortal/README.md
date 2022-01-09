# mortal

Rust-like death system for Minecraft servers

## About

This project aims to revamp the Minecraft death system. When a player dies by any means, they are not automatically "truly" killed - their body lays on the floor, unmoving, and can be looted or revived by other players. If the dying player can't get help and wishes to give up, they can use the `mortem` command to do so.

### Details

* Upon death, the player is put into spectator mode, and an NPC is created and animated to lie down at the death location. The spectator cannot move out of the block they were in when they died.
* A dying player can be looted by right-clicking a block in their vicinity. If the player clicking is sneaking, they revive the other player.
  * If the reviving player moves, the process is cancelled.
  * If for some reason either player logs out of the server, the process is cancelled.
* Upon "true" death, the NPC is removed and replaced with a skeleton skull, which can be looted like normal. If the grave is looted completely, the skeleton skull is removed.
  * True death is only triggered by the `mortem` command, but it can be used regardless of whether the player is dying or not.
  * The custom event `mortal_mortem` fires. This is useful for announcing a custom death message, as none is sent by default.
    * If you determine the output as `keep_flag`, then the flag `mortal.mortem` will not be removed from the player by default.

## Setup

Clone using git:
```sh
git clone https://github.com/acikek/mortal
```
Use [dzp](https://github.com/acikek/dzp-rs) for additional features.

## Scripts

### Command

- `mortal_mortem`

### Task

- `mortal_create_grave`
- `mortal_find_dying_player`
- `mortal_revive`
- `mortal_true_death`

### World

- `mortal`
- `mortal_actions`
- `mortal_cancel_state`

## License

MIT © 2022 Skye P.