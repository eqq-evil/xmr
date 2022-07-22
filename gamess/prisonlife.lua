--vars

shared.LoopKillAll = false
shared.LoopKillInmates = false
shared.LoopKillGuards = false
shared.LoopKillCriminals = false

--functions

local function GetPos()
    return game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end

local function GetCamPos()
    return workspace.CurrentCamera.CFrame
end

local function GetTeam()
    return game.Players.LocalPlayer.TeamColor.Name
end

local function GetPlayer(String)
    if not String then return end
    local Yes = {}
    for _, Player in ipairs(game.Players:GetPlayers()) do
        if string.lower(Player.Name):match(string.lower(String)) or string.lower(Player.DisplayName):match(string.lower(String)) then
            table.insert(Yes, Player)
        end
    end
    if #Yes > 0 then
        return Yes[1]
    elseif #Yes < 1 then
        return nil
    end
end

local function Kill(Player)
    pcall(function()
        if Player.Character:FindFirstChild("ForceField") or not workspace:FindFirstChild(Player.Name) or not workspace:FindFirstChild(Player.Name):FindFirstChild("Head") or Player == nil or Player.Character.Parent ~= workspace then return end
        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)

        local MyTeam = GetTeam()
        if Player.TeamColor.Name == game.Players.LocalPlayer.TeamColor.Name then
            local savedcf = GetPos()
            local savedcamcf = GetCamPos()
            workspace.Remote.loadchar:InvokeServer(nil, BrickColor.random().Name)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
            workspace.CurrentCamera.CFrame = savedcamcf
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
        end

        local Gun = game.Players.LocalPlayer.Character:FindFirstChild("Remington 870") or game.Players.LocalPlayer.Backpack:FindFirstChild("Remington 870")

        local FireEvent = {
            [1] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = workspace[Player.Name].Head
            }, [2] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = workspace[Player.Name].Head
            }, [3] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = workspace[Player.Name].Head
            }, [4] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = workspace[Player.Name].Head
            }, [5] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = workspace[Player.Name].Head
            }, [6] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = workspace[Player.Name].Head
            }, [7] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = workspace[Player.Name].Head
            }, [8] = {
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = workspace[Player.Name].Head
            }
        }

        game:GetService("ReplicatedStorage").ShootEvent:FireServer(FireEvent, Gun)
        Gun.Parent = game.Players.LocalPlayer.Character
        game.Players.LocalPlayer.Character["Remington 870"]:Destroy()
    end)
end


---lib


local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
    Name = "XMR",
    Size = UDim2.fromOffset(800, 600),
    Theme = Mercury.Themes.Serika,
    Link = "/xmr/"
}

local Tab = GUI:Tab{
	Name = "Kill"
}

local Tab1 = GUI:Tab{
	Name = "LocalPlayer"
}

local Tab2 = GUI:Tab{
	Name = "Credits"
}


--- killtab

Tab:Toggle{
	Name = "Loop Kill All",
	StartingState = false,
	Description = nil,
	Callback = function(state) shared.LoopKillAll = state end
}

Tab:Toggle{
	Name = "Loop Kill Guard",
	StartingState = false,
	Description = nil,
	Callback = function(state) shared.LoopKillGuards = state end
}

Tab:Toggle{
	Name = "Loop Kill Prisoners",
	StartingState = false,
	Description = nil,
	Callback = function(state) shared.LoopKillInmates = state end
}

Tab:Toggle{
	Name = "Loop Kill Criminals",
	StartingState = false,
	Description = nil,
	Callback = function(state) shared.LoopKillCriminals = state end
}

Tab:Textbox{
	Name = "Kill Player",
	Callback = function(text) 
        local Player = GetPlayer(text)
		if Player ~= nil then
            GUI:Notification{
                Title = "Alert",
                Text = "Killed Player "..Player.." successfully.",
                Duration = 3,
                Callback = function() end
            }
			Kill(Player)
		else
            GUI:Notification{
                Title = "Alert",
                Text = "Player Not Found",
                Duration = 3,
                Callback = function() end
            }
		end
    end
}

--- lp Tab

Tab1:Button{
	Name = "Team Netural",
	Description = nil,
	Callback = function() workspace.Remote.TeamEvent:FireServer("Medium stone grey") end
}

Tab1:Button{
	Name = "Team Guards",
	Description = nil,
	Callback = function() workspace.Remote.TeamEvent:FireServer("Bright blue") end
}

Tab1:Button{
	Name = "Team Innocent",
	Description = nil,
	Callback = function()  workspace.Remote.TeamEvent:FireServer("Bright orange") end
}

Tab1:Slider{
	Name = "WalkSpeed",
	Default = 16,
	Min = 0,
	Max = 250,
	Callback = function(v)  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end
}

Tab1:Slider{
	Name = "JumpPower",
	Default = 16,
	Min = 0,
	Max = 250,
	Callback = function(v)  game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end
}

---Loop


while true do
    wait(0.1)
    if shared.LoopKillAll == true then
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                Kill(v)
            end
        end
    end
    if shared.LoopKillInmates == true then
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                if v.TeamColor.Name == "Bright orange" then
                    Kill(v)
                end
            end
        end
    end
    if shared.LoopKillGuards == true then
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                if v.TeamColor.Name == "Bright blue" then
                    Kill(v)
                end
            end
        end
    end
    if shared.LoopKillCriminals == true then
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                if v.TeamColor.Name == "Bright blue" then
                    Kill(v)
                end
            end
        end
    end
end