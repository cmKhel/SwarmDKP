-- ~=* Create frame for testing on load *=~
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
testFrame.nameBtn = CreateFrame("Button", nil, testFrame, "GameMenuButtonTemplate");
testFrame.nameBtn:SetPoint("LEFT", testFrame, "TOP", -150, -50);
testFrame.nameBtn:SetSize(100, 30);
testFrame.nameBtn:SetText("Name");
testFrame.nameBtn:SetNormalFontObject("GameFontNormalLarge");
testFrame.nameBtn:SetHighlightFontObject("GameFontHighlightLarge");

testFrame.classBtn = CreateFrame("Button", nil, testFrame, "GameMenuButtonTemplate");
testFrame.classBtn:SetPoint("LEFT", testFrame, "TOP", 0, -50);
testFrame.classBtn:SetSize(100, 30);
testFrame.classBtn:SetText("Class");
testFrame.classBtn:SetNormalFontObject("GameFontNormalLarge");
testFrame.classBtn:SetHighlightFontObject("GameFontHighlightLarge");

testFrame.dkpBtn = CreateFrame("Button", nil, testFrame, "GameMenuButtonTemplate");
testFrame.dkpBtn:SetPoint("LEFT", testFrame, "TOP", 150, -50);
testFrame.dkpBtn:SetSize(100, 30);
testFrame.dkpBtn:SetText("DKP");
testFrame.dkpBtn:SetNormalFontObject("GameFontNormalLarge");
testFrame.dkpBtn:SetHighlightFontObject("GameFontHighlightLarge");

-- TODO: Create scroll frames for table choice (left), and for specific table (right)

--  ~=* Create slash commands for chat *=~

SLASH_SDKP = "/sdkp";

local function SlashSDKP(msg, editbox)
	local shown = testFrame:IsShown()
	local visible = testFrame:IsVisible()

	if shown == false then
		testFrame:SetShown(true);
		print("Showing testFrame...");
		print("IsShown() == " .. shown);
		print("IsVisible() == " .. visible);
	else
		testFrame:Hide();
		print("Hiding testFrame...");
		print("IsShown() == " .. shown);
		print("IsVisible() == " .. visible);
	end
end

SlashCmdList["SDKP"] = SlashSDKP; -- add /sdkp to command list
