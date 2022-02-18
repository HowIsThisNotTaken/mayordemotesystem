local function demotemenu()
	local mainContainerWidth, mainContainerHeight;

  	local mainContainer = vgui.Create( "DFrame" )
  	mainContainer:SetSize( 800, 300 )
  	mainContainer:SetTitle( "Mayor Demote Menu" )
  	mainContainer:SetVisible( true )
  	mainContainer:ShowCloseButton( true )
  	mainContainer:SetDraggable( true )
	mainContainer:Center()
  	mainContainer:MakePopup()
  	mainContainer.Paint = function(self, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
	end

    local playerList = mainContainer:Add("DListView")
    playerList:SetSize(300, 450)
    playerList:Dock(LEFT)
    playerList:AddColumn("Player")
    playerList:AddColumn("Job")
    for k, v in ipairs(player.GetAll()) do
        if v:isCP() then
            playerList:AddLine(v:Nick(), v:getDarkRPVar("job"))
        end
    end
    playerList:SetMultiSelect(false)
    playerList.OnRowSelected = function(panel, rowIndex, row)
        darkrpdemoted = row:GetColumnText(1)
    end

    local reasonfordemote = mainContainer:Add("DTextEntry")
    reasonfordemote:Dock(BOTTOM)
    reasonfordemote:SetSize(300, 200)
    reasonfordemote.OnEnter = function(self)
        darkrprdemotedreason = self:GetValue()
        RunConsoleCommand("rp_mayordemote", darkrpdemoted, darkrprdemotedreason)
        mainContainer:Close()
    end

    local reasonfordemotebutton = mainContainer:Add("DButton")
    reasonfordemotebutton:Dock(BOTTOM)
    reasonfordemotebutton:SetText("Submit Reason")
    reasonfordemotebutton.DoClick = function()
        RunConsoleCommand("rp_mayordemote", darkrpdemoted, darkrprdemotedreason)
        mainContainer:Close()
    end    
end

net.Receive("rp_MayorDemote", function(len, Player)
    demotemenu()
end)