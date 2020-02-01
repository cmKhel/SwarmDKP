--namespace
local _, core = ...;


SLASH_TEST1 = "/test1"
SLASH_TEST2 = "/addontest1"
SlashCmdList["TEST"] = function(msg, editbox)
   core.Config.Toggle;
end  



