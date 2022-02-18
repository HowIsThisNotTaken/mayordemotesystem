util.AddNetworkString("rp_MayorDemote")
concommand.Add("rp_demotemenu", function( Player, cmd )
    if Player:Team() == mayordemote.TeamMayor then
        net.Start("rp_MayorDemote")
            net.WriteEntity(Player)
        net.Send(Player)
    else
        Player:ChatPrint("You aren't the mayor!")
    end
end)

concommand.Add("rp_mayordemote", function(Player, cmd, args)
    if Player:Team() == mayordemote.TeamMayor then
        local target = mayordemote_FindPlayer(args[1])

        if mayordemote.TeamBan == true then
            target:changeTeam(mayordemote.DemotedTeam, true, false)
            target:ChatPrint("You have been demoted for " .. args[2] .. " by " .. Player:Nick())
        end
    else
        Player:ChatPrint("You aren't the mayor!")
    end
end)

function mayordemote_FindPlayer(info)
	    if not info or info == "" then return nil end
    local pls = player.GetAll()

    for k = 1, #pls do
        local v = pls[k]
        if tonumber(info) == v:UserID() then
            return v
        end

        if info == v:SteamID() then
            return v
        end

        if tonumber(info) == v:SteamID64() then
            return v
        end

        if string.find(string.lower(v:Nick()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end
    end
    return nil
end
