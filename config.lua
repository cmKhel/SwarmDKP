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
function Config:Toggle()
	local menu = testFrame or Config:CreateMenu();
	menu:SetShown(not menu:IsShown());
end

-- consolidate similar button creation
function Config:CreateButton(point, relativeFrame, relativePoint, xOffset, yOffset, width, height, text)
	local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
	btn:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset);
	btn:SetSize(width, height);
	btn:SetText(text);
	bent:SetNormalFontObject("GameFontNormalLarge");
	btn:SetHighlightFontObject("GameFontHighlightLarge");
	return btn;
end

-- ~=* Create frame for testing on load *=~
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
