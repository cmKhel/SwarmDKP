SwarmDKP = LibStub("AceAddon-3.0"):NewAddon("SwarmDKP", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0",
											"AceDB-3.0", "AceDBOptions-3.0")

-- initialize function that i've cannibalized from other addon 
local function SwarmDKP:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SwarmDKPdb", {
		-- populate with saved variables (tables we make)
	}, true)


	PrintWelcomeMsg();
end

local function PrintWelcomeMsg()
	SwarmDKP:Print("|cffffc863SwarmDKP initialized. /sdkp for  more info.")
end


--[=====[ 
****************************************
			CREATE UI
****************************************
--]=====]

-- create panel
local tablePanel = CreateFrame("Frame", "SDKP_tablePanel", UIParent, "BasicFrameTemplateWithInset");
-- methods / functions for the new Frame Object:
	tablePanel:SetSize(600, 600);
	tablePanel:SetPoint("CENTER", UIParent, "CENTER"); -- panel set at center of screen
	tablePanel:SetShown(true);
	tablePanel:SetFrameLevel(10); -- ensure highest layer visibility so not blocked by other UI elements
	tablePanel:SetClampedToScreen(true); -- prevent panel from being off screen

-- child frames and regions:
-- create title text
	tablePanel.title = tablePanel:CreateFontString(nil, "OVERLAY");
	tablePanel.title:SetFontObject("GameFontHighlight");
	tablePanel.title:SetPoint("CENTER", tablePanel.TitleBg, "CENTER", 0, 0);
	tablePanel.title:SetText("Swarm DKP Test Frame");

	-- create buttons
	-- name button
	nameBtn = CreateFrame("Button", nil, tablePanel, "GameMenuButtonTemplate");
	nameBtn:SetPoint("LEFT", tablePanel, "TOP", -150, -50);
	nameBtn:SetSize(100, 30);
	nameBtn:SetText("Name");
	nameBtn:SetNormalFontObject("GameFontNormalLarge");
	nameBtn:SetHighlightFontObject("GameFontHighlightLarge");
	
	-- class button
	classBtn = CreateFrame("Button", nil, tablePanel, "GameMenuButtonTemplate");
	classBtn:SetPoint("LEFT", tablePanel, "TOP", 0, -50);
	classBtn:SetSize(100, 30);
	classBtn:SetText("Class");
	classBtn:SetNormalFontObject("GameFontNormalLarge");
	classBtn:SetHighlightFontObject("GameFontHighlightLarge");
	
	-- DKP button
	dkpBtn = CreateFrame("Button", nil, tablePanel, "GameMenuButtonTemplate");
	dkpBtn:SetPoint("LEFT", tablePanel, "TOP", 150, -50);
	dkpBtn:SetSize(100, 30);
	dkpBtn:SetText("DKP");
	dkpBtn:SetNormalFontObject("GameFontNormalLarge");
	dkpBtn:SetHighlightFontObject("GameFontHighlightLarge");
	
	-- function to sort by button's name on click


-- TODO: Create scroll frames for table choice (left), and for specific table (right)
-- nested frame maybe?

-- hide the panel on load
	tablePanel:Hide();

--[=====[ 
****************************************
			SLASH COMMANDS
****************************************
--]=====]

local function SwarmDKP:SDKP_SlashHandler(msg, editbox)
-- pattern matching that skips leading whitespace and whitespace between cmd and args
-- any whitespace at end of args is retained
	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
	local function getHelp()
	  	print("|cffffc863SwarmDKP commands:")
	    print("/sdkp toggle - toggles DKP window")
	    print("/sdkp help - prints help commands")
	end

	if cmd == "toggle" then
	print("|cffffc863SwarmDKP: |cfffffffeToggling DKP window")
    tablePanel:SetShown(not tablePanel:IsShown());

	elseif cmd == "help" then
		getHelp();

	else
	-- If not handled above, display some sort of help message
		getHelp();
  end
end

SLASH_SDKP1 = "/sdkp"

SlashCmdList["SDKP"] = function(msg)
	SDKP_SlashHandler(string.lower(msg));
end



--[=====[ 
****************************************
			CREATE DUMMY TABLE
****************************************
--]=====]

local function SwarmDKP:InitializeDKPTable()
	local dkpVal = 0;

-- create table
	local dummyTable = {};

	dummyTable["Khel", {"Shaman", dkpVal}];
	dummyTable["Tango", {"Mage", dkpVal}];

-- populate with guild roster
--	for i=1,(GetNumGuildMembers()) do
--		local t = {GetGuildRosterInfo(i)}
--		if t[2] ~= "Alts" then
--			table.insert(dummyTable, t[1], {t[11], dkpVal});
--		end
--	end

-- put values into savedvariables
self.db.char.dummyTable = dummyTable;

end