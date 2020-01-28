--Create frame for testing (temporary)
local frame = CreateFrame("Frame");

-- Methods / Functions for the new Frame Object:
frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT");
frame:SetSize(200, 500);
frame:SetScale(0.8);
frame:SetFrameLevel(20);
frame:SetFrameStrata("MEDIUM");