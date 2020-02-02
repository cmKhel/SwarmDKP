-- Namespace
local _, core = ...; 


-- slash command arguments
core.commands = {
	["toggle"] = core.Config.Toggle,

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

