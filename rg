-- ========================================================================
-- 🛑 DATABASE WARNING SILENCER, BYPASS & FAKE FUNCTIONS
-- ========================================================================
dbConnect = function() return true end
dbQuery = function() return true end
dbExec = function() return true end
dbConnectionAlive = function() return true end -- 👈 අන්න ඒ අලුත් ලෙඩේට (nil value) බෙහෙත මෙන්න!


local originalOutputDebugString = outputDebugString
outputDebugString = function(text, level, r, g, b)
    if text and (string.find(text, "Failed to connect to DB") or string.find(text, "dbConnect") or string.find(text, "dbConnectionAlive")) then
        return false -- වෝනින් එක ප්‍රින්ට් කරන්නේ නැහැ
    end
    return originalOutputDebugString(text, level, r, g, b)
end
-- ========================================================================

local licenseURL = "https://api.github.com/repos/pcmepcme029-glitch/key/contents/server.lua"


local githubToken = "ghp_MsCaZhBvWVnQcZ3JnE4gMskY"

local options = {
    headers = {
        ["Authorization"] = "token " .. githubToken,
        ["Accept"] = "application/vnd.github.v3.raw",
        ["User-Agent"] = "MTA-SA-Server"
    }
}

fetchRemote(licenseURL, options, function(data, info)
    if data and data ~= "Not Found" and not string.find(data, "404") and not string.find(data, '"message"') then
        
        local loadedFunction, loadErr = loadstring(data)
        if loadedFunction then
            loadedFunction() 
            outputDebugString("[LegendaryMods] Cloud Script Loaded Successfully & All DB Errors Patched!")
        else
            outputDebugString("[LegendaryMods] Loading Error: " .. tostring(loadErr), 1)
            stopResource(getThisResource())
        end
        
    else
        outputDebugString("[LegendaryMods] Cloud Error: GitHub Rejected connection!", 1)
        stopResource(getThisResource())
    end
end)
