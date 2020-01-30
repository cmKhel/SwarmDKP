-- ~=* Create frame for testing on load *=~
local testFrame = CreateFrame("Frame", "SDKP_TestFrame", UIParent, "BasicFrameTemplateWithInset");

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
