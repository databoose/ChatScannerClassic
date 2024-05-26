-- auto-clear on /reload and login, convenient for spammy, loud and noisy addons that like to clog up chat
local OneTimeStartup = false

local function clearchat()
    for i = 1, 45 do
        print("")
    end
    OneTimeStartup = true
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, ...)
	if (event == "ADDON_LOADED") and (OneTimeStartup == false) then
        if clear_on_startup == true then
            C_Timer.After(7, clearchat)
        end
	end
end)

SLASH_CS1 = "/CS"
SlashCmdList["CS"] = function(raw_module)
    module = raw_module
    CommandHandler()
end
--[[
]]--

local function flushstrings()
    tempString1 = nil
    tempString2 = nil
    tempString3 = nil
    tempString4 = nil
    tempString5 = nil
    tempString6 = nil
    tempString7 = nil
    tempstring8 = nil
    tempString9 = nil
    tempString10 = nil
end

local function wipe_everything()
    StaticPopupDialogs["CONFIRM_WIPE"] = 
    {
        text = "Are you absolutely sure that you want to wipe all settings/strings for ChatScanner?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            wipe(whitelistedStringTable)
            wipe(blacklistedStringTable)
            whitelistedStringTable = {nil}
            blacklistedStringtable = {nil}
            caseInsensitive = nil
            debug_mode = nil
            clear_on_startup = nil
            flushstrings()
            print("All settings/strings wiped")
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3
    }

    StaticPopup_Show("CONFIRM_WIPE")
end

local function printdivider()
    print("-----------------------------------------------")
end

local function help()
    printdivider()
    print("/CS addstring_[whitelist/blacklist] [String goes here]")
    print("Description : Adds a string to whitelist/blacklist accordingly")
    print("Example : /CS addstring_whitelist apple, will whitelist the word apple")
    printdivider()
    print("/CS delstrings")
    print("Description : Wipes all whitelisted/blacklisted strings")
    printdivider()
    print("/CS liststrings_[whitelist/blacklist]")
    print("Description : Lists all strings in whitelist")
    print("Example : /CS liststrings_blacklist, will list blacklisted strings.")
    printdivider()
    print("/CS case_insensitive_[on/off]")
    print("Description : Turns case insensitivity detection on or off")
    print("Example : /CS case_insensitive_off, will turn off case insensitivity")
    printdivider()
    print("/CS case_insensitive_status")
    print("Description : Checks if case insensitivity is on or off")
    printdivider()
    print("/CS clear_on_startup_[on/off]")
    print("Description : Clears chatbox on login/UI reload")
    printdivider()
    print("/CS clear_on_startup_status")
    print("Description : Checks if clear_on_startup is on or off")
    printdivider()
    print("/CS debug_mode_[on/off]")
    print("Description : Toggles debug mode, only use this if you know what you're doing")
    printdivider()
    print("/CS debug_mode_status")
    print("Description : Checks if debug mode is on or off")
    printdivider()
    print("/CS wipe_everything")
    print("Description : Wipes all settings and strings for ChatScanner")
    printdivider()
    print("/CS turnoff/turnon")
    print("Description : Turns the chat filter on or off, while still keeping the whitelisted/blacklisted strings.")
    printdivider()
    print("/CS help")
    print("Description : Prints this page")
    printdivider()
end

local function ltrim(s)
    s = string.gsub(s,"nil","")
    s = s:sub(1,-2)
    return(s)
end

local function addstring(textstr)
    local textstr = module
    if string.find(textstr,"addstring_whitelist") then
        textstr = string.gsub(textstr,"addstring_whitelist","")
        decision = "whitelist"
    elseif string.find(textstr,"addstring_blacklist") then
        textstr = string.gsub(textstr,"addstring_blacklist","")
        decision = "blacklist"
    else 
        print("Error occured at function addstring(), on addon ChatScanner")
    end

    printdivider()
    textstr = textstr:sub(1) -- removing first space on the strings that appear for some odd reason

    local count = 1
    for substring in string.gmatch(textstr,"%S+") do
        if count == 1 then
            tempString1 = substring.." " end
        if count == 2 then
            tempString2 = substring.." " end
        if count == 3 then
            tempString3 = substring.." " end
        if count == 4 then
            tempString4 = substring.." " end
        if count == 5 then 
            tempString5 = substring.." " end
        if count == 6 then
            tempString6 = substring.." " end
        if count == 7 then
            tempString7 = substring.." " end
        if count == 8 then
            tempString8 = substring.." " end
        if count == 9 then
            tempString9 = substring.." " end
        if count == 10 then
            tempString10 = substring.." " end
        
        if count > 10 or count == 11 then
            print("ERROR : String above 10 words, please enter string below 10 words.")
            return 0
        end
            
        count = count + 1
        if debug_mode == true then
            print(count,": -",substrblacklisting)
        end
    end

    finalstring = 
        tostring(tempString1)
     .. tostring(tempString2)
     .. tostring(tempString3)
     .. tostring(tempString4) 
     .. tostring(tempString5)
     .. tostring(tempString6)
     .. tostring(tempString7)
     .. tostring(tempString8)
     .. tostring(tempString9)
     .. tostring(tempString10)
    finalstring = ltrim(finalstring)

    if decision == "whitelist" then
        print("Added string to whitelist : ", finalstring)
        printdivider()
        table.insert(whitelistedStringTable,finalstring)
    elseif decision == "blacklist" then
        print("Added string to blacklist : ", finalstring)
        printdivider()
        table.insert(blacklistedStringTable,finalstring)
    end

    flushstrings()
end

local function delstrings()
    wipe(whitelistedStringTable)
    wipe(blacklistedStringTable)
    printdivider()
    print("Wiped")
    printdivider()
end

local function liststrings_whitelist()
    printdivider()
    print("Whitelisted Strings : ")
    if (whitelistedStringTable == nil) then
         print("Whitelist is empty")
    end

    if debug_mode == true then
        for i,v in ipairs(whitelistedStringTable) do
            print(i,": -",v,"||")
        end
    elseif (debug_mode == false) or (debug_mode == nil) then
        for i,v in ipairs(whitelistedStringTable) do
            print(i,": -",v)
        end
    end
    printdivider()
end

local function liststrings_blacklist()
    printdivider()
    print("Blacklisted Strings : ")
    if (blacklistedStringTable == nil) then
         print("Blacklist is empty")
    end

    if debug_mode == true then
        for i,v in ipairs(blacklistedStringTable) do
            print(i,": -",v,"||")
        end
    elseif (debug_mode == false) or (debug_mode == nil) then
        for i,v in ipairs(blacklistedStringTable) do
            print(i,": -",v)
        end
    end
    printdivider()
end

local function case_insensitive_on()
    caseInsensitive = true
    printdivider()
    print("Case insensitivity turned ON")
end

local function case_insensitive_off()
    caseInsensitive = false
    printdivider()
    print("Case insensitivity turned OFF")
end

local function case_insensitive_status()
    if caseInsensitive == false then
        printdivider()
        print("Status : Case insensitivity is OFF")
        printdivider()
    elseif caseInsensitive == true then
        printdivider()
        print("Status : Case insensitivity is ON")
        printdivider()
    else 
        printdivider()
        print("Error : case_insensitive does not exist, turn case_insensitive state on or off to fix this")
        printdivider()
    end
end

local function chat_filter(self,event,message,sender,channel_number,channel_name,...)
    if debug_mode == true then
      print("event :"..event)
      print("message :"..message)
      print("sender :"..sender)
      print("channel_name :"..channel_name)
      printdivider()
    end

    if whitelistedStringTable == nil then
        printdivider()
        print("No string table detected, creating a new, empty one")
        whitelistedStringTable = {nil}
    end

    if blacklistedStringTable == nil then
        printdivider()
        print("No string table detected, creating a new, empty one")
        blacklistedStringTable = {nil}
    end

    for i, v in ipairs(whitelistedStringTable) do
        local dont_repeat_notification = false

        if caseInsensitive == true then
        if (message:find(v)) and (dont_repeat_notification == false) then -- if matches normally
            print("|cff00ff00".."↓ Whitelisted Message ↓")
            RaidNotice_AddMessage(RaidWarningFrame,"ALERT: Whitelisted string detected", ChatTypeInfo["RAID_WARNING"])
            PlaySoundFile("Sound\\Interface\\RaidWarning.ogg")
            dont_repeat_notification = true
        end

        message = message:lower()
        if (message:find(v)) and (dont_repeat_notification == false) then -- if matches all lowercase
            print("|cff00ff00".."↓ Whitelisted Message ↓")
            RaidNotice_AddMessage(RaidWarningFrame,"ALERT: Whitelisted string detected", ChatTypeInfo["RAID_WARNING"])
            PlaySoundFile("Sound\\Interface\\RaidWarning.ogg")
            dont_repeat_notification = true
        end

        message = message:upper()
        if (message:find(v)) and (dont_repeat_notification == false) then -- if matches all uppercase
            print("|cff00ff00".."↓ Whitelisted Message ↓")
            RaidNotice_AddMessage(RaidWarningFrame,"ALERT: Whitelisted string detected", ChatTypeInfo["RAID_WARNING"])
            PlaySoundFile("Sound\\Interface\\RaidWarning.ogg")
            dont_repeat_notification = true
        end

        -- from here on, we are checking just for the exact case sensitive message
        elseif (caseInsensitive == false) or (caseInsensitive == nil) then
            if message:find(v) then
                print("|cff00ff00".."↓ Whitelisted Message ↓") -- green color
                RaidNotice_AddMessage(RaidWarningFrame,"ALERT: Whitelisted string detected", ChatTypeInfo["RAID_WARNING"])
                PlaySoundFile("Sound\\Interface\\RaidWarning.ogg")
                dont_repeat_notification = true
            end
        end
    end

    for i, v in ipairs(blacklistedStringTable) do
        if caseInsensitive == true then

        if message:find(v) then -- if matches normally
            return true
        end

        message = message:lower()
        if message:find(v) then -- if matches all lowercase
            return true
        end

        message = message:upper()
        if message:find(v) then -- if matches all uppercase
            return true
        end
    
        -- from here on, we are checking just for the exact case sensitive message
        elseif (caseInsensitive == false) or (caseInsensitive == nil) then
            if message:find(v) then
                return true -- hide message
            end
        end
    end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", chat_filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", chat_filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", chat_filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", chat_filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", chat_filter)

local function turnoff_handler(self,event,message,sender,channel_number,channel_name,...)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", turnoff_handler)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", turnoff_handler)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", turnoff_handler)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", turnoff_handler)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", chat_filter)
end

local function turnoff()
    print("|cffff0000".."FILTER DISABLED") -- red color
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", chat_filter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", chat_filter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", chat_filter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", chat_filter)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_GUILD", chat_filter)
    turnoff_handler()
end

local function turnon()
    print("|cff00ff00".."FILTER ENABLED") -- green color
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", turnoff_handler)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", turnoff_handler)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", turnoff_handler)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", turnoff_handler)
    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_GUILD", chat_filter)

    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", chat_filter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", chat_filter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", chat_filter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", chat_filter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", chat_filter)
end

function CommandHandler()
    if module == "help" then
        help()
    elseif module == "delstrings" then
        delstrings()
    elseif module == "liststrings_whitelist" then
        liststrings_whitelist()
    elseif module == "liststrings_blacklist" then
        liststrings_blacklist()
    elseif module == "case_insensitive_on" then
        case_insensitive_on()
    elseif module == "case_insensitive_off" then
        case_insensitive_off()
    elseif module == "case_insensitive_status" then
        case_insensitive_status()
    elseif module == "clear_on_startup_on" then
        clear_on_startup = true
        printdivider()
        print("clear_on_startup set to true")
        printdivider()
    elseif module == "clear_on_startup_off" then
        clear_on_startup = false
        printdivider()
        print("clear_on_startup set to false")
        printdivider()
    elseif module == "clear_on_startup_status" then
        if clear_on_startup == true then
            printdivider()
            print("clear_on_startup is on")
            printdivider()
        elseif clear_on_startup == false then
            printdivider()
            print("clear_on_startup is off")
            printdivider()
        else
            printdivider()
            print("clear_on_startup seems to be nil (nonexistent)")
            printdivider()
        end
    elseif module == "debug_mode_on" then
        debug_mode = true
        printdivider()
        print("Debug mode activated")
        printdivider()
    elseif module == "debug_mode_off" then
        debug_mode = false
        printdivider()
        print("Debug mode deactivated")
        printdivider()
    elseif module == "debug_mode_status" then
        if debug_mode == true then
            printdivider()
            print("debug_mode is on")
            printdivider()
        elseif debug_mode == false then
            printdivider()
            print("debug_mode is off")
            printdivider()
        else
            printdivider()
            print("debug_mode seems to be nil (nonexistent)")
            printdivider()
        end
    elseif module == "wipe_everything" then
        wipe_everything()
    elseif string.find(module, "addstring_whitelist") or string.find(module, "addstring_blacklist")  then
        addstring()
    elseif module == "turnoff" then
        turnoff()
    elseif module == "turnon" then
        turnon()
    elseif module == "" then --Aka, if the user ONLY types /CS in chat
        help()
    else
        print("Incorrect command entered")
        print("Typed command: ","'",module,"'")
    end
end

