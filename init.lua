-- Namespace
local _, core = ...; 

--  ~=* Create slash commands for chat *=~

function core:init(event, name)
	SLASH_SDKP1 = "/sdkp"
	SLASH_SDKP2 = "/sdkp toggle"
	SlashCmdList["SDKP"] = function()
		core.Config.Toggle;
	end

end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", core.init);