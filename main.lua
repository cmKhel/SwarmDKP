
SwarmDKP = LibStub("AceAddon-3.0"):NewAddon("SwarmDKP", "AceConsole-3.0")

function SwarmDKP:OnInitialize()
	SwarmDKP:Print("initializing")
    self.db = LibStub("AceDB-3.0"):New("SwarmDKPdb")
end

function SwarmDKP:OnEnable()
	SwarmDKP:Print("enabling")
    -- Called when the addon is enabled
end

function SwarmDKP:OnDisable()
	SwarmDKP:Print("disabling")
    -- Called when the addon is disabled
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

	-- put table on screen


-- Create scroll frames for table choice (left), and for specific table (right)
-- nested frame maybe?

-- hide the panel on load
	tablePanel:Hide();



--[=====[ 
****************************************
			CREATE TABLE
****************************************
--]=====]

local DummyTable = {}

-- returns length of table passed to function
function SwarmDKP:TableLength(T)
local count = 0
 	for _ in pairs(T) do count = count + 1 end
  		return count
end

-- returns true if table contains key, false if not
function SwarmDKP:TableContains(table, key)
	for i=1,(TableLength(table)) do
		if table[i] == key then
			return true
		else
			return false
	end
end
end

function SwarmDKP:InitTable()
-- populate with guild roster
-- currently limited in scope to my guild only

-- DummyTable [1] = name
-- DummyTable [name[1]] = player class 
-- DummyTable [name[2]] = dkp value initialized to 0
	for i=1,(GetNumGuildMembers()) do
		local t = {GetGuildRosterInfo(i)}
		if string.lower(t[2]) == "raider" or 
		string.lower(t[2]) == "core/teamleader" or 
		string.lower(t[2]) == "officer" or
		string.lower(t[2]) == "guild master" then
			DummyTable[t[1]] = {t[11], 0};
		end
	end
end

-- add to dkp value of member within initialized table
function SwarmDKP:AddDKP(arg1, arg2)
	name = arg1
	number = arg2

	if SwarmDKP:TableContains(DummyTable, name) == true then
		DummyTable[name[2]] = DummyTable[name[2]] + number 
		SwarmDKP:Print(DummyTable[name] "'s DKP is now " .. DummyTable[name[2]])
	else
		SwarmDKP:Print("Player does not exist.")
	end
end


-- subtract from dkp value of member within initialized table
function SwarmDKP:SubtractDKP(arg1, arg2)
	name = arg1
	number = arg2

	if SwarmDKP:TableContains(DummyTable, name) == true then
		DummyTable[name[2]] = DummyTable[name[2]] - number 
		SwarmDKP:Print(DummyTable[name] "'s DKP is now " .. DummyTable[name[2]])
	else
		SwarmDKP:Print("Player does not exist.")
	end
end



-- put values into savedvariables
--self.db.char.dummyTable = dummyTable;


--[=====[ 

--]=====]


--[=====[ 
****************************************
			SLASH COMMANDS
****************************************
--]=====]

SwarmDKP:RegisterChatCommand("sdkp", "MySlashProcessorFunc")

function SwarmDKP:MySlashProcessorFunc(input, arg1, arg2)
	local cmd = input
	local name = arg1
	local number = arg2

	local function getHelp()
	  	SwarmDKP:Print("|cffffc863SwarmDKP commands:")
	    SwarmDKP:Print("/sdkp toggle - toggles DKP window")
	    SwarmDKP:Print("/sdkp help - prints help commands")
	    SwarmDKP:Print("/sdkp init - initializes table -TESTING PURPOSES ONLY-")
	    SwarmDKP:Print("/sdkp add <name> <number> - add DKP to player in table.")
	    SwarmDKP:Print("/sdkp subtract <name> <number> - subtract DKP from player in table.")
	    SwarmDKP:Print("/sdkp check <name> - check if player is in your DKP table.")
	end

	if cmd == "toggle" then
	SwarmDKP:Print("|cffffc863SwarmDKP: |cfffffffeToggling DKP window")
	tablePanel:SetShown(not tablePanel:IsShown());


-- creates table of guild members of certain standing with dkp value of 0
	elseif cmd == "init" then
		SwarmDKP:InitTable()
		for key,value in pairs(DummyTable) do SwarmDKP:Print(key,value[1],value[2]) end
		SwarmDKP:Print("Initialized table with " .. SwarmDKP:TableLength(DummyTable) .. " entries.")

	elseif cmd == "help" then
		getHelp();

-- these do not work
	elseif cmd == "add" then
		SwarmDKP:AddDKP(name, number)
		
	elseif cmd == "subtract" then
		SwarmDKP:SubtractDKP(name, number)

	elseif cmd == "check" then
		SwarmDKP:Print(SwarmDKP:TableContains(DummyTable, name))

-- this works
	else
	-- If not handled above, display some sort of help message
		getHelp();
  end
end
