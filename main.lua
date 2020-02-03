-- Testing all in one file to see if this will work.

-- ************************************
--              CONFIG 
-- ************************************
-- ~=* Namespaces *=~
local _, core = ...;
core.Config = {};

local Config = core.Config;
local testFrame;


-- ~=* Defaults *=~
local defaults = { -- will be changed later, following guide to learn at the moment
	theme = {
		r = 0
		g = 0.8
		b = 1
		hex = "00ccff"
	}
}

-- ~=* Frame functions *=~
function Config:GetThemeColor()
	local c = defaults.theme;
	return c.r, c.g, c.b, c.hex;
end

-- consolidate similar button creation for test panel
function Config:CreateButton(point, relativeFrame, relativePoint, xOffset, yOffset, width, height, text)
	local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
	btn:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset);
	btn:SetSize(width, height);
	btn:SetText(text);
	btn:SetNormalFontObject("GameFontNormalLarge");
	btn:SetHighlightFontObject("GameFontHighlightLarge");
	return btn;
end

-- ~=* Create frame panel for testing on load *=~
function Config:CreateMenu()
local testFrame = CreateFrame("Frame", "SDKP_TestFrame", UIParent, "BasicFrameTemplateWithInset");
-- Methods / Functions for the new Frame Object:
	testFrame:SetSize(600, 600);
	testFrame:SetPoint("CENTER", UIParent, "CENTER"); -- panel set at center of screen
	testFrame:SetShown(true);
	testFrame:SetFrameLevel(10); -- ensure highest layer visibility so not blocked by other UI elements
	testFrame:SetClampedToScreen(true); -- prevent panel from being off screen

-- Child frames and regions:
-- Create title text
	testFrame.title = testFrame:CreateFontString(nil, "OVERLAY");
	testFrame.title:SetFontObject("GameFontHighlight");
	testFrame.title:SetPoint("CENTER", testFrame.TitleBg, "CENTER", 0, 0);
	testFrame.title:SetText("Swarm DKP Test Frame");

	-- Create buttons
	-- Name button
	testFrame.nameBtn = self:CreateButton("LEFT", testFrame, "TOP", -150, -50, 100, 30, "Name");
	-- Class button
	testFrame.classBtn = self:CreateButton("LEFT", testFrame, "TOP", 0, -50, 100, 30, "Class");
	-- DKP button
	testFrame.dkpBtn = self:CreateButton("LEFT", testFrame, "TOP", 150, -50, 100, 30, "DKP");

-- TODO: Create scroll frames for table choice (left), and for specific table (right)

	testFrame:Hide();
	return testFrame;
end


-- ************************************
--              INIT 
-- ************************************

-- slash command arguments
core.commands = {
	["toggle"] = function()
		testFrame:SetShown(not menu:IsShown());
	end,

	["help"] = function()
		print(" ");
		core:Print("List of slash commands:")
		core:Print("/toggle - shows DKP window.")
		core:Print("/help - shows commands.") 
		print(" ");
	end,


};

function core:Print(...)
	local hex = select(4, self.Config:GetThemeColor());
	local prefix = string.format("!cff%s%s|r", hex:upper(), "SwarmDKP: ");
	DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, tostringall(...)));
end

-- implement handler for slash commands 
local function HandleSlashCommands(str)
	if (#str == 0) then
		-- entered /sdkp with no additional arguments
		core.commands.help();

		return
	end

	local args = {};
	for _, arg in pairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg);
		end
	end

	local path = core.commands; -- needed for updating found table

	for id, arg in ipairs(args) do
		arg = string.lower(arg);

		if (path[arg]) then
			if type((path[arg]) == "function" ) then
				-- all remaining arguments passed to function 
				path[arg](select(id + 1, unpack(args)));
				return;

			elseif (type(path[arg]) == "table") then
				path = path[arg]; -- another sub-table found

			else
				-- does not exist
				core.commands.help();
				return
			end
		else
			-- does not exist
			core.commands.help();
			return
		end
	end
end

function core:init(event, name)
	if (name ~= "SwarmDKP") then return end

--  ~=* Create slash commands for chat *=~
	SLASH_SDKP1 = "/sdkp";
	SlashCmdList.SDKP =  HandleSlashCommands;

	core:Print("Swarm DKP loaded.");
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", core.init);

