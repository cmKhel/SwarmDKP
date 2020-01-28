-- ~=* Create frame for testing on load *=~
local testFrame = CreateFrame("Frame", "SDKP_TestFrame", UIParent, "BasicFrameTemplate");

-- Methods / Functions for the new Frame Object:
testFrame:SetSize(600, 600);
testFrame:SetPoint("CENTER", UIParent, "CENTER"); -- panel set at center of screen
testFrame:SetShown(true);
testFrame:SetFrameLevel(10); -- ensure highest layer visibility so not blocked by other UI elements
testFrame:SetClampedToScreen(true); -- prevent panel from being off screen

print("Is shown: " .. testFrame:IsShown() .. " " .. "Is visible: " .. testFrame:IsVisible()); -- Debug to show if frame is showing or visible on load.


--  ~=* Create slash commands for chat *=~
local function MyAddonComands(msg, editbox)
	if !testFrame:IsShown() then
		testFrame:SetShown(true)
		print("Showing testFrame...")
		print("IsShown() == " .. testFrame:IsShown())
		print("IsVisible() == " .. testFrame:IsVisible())
	else
		testFrame:SetShown(false)
		print("Hiding testFrame...")
		print("IsShown() == " .. testFrame:IsShown())
		print("IsVisible() == " .. testFrame:IsVisible())
	end
end

SLASH_SDKP = "/sdkp"

SlashCmdList["SDKP"] = MyAddonComands -- add /sdkp to command list


