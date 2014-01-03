uuidlog
=======

Starbound Server Mod to Log Player UUIDs

Tested with **Angry Koala**

Produces the following log line to help map players to UUIDs:

```
Info: UUID Log: <Seriallos> (32a3dc1eef39131740a1d6b559b80031)
```

**Warning:** This _should_ work as a server-only mod since it does not
create/modify any items or other assets.  It has not been extensively tested.

Install
=======

Drop into your Starbound server's mods/ directory and restart the server.

Why?
====

I built this as a hacky stopgap for [CommandStar][cs].  When I wrote this, there was
no other way to map player to UUID as an external process.  The purpose is to be
able to know which .clientcontext files on the server map to which player so
that I can determine nearly real-time location information to use for various
features in [CommandStar][cs].

[cs]: https://github.com/seriallos/commandstar

How?
====

This mod adds a Lua script to various monster types.  When the monsters load,
they query for any nearby players.  If one is found, the player's name and UUID
is logged using `world.logInfo` and the data is stored in the global `math`
table.

This will happen once per world thread so it will be emitted many times in a
play session.  At the moment, I don't believe there is any true global storage
so this is the best I could come up with.
