-------------------------------------------------------------------------------
-- Dice Master (C) 2019 <The League of Lordaeron> - Moon Guard
-------------------------------------------------------------------------------

--
-- Event hooks.
--

-------------------------------------------------------------------------------
local Me = DiceMaster4

local eventMap = {}

-------------------------------------------------------------------------------
-- When the player changes their target.
--
function eventMap.PLAYER_TARGET_CHANGED()
	
	if UnitExists("target") and UnitIsPlayer("target") 
	        and UnitIsFriend( "player", "target" )
			and UnitIsSameServer( "target" )
			and UnitIsConnected( "target" ) then
	   
		-- Inspect target if they are a friendly unit.
		Me.Inspect_Open( UnitName( "target" ))
		name, realm = UnitName( "target" )
		if realm ~= nil then
			name = name.."-"..realm
		end
		Me.Inspect_Open(name)	
	else
	
		-- Reset inspect frame otherwise.
		Me.Inspect_Open( nil )
	end
	
end

-------------------------------------------------------------------------------
function Me:OnEvent( event, ... )
	
	if eventMap[event] then
		eventMap[event](...)
	end
	
end

-------------------------------------------------------------------------------
function Me.Events_Init()
	
	-- Register remaining events
	for k,_ in pairs( eventMap ) do
		Me:RegisterEvent( k, "OnEvent" )
	end
end
