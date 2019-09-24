local frame = CreateFrame("FRAME")
frame:RegisterEvent("ADDON_LOADED") -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT") -- Fired when user is logging out

local function printdivider()
    print("---------------------------------------------")
end

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

--[[
     autoclear login logs code below
]]--
addonloaded_marker = false
function frame:OnEvent(event)
    if event == "ADDON_LOADED" then
        if addonloaded_marker == false then
            C_Timer.After(6, clearchat)
            addonloaded_marker = true
        end
        
    elseif event == "PLAYER_LOGOUT" then
         --print("Player is logging out")
    end
end
frame:SetScript("OnEvent", frame.OnEvent);

function clearchat()
    for i = 1, 45 do
        print("")
    end
end

local function ltrim(s)
    s = string.gsub(s,"nil","")
    s = s:sub(1,-2)
    return(s)
end

local function addstring(textstr)
    textstr = module
    if string.find(textstr,"addstring_whitelist") then
        print("Whitelist detected")
        textstr = string.gsub(textstr,"addstring_whitelist","")
        decision = "whitelist"
    elseif string.find(textstr,"addstring_blacklist") then
        print("Blacklist detected")
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
        -- print(count,": -",substring) DEBUGGING PRINT
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
    print("Added string : ", finalstring)
    printdivider()

    if decision == "whitelist" then
        table.insert(whitelistedStringTable,finalstring)
    elseif decision == "blacklist" then
        table.insert(blacklistedStringTable,finalstring)
    end

    flushstrings()

    if decision == "whitelist" then
        print("Added to whitelist")
    elseif decision == "blacklist" then
        print("Added to blacklist")
    end
end

local function help()
    print("Commands : ")
    print(" ")
    printdivider()
    print("/CS addstring_[whitelist/blacklist] [String goes here]")
    print("Description : Adds a string to whitelist/blacklist accordingly")
    print("Example : /CS addstring_whitelist apple, will whitelist the word apple")
    printdivider()
    print("/CS delstrings")
    print("Description : Wipes all whitelisted and blacklisted strings")
    printdivider()
    print("/CS liststrings_[whitelist/blacklist]")
    print("Description : Lists all strings in whitelist")
    print("Example : /CS liststrings_blacklist, will list blacklisted strings.")
    printdivider()
    print("/CS case_insensitive_[on/off]")
    print("Description : Turns case insensitivity detection on or off")
    print("Example : /CS case_insensitive_off")
    printdivider()
    print("/CS case_insensitive_status")
    print("Description : Checks if case insensitivity is on or off")
    printdivider()
    print("/CS help")
    print("Description : Prints this page")
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

    for i,v in ipairs(whitelistedStringTable) do
        print(i,": -",v,"||")
    end
    printdivider()
end

local function liststrings_blacklist()
    printdivider()
    print("Blacklisted Strings : ")
    if (blacklistedStringTable == nil) then
         print("Blacklist is empty")
    end

    for i,v in ipairs(blacklistedStringTable) do
        print(i,": -",v,"||")
    end
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

local function CommandHandler()
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
    elseif module == "" then --Aka, if the user ONLY types /CS in chat
        help()
    elseif string.find(module, "addstring_whitelist") or string.find(module, "addstring_blacklist")  then -- if the keyword addstring is detected AT ALL
        addstring()
    else
        print("Incorrect command entered")
        print("Typed command: ","'",module,"'")
    end
end

SLASH_CS1 = "/CS"
SlashCmdList["CS"] = function(raw_module)
    module = raw_module
    CommandHandler()
end

local chatFrame = CreateFrame("FRAME")

chatFrame:RegisterEvent("CHAT_MSG_GUILD")
chatFrame:RegisterEvent("CHAT_MSG_OFFICER")
chatFrame:RegisterEvent("CHAT_MSG_PARTY")
chatFrame:RegisterEvent("CHAT_MSG_RAID_LEADER")
chatFrame:RegisterEvent("CHAT_MSG_RAID")
chatFrame:RegisterEvent("CHAT_MSG_WHISPER")
chatFrame:RegisterEvent("CHAT_MSG_BN_WHISPER")
chatFrame:RegisterEvent("CHAT_MSG_CHANNEL")
chatFrame:RegisterEvent("CHAT_MSG_SAY")

local function chat_filter(self,event,message,sender,channel_number,channel_name,...)
    debug_mode = false
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
        if caseInsensitive == true then

        if message:find(v) then -- if matches normally
            print("|cff00ff00".."↓ Whitelisted Message ↓")
            RaidNotice_AddMessage(RaidWarningFrame,"ALERT: Whitelisted string detected", ChatTypeInfo["RAID_WARNING"])
            PlaySoundFile("Sound\\I        --v = v.lower()erface\\RaidWarning.ogg")
        end

        message = message:lower()
        --v = v.lower()
        if message:find(v) then -- if matches all lowercase
            print("|cff00ff00".."↓ Whitelisted Message ↓")
            RaidNotice_AddMessage(RaidWarningFrame,"ALERT: Whitelisted string detected", ChatTypeInfo["RAID_WARNING"])
            PlaySoundFile("Sound\\Interface\\RaidWarning.ogg")
        end

        message = message:upper()
        --v = v.upper()
        if message:find(v) then -- if matches all uppercase
            print("|cff00ff00".."↓ Whitelisted Message ↓")
            RaidNotice_AddMessage(RaidWarningFrame,"ALERT: Whitelisted string detected", ChatTypeInfo["RAID_WARNING"])
            PlaySoundFile("Sound\\Interface\\RaidWarning.ogg")
        end

        -- end of main if block
        elseif caseInsensitive == false then
            if message:find(v) then
                print("|cff00ff00".."↓ Whitelisted Message ↓")
                RaidNotice_AddMessage(RaidWarningFrame,"ALERT: Whitelisted string detected", ChatTypeInfo["RAID_WARNING"])
                PlaySoundFile("Sound\\Interface\\RaidWarning.ogg")
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
    
        -- end of main if block
        elseif caseInsensitive == false then
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