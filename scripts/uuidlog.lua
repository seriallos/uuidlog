--
-- AMG HACKS
--
-- I don't want to spam the logs with UUID reports.
-- Only way to make sure this happens is to use some global storage.
-- Only global storage I know about right now is the math library functions.
-- math[] is the best thing possible right now but even it only maintains state
-- while a world is loaded.
-- So right now, the player UUID will be emitted the first time they visit a
-- newly loaded world.  This could happen on the same world multiple times as a
-- world is unloaded 30 seconds after the last player leaves
--

-- Check for nearby players only on init
function init()
  -- set up my own "namespace" in the math "global"
  if (math['_uuidlog'] == nil) then
    math['_uuidlog'] = {}
  end
  -- set up the list of known UUIDs
  -- This will go away on world unload
  if (math['_uuidlog']['uuids'] == nil) then
    math['_uuidlog']['uuids'] = {}
  end

  local playerIds = world.playerQuery( entity.position(), 100 )
  for _, playerId in pairs(playerIds) do
    local playerName = world.entityName( playerId )
    local playerUuid = world.entityUuid( playerId )
    -- If this is the first time we've seen a player, store their UUID globally
    if( math['_uuidlog']['uuids'][ playerName ] == nil ) then
      world.logInfo( "UUID Log: <"..playerName.."> ("..playerUuid..")" )
      math['_uuidlog']['uuids'][ playerName ] = playerUuid
    end
  end
end

-- This has to be defined otherwise the server gets really unhappy
function main()
end

