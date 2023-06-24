// Strip the teams weapons


util.AddNetworkString("EvtWepStrip")
util.AddNetworkString("EvtWepStripAdmin")

function EventStripCommand(ply, text, teamChat)
    if text == "!eventstrip" then
        if ply:IsAdmin() then
            for _, target in ipairs(player.GetAll()) do
                if target:Team() == TEAM_RED or target:Team() == TEAM_BLUE then
                    target:StripWeapons()
                    net.Start("EvtWepStrip")
                    net.WriteBool(true)  -- Set a boolean value to indicate it's a team message
                    net.Send(target)
                end
            end
                net.Start("EvtWepStripAdmin")
                net.Send(ply)
        else
            ply:ChatPrint("You do not have permission to use this command.")
        end
        return ""
    end
end
hook.Add("PlayerSay", "EventStripCommand", EventStripCommand)

EventStripCommand()

// Bring commands for the blue and red team

util.AddNetworkString("EvtBringMsg")
util.AddNetworkString("EvtBringMsgAdmin")

function EventTeamPos(ply, text, teamChat)
    if text == "!bringred" then
        if ply:IsAdmin() then
            local adminPos = ply:GetEyeTrace().HitPos
            local spreadDistance = 50 -- Adjust this value to control the spread distance
            
            local redPlayers = {}
            for _, target in ipairs(player.GetAll()) do
                if target:Team() == TEAM_RED then
                    table.insert(redPlayers, target)
                end
            end
            
            local numRedPlayers = #redPlayers
            local angleStep = 360 / numRedPlayers
            local currentAngle = 0
            
            for _, target in ipairs(redPlayers) do
                local posX = adminPos.x + (math.cos(math.rad(currentAngle)) * spreadDistance)
                local posY = adminPos.y + (math.sin(math.rad(currentAngle)) * spreadDistance)
                local newPos = Vector(posX, posY, adminPos.z)
                
                target:SetPos(newPos)
                net.Start("EvtBringMsg")
                net.WriteBool(true)
                net.Send(target)
                
                currentAngle = currentAngle + angleStep
            end
            
            net.Start("EvtBringMsgAdmin")
            net.Send(ply)
        else
            ply:ChatPrint("You do not have permission to use this command.")
        end
        return ""
    elseif text == "!bringblue" then
        if ply:IsAdmin() then
            local adminPos = ply:GetEyeTrace().HitPos
            for _, target in ipairs(player.GetAll()) do
                if target:Team() == TEAM_BLUE then
                    target:SetPos(adminPos)
                    net.Start("EvtBringMsg")
                    net.WriteBool(true)
                    net.Send(target)
                end
            end
            net.Start("EvtBringMsgAdmin")
            net.Send(ply)
        else
            ply:ChatPrint("You do not have permission to use this command.")
        end
        return ""
    end
end
hook.Add("PlayerSay", "EventTeleport", EventTeamPos)






// Give Teams a Random Weapon


local WeaponsTbl = {
  "arccw_ak47",
  "arccw_awm",
  "arccw_deagle50",
  "arccw_shorty",
  "arccw_m14",
  "arccw_m60",
  "arccw_mp5",
  "arccw_scout",
}

util.AddNetworkString("RdmWepMsg")
util.AddNetworkString("RdmWepMsgAdmin")
function giveEventWeapon(ply, text, teamChat)
    if text == "!eventweapon" then
        if ply:IsAdmin() then
            for _, target in ipairs(player.GetAll()) do
                if target:Team() == TEAM_RED or target:Team() == TEAM_BLUE then
                    local randomWeapon = table.Random(WeaponsTbl) -- Select a random weapon from the table
                    target:Give(randomWeapon)
                        net.Start("RdmWepMsg")  -- Prints the [rEvents] Message in players chatbox
                        net.WriteBool(true)
                        net.Send(target)
                end
            end
            net.Start("RdmWepMsgAdmin")
            net.Send(ply)
        else
            ply:ChatPrint("You do not have permission to use this command.")
        end
        return ""
    end
end
hook.Add("PlayerSay", "giveweapon", giveEventWeapon)
