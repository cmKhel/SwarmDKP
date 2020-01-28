-- ~=* Create frame for testing on load *=~
local testFrame = CreateFrame("Frame", "SDKP_TestFrame", UIParent, "BasicFrameTemplate");

local shown = testFrame:IsShown()
local visible = testFrame:IsVisible()


-- Methods / Functions for the new Frame Object:
testFrame:SetSize(600, 600);
testFrame:SetPoint("CENTER", UIParent, "CENTER"); -- panel set at center of screen
testFrame:SetShown(true);
testFrame:SetFrameLevel(10); -- ensure highest layer visibility so not blocked by other UI elements
testFrame:SetClampedToScreen(true); -- prevent panel from being off screen

print("Is shown: " .. shown .. " " .. "Is visible: " .. visible); -- Debug to show if frame is showing or visible on load.


--  ~=* Create slash commands for chat *=~

SLASH_SDKP = "/sdkp";

local function SDKPfunc(msg)
	if testFrame:IsShown() == false then
		testFrame:SetShown(true);
		print("Showing testFrame...");
		print("IsShown() == " .. shown);
		print("IsVisible() == " .. visible);
	else
		testFrame:SetShown(false);
		print("Hiding testFrame...");
		print("IsShown() == " .. shown);
		print("IsVisible() == " .. visible);
	end
end

SlashCmdList["SDKP"] = SDKPfunc; -- add /sdkp to command list


