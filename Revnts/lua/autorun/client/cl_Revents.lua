
    local accentColor = Color(169, 97, 173)
    local ply = LocalPlayer()


// RANDOM WEAPON MESSAGES FOR ADMIN AND TEAM_BLUE TEAM_RED

net.Receive("RdmWepMsg", function()
    local isTeamMessage = net.ReadBool()

    if isTeamMessage then
        chat.AddText(accentColor, "[rEvents]", Color(255, 255, 255), " You have been given a random weapon!")
    end
end)

net.Receive("RdmWepMsgAdmin", function()

    if ply:IsAdmin() then
        chat.AddText(accentColor, "[rEvents]", Color(255, 255, 255), " You have given the players a random weapon!")
    end
end)


// STRIP WEAPON MESSAGES FOR ADMIN AND TEAM_BLUE / TEAM_RED

net.Receive("EvtWepStrip", function()

     if isTeamMessage then
        chat.AddText(accentColor, "[rEvents]", Color(255, 255, 255), " Your weapons have been stripped before the event!")
    end
end)

net.Receive("EvtWepStripAdmin", function()

    if ply:IsAdmin() then 
        chat.AddText(accentColor, "[rEvents]", Color(255, 255, 255), " You have stripped the players weapons!")
    end
end)

// TELEPORT MESSAGES FOR ADMIN AND TEAM_BLUE / TEAM_RED

net.Receive("EvtBringMsg", function()
    local isTeamMessage = net.ReadBool()

    if isTeamMessage then
      chat.AddText(accentColor, "[rEvents]", Color(255, 255, 255), " Get your positions, wait for the command!")
    end
end)

net.Receive("EvtBringMsgAdmin", function()
    if ply:IsAdmin() then 
    chat.AddText(accentColor, "[rEvents]", Color(255, 255, 255), " You have teleported a team!")
  end
end)

