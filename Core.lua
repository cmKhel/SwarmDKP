--Create frame for testing (temporary)
local testFrame = CreateFrame("Frame", "SDKP_TestFrame", UIParent, "BasicFrameTemplateWithInset");

-- Methods / Functions for the new Frame Object:
testFrame:SetSize(600, 600);
testFrame:SetPoint("CENTER", UIParent, "CENTER"); -- UI put into center of screen
