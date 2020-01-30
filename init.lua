-- Namespace
local _, core = ...; 

--  ~=* Create slash commands for chat *=~
function core:init(event, name)
	SLASH_SDKP1 = "/sdkp"
	SlashCmdList["SDKP"] = function()
		core.Config.Toggle;
	end

	core:Print("Swarm DKP loaded.");
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", core.init);