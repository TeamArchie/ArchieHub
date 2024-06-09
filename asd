-- X: omg so cool, did you make this???!?!?!?!!
-- No (btw hello to who deobfuscated this)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Archie Hub",
    SubTitle = "Mad City",
    TabWidth = 110,
    Size = UDim2.fromOffset(580, 400),
    Acrylic = false,
    Theme = "Darker",
})

--TABS
local Tabs = {
    Main = Window:AddTab({ Title = "Home", Icon = "rbxassetid://14521909814" }),
    Player = Window:AddTab({ Title = "Local Player", Icon = "rbxassetid://14521917581" }),
    Auto = Window:AddTab({ Title = "Autofarm", Icon = "rbxassetid://14521921370" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "rbxassetid://14521927061" }),
    Mods = Window:AddTab({ Title = "Gun Mods", Icon = "rbxassetid://14551650573" }),
    Car = Window:AddTab({ Title = "Car Mods", Icon = "rbxassetid://14551587659" }),
    Tp = Window:AddTab({ Title = "Teleport", Icon = "rbxassetid://14521954270" }),
    Laser = Window:AddTab({ Title = "Laser", Icon = "rbxassetid://14521958159" }),
    detect = Window:AddTab({ Title = "Detection", Icon = "rbxassetid://14521962503" }),
    status = Window:AddTab({ Title = "Status", Icon = "rbxassetid://14521970339" }),
    Tcredits = Window:AddTab({ Title = "Credits", Icon = "rbxassetid://14522147372" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

--ALOT FUNCTIONS
local lesslag = {
    isallowedtorunspawnloadstring = true,
    isallowedtorunhumanoidloop    = true,
    isallowedtoruncarflip         = true,
    isallowedtorunspamhorn        = true,
    isallowedtorunboostspam       = true,
    isallowedtorunshiftspam       = true,
    isallowedtorunnoe             = true,
    isallowedtorunantitaze        = true,
    isallowedtorunsirenspam       = true,
    isallowedtorunresethitbox     = true,
    isallowedtorunrefreshesp      = true,
    isallowedtorunheistcheck      = true,
    isallowedtorunblackscreenproc = true
}
local Options = Fluent.Options
local goupspeed = 800;
local gountilspeed = 14000;
local godownspeed = 400;
local walkspeedsh = 40;
local speedofthefly = 4;
local speedofthevfly = 4;
local setuploops = 10;
local HeadSize = 20;
local currentversions = "Version 2.2"
local previousloop;
local TPFastMode = false;
local canceltp = false;
local autocarflip = false;
local override = false;
local stop = false;
local hornspam = false;
local notifyonupdate = false;
local autoleaveonmod = false;
local kickonupdate = true;
local boostspam = false;
local CrateESP = false;
local antitaze = false;
local updatesent = false;
local infjump = false;
local shiftspam = false;
local sirene = false;
local enabledfff = false;
local noeloop = false;
local infstamina = false;
local walkspeedcontrol = require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.WalkspeedController)
local ContextActionService = game:GetService("ContextActionService");
local mouse = game.Players.LocalPlayer:GetMouse();
local vim = game:GetService("VirtualInputManager");
local ca = require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.CharacterActions);
local para = require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.Parachute);
local u11 = require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.UIBinders.HeroStamina);
local AeroUtil = require(game:GetService("ReplicatedStorage").Aero.Shared.Util);
local rc = require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.RagdollClient);
function punch()
	ca.Punch();
end
function Teleport(x, y, z, waittime)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z);
	task.wait(waittime);
end
function Click(key, waittime, postwaittime)
	vim:SendKeyEvent(true, key, false, game);
	task.wait(waittime);
	vim:SendKeyEvent(false, key, false, game);
	task.wait(postwaittime);
end
function gethighestbounty(returner, noprint)
	bounties = {};
	noprint = noprint or false
	for i, v in pairs(game.Players:GetPlayers()) do
		if ((v.Team.Name == "Criminals") or (v.Team.Name == "Villains")) then
			table.insert(bounties, v.Bounty.Value);
		end
	end
	function compare(a, b)
		return a > b;
	end
	table.sort(bounties, compare);
	if bounties[returner] ~= nil then
		highest = bounties[returner];
	end
	local target
	for i, v in pairs(game.Players:GetPlayers()) do
		if ((v.Team.Name == "Criminals") or (v.Team.Name == "Villains")) then
			if (v.Bounty.Value == highest) then
				target = v;
			end
		end
	end
	if not noprint then
		print("target: ", game.Players[target.Name], "\nparent: ", game.Players[target.Name].Parent)
	end
	return game.Players[target.Name], highest;
end
ContextActionService:UnbindAction("MouseLockSwitchAction");
mouse.KeyDown:Connect(function(key2)
	if (key2 == "0") then
		stop = false;
		while true do
			if not stop then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeedsh;
			end
			wait();
		end
	end
end);
mouse.KeyUp:Connect(function(key2)
	if (key2 == "0") then
		stop = true;
	end
end);
function aboveplayer(player, ignorecrim)
	ignorecrim = ignorecrim or true
	character = player.Character;
	lp = game.Players.LocalPlayer.Character;
	if character ~= nil then
		humanoidRootPart = character:FindFirstChild("HumanoidRootPart");
		if humanoidRootPart then
			local raycastParams = RaycastParams.new();
			raycastParams.FilterType = Enum.RaycastFilterType.Blacklist;
			if not ignorecrim then
				raycastParams.FilterDescendantsInstances = {lp,character,workspace.Prison.Items.ProhibitedAreas,workspace.Ignore,workspace.Vehicles};
			else
				raycastParams.FilterDescendantsInstances = {lp,character,workspace.Prison.Items.ProhibitedAreas,workspace.Ignore,workspace.Vehicles, workspace.CriminalBase.Shields};
			end
			local raycastResult = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, 1000, 0), raycastParams);
			if raycastResult then
				for i, v in pairs(game.Players:GetPlayers()) do
					if v.Character then
						if raycastResult.Instance.Parent ~= k and raycastResult.Instance.Parent.Parent ~= nil then
                            return true
                        end
					end
				end
			else
				return false;
			end
		end
	end
end
function tp(x, y, z, speed)
    local targetPosition = Vector3.new(x, y, z)
    local speed = speed
    local maxForce = Vector3.new(math.huge, math.huge, math.huge)

    local velocity = Instance.new("BodyVelocity")
    velocity.MaxForce = maxForce
    velocity.Velocity = Vector3.new(0, 0, 0)
    velocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

    while true do
        if canceltp then
            canceltp = false;
            velocity:Destroy();
            break;
        end
        local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local direction = (targetPosition - currentPos).unit
        local distance = (targetPosition - currentPos).magnitude
        local distanceCheck = speed/30
        if distance >= distanceCheck then
            velocity.Velocity = direction * speed
        else
            velocity:Destroy()
            for i = 1, 20 do
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                task.wait()
            end
            break
        end
        wait()
    end
end
function cartp(x, y, z, speed)
	local targetPosition = Vector3.new(x, y, z);
	local maxForce = Vector3.new(math.huge, math.huge, math.huge);
	local velocity = Instance.new("BodyVelocity");
	velocity.MaxForce = maxForce;
	velocity.Velocity = Vector3.new(0, 0, 0);
	velocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart;
	while true do
		local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
		local direction = (targetPosition - currentPos).unit;
		local distance = (targetPosition - currentPos).magnitude;
		local distanceCheck = speed / 30;
		if (distance >= distanceCheck) then
			velocity.Velocity = direction * speed;
		else
			velocity:Destroy();
			for i = 1, 20 do
				if game.Players.LocalPlayer.Character.Humanoid.SeatPart then
					game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent:PivotTo(CFrame.new(x, y, z));
					game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0);
					task.wait();
				end
			end
			break;
		end
		wait();
	end
end
function waitforbutton()
	waitbuttontime = 0;
	repeat
		task.wait(0.01);
		waitbuttontime = waitbuttontime + 0.01;
	until game:GetService("Players").LocalPlayer.PlayerGui.Interactions:FindFirstChild("InteractionFrame") or (waitbuttontime > 5) 
	task.wait(0.1);
end
function InstaTeleport(x, y, z, roofcheck, overridespeedup, overridespeeduntil, overridespeeddown, overrideloops, ignorenotify)
	roofcheck = roofcheck or false
	local LPRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart;
	ignorenotify = ignorenotify or false
	local abovelp
	if roofcheck then
		abovelp = aboveplayer(game.Players.LocalPlayer, true)
	else
		abovelp = false
	end
	if not abovelp then
		if overridespeedup then
			tp(LPRootPart.CFrame.X, 1000, LPRootPart.CFrame.Z, overridespeedup, overrideloops);
			tp(x, 1000, z, overridespeeduntil, overrideloops);
			tp(x, y, z, overridespeeddown, overrideloops);
		else
			if TPFastMode then
				tp(LPRootPart.CFrame.X, 1000, LPRootPart.CFrame.Z, 1000000, setuploops);
				tp(x, 1000, z, 1000000, setuploops);
				tp(x, y, z, 1000000, setuploops);
			else
				tp(LPRootPart.CFrame.X, 1000, LPRootPart.CFrame.Z, goupspeed, setuploops);
				tp(x, 1000, z, gountilspeed, setuploops);
				tp(x, y, z, godownspeed, setuploops);
			end
		end
	else
		if not ignorenotify then
			Fluent:Notify({
                Title = "Error detected",
                Content = "You are under a roof!",
                SubContent = "", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
		end
		return "under a roof"
	end
end
sethiddenproperty(workspace.Terrain,"Decoration",false)
local functioname = "InputBegan";
local functionn;
for i, v in pairs(getgc()) do
	if (type(v) == "function") then
		if (getinfo(v).name == functioname) then
			functionn = v;
		end
	end
end
function setcooldown(cooldown)
	function tble(tbl)
		if (type(tbl) == "table") then
			for i, v in pairs(tbl) do
				if ((i == "Seconds") and (tbl.Seconds ~= cooldown)) then
					tbl.Seconds = cooldown;
				end
			end
		end
	end
	local i = 1;
	while true do
		if (i == #debug.getupvalues(functionn)) then
			break;
		end
		local name, value = debug.getupvalue(functionn, i);
		if not name then
			break;
		end
		tble(name);
		i = i + 1;
	end
end
function gethighestcash()
	cashtabl = {};
	for i, v in pairs(game.Players:GetPlayers()) do
		if v:FindFirstChild("Cash") then
			table.insert(cashtabl, v.Cash.Value);
		end
	end
	function compare(a, b)
		return a > b;
	end
	table.sort(cashtabl, compare);
	highest = cashtabl[1];
	target = nil;
	for i, v in pairs(game.Players:GetPlayers()) do
		if v:FindFirstChild("Cash") then
			if (v.Cash.Value == highest) then
				target = v.Name;
			end
		end
	end
	return target, highest;
end
function gethighestlevel()
	leveltabl = {};
	for i, v in pairs(game.Players:GetPlayers()) do
		if v:FindFirstChild("Level") then
			table.insert(leveltabl, v.Level.Value);
		end
	end
	function compare(a, b)
		return a > b;
	end
	table.sort(leveltabl, compare);
	highest = leveltabl[1];
	target = nil;
	for i, v in pairs(game.Players:GetPlayers()) do
		if v:FindFirstChild("Level") then
			if (v.Level.Value == highest) then
				target = v.Name;
			end
		end
	end
	return target, highest;
end
do
    Tabs.Main:AddSection("Main")
    local Toggle = Tabs.Main:AddToggle("noetogg", {Title = "No E Cooldown", Default = false })
    Toggle:OnChanged(function(Value)
        noeloop = Value
    end)
    local servdr = Tabs.Main:AddDropdown("Dropdown", {
        Title = "Serverhop",
        Values = {"None", "Big Server (More Players)", "Small Server (Less Players)"},
        Multi = false,
        Default = 1,
    })

    servdr:OnChanged(function(Value)
        if (Value == "Large Server (More Players)") then
            ServerHopType = "Desc";
            serverhop = true;
        elseif (Value == "Small Server (Less Players)") then
            ServerHopType = "Asc";
            serverhop = true;
        else
            serverhop = false;
        end
        if serverhop then
            local Player = game.Players.LocalPlayer;
            local Http = game:GetService("HttpService");
            local TPS = game:GetService("TeleportService");
            local Api = "https://games.roblox.com/v1/games/";
            local _place, _id = game.PlaceId, game.JobId;
            local _servers = Api .. _place .. "/servers/Public?sortOrder=" .. ServerHopType .. "&limit=10";
            function ListServers(cursor)
                local Raw = game:HttpGet(_servers .. ((cursor and ("&cursor=" .. cursor)) or ""));
                return Http:JSONDecode(Raw);
            end
            time_to_wait = 0.2;
            while wait(time_to_wait) do
                Player.Character.HumanoidRootPart.Anchored = true;
                local Servers = ListServers();
                local Server = Servers.data[math.random(1, #Servers.data)];
                TPS:TeleportToPlaceInstance(_place, Server.id, Player);
            end
        end
    end)
    Tabs.Main:AddButton({
        Title = "Redeem all X Codes",
        Description = "Redeems all existing X (Aka Twitter) Codes",
        Callback = function()
            local cashbeforeredeem = game.Players.LocalPlayer.Cash.Value
            local codes = {
                "ItsFriday!",
                "Frosty",
                "Jaiker",
                "Degree",
                "CeeJay",
                "Conlord",
                "SUSHY",
                "ZDMD",
                "NewCode250K",
                "cash500"
            }
            for i, code in pairs(codes) do
                game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer("RedeemCode", code)
            end
            task.wait(0.3)
            local newcash = game.Players.LocalPlayer.Cash.Value
            if oldcash == newcash then
                Fluent:Notify({
                    Title = "Archie Hub",
                    Content = "All Codes redeemed!",
                    SubContent = "", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            else
                Fluent:Notify({
                    Title = "Archie",
                    Content = "All Codes already redeemed!",
                    SubContent = "", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
        end
    })
    Tabs.Main:AddButton({
        Title = "Auto Hack PC",
        Description = "Auto complete Computer Task",
        Callback = function()
            Fluent:Notify({
                Title = "Hack Computer",
                Content = "Stand in Front of a Computer!",
                SubContent = "", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
            pa = game.Players.LocalPlayer.PlayerGui["All-UIGames"].MainShroud.PlayArea;
            waitforbutton();
            setcooldown(0.001);
            Click(Enum.KeyCode.E, 0.1);
            task.wait(1);
            Click(Enum.KeyCode.Space, 0.1);
            task.wait(1);
            local success1;
            local success2;
            local success3;
            local success4;
            local success5;
            if pa:FindFirstChild("LineBounce") then
                lb = pa.LineBounce;
                while task.wait() do
                    cursor = lb:WaitForChild("Inner"):WaitForChild("1"):WaitForChild("Cursor");
                    goodline = lb:WaitForChild("Inner"):WaitForChild("1"):WaitForChild("GoodLine");
                    cursorPosition = cursor.AbsolutePosition;
                    cursorSize = cursor.AbsoluteSize;
                    goodlinePosition = goodline.AbsolutePosition;
                    goodlineSize = goodline.AbsoluteSize;
                    isCursorInArea = ((cursorPosition.X + cursorSize.X) >= goodlinePosition.X) and (cursorPosition.X <= (goodlinePosition.X + goodlineSize.X)) and ((cursorPosition.Y + cursorSize.Y) >= goodlinePosition.Y) and (cursorPosition.Y <= (goodlinePosition.Y + goodlineSize.Y));
                    if isCursorInArea then
                        task.wait(0.05);
                        Click("Space", 0.1, 0.1);
                        success1 = true;
                        break;
                    end
                end
                while task.wait() do
                    cursor = lb:WaitForChild("Inner"):WaitForChild("2"):WaitForChild("Cursor");
                    goodline = lb:WaitForChild("Inner"):WaitForChild("2"):WaitForChild("GoodLine");
                    cursorPosition = cursor.AbsolutePosition;
                    cursorSize = cursor.AbsoluteSize;
                    goodlinePosition = goodline.AbsolutePosition;
                    goodlineSize = goodline.AbsoluteSize;
                    isCursorInArea = ((cursorPosition.X + cursorSize.X) >= goodlinePosition.X) and (cursorPosition.X <= (goodlinePosition.X + goodlineSize.X)) and ((cursorPosition.Y + cursorSize.Y) >= goodlinePosition.Y) and (cursorPosition.Y <= (goodlinePosition.Y + goodlineSize.Y));
                    if isCursorInArea then
                        task.wait(0.05);
                        Click("Space", 0.1, 0.1);
                        success2 = true;
                        break;
                    end
                end
                while task.wait() do
                    cursor = lb:WaitForChild("Inner"):WaitForChild("3"):WaitForChild("Cursor");
                    goodline = lb:WaitForChild("Inner"):WaitForChild("3"):WaitForChild("GoodLine");
                    cursorPosition = cursor.AbsolutePosition;
                    cursorSize = cursor.AbsoluteSize;
                    goodlinePosition = goodline.AbsolutePosition;
                    goodlineSize = goodline.AbsoluteSize;
                    isCursorInArea = ((cursorPosition.X + cursorSize.X) >= goodlinePosition.X) and (cursorPosition.X <= (goodlinePosition.X + goodlineSize.X)) and ((cursorPosition.Y + cursorSize.Y) >= goodlinePosition.Y) and (cursorPosition.Y <= (goodlinePosition.Y + goodlineSize.Y));
                    if isCursorInArea then
                        task.wait(0.05);
                        Click("Space", 0.1, 0.1);
                        success3 = true;
                        break;
                    end
                end
                while task.wait() do
                    cursor = lb:WaitForChild("Inner"):WaitForChild("4"):WaitForChild("Cursor");
                    goodline = lb:WaitForChild("Inner"):WaitForChild("4"):WaitForChild("GoodLine");
                    cursorPosition = cursor.AbsolutePosition;
                    cursorSize = cursor.AbsoluteSize;
                    goodlinePosition = goodline.AbsolutePosition;
                    goodlineSize = goodline.AbsoluteSize;
                    isCursorInArea = ((cursorPosition.X + cursorSize.X) >= goodlinePosition.X) and (cursorPosition.X <= (goodlinePosition.X + goodlineSize.X)) and ((cursorPosition.Y + cursorSize.Y) >= goodlinePosition.Y) and (cursorPosition.Y <= (goodlinePosition.Y + goodlineSize.Y));
                    if isCursorInArea then
                        task.wait(0.05);
                        Click("Space", 0.1, 0.1);
                        success4 = true;
                        break;
                    end
                end
                while task.wait() do
                    cursor = lb:WaitForChild("Inner"):WaitForChild("5"):WaitForChild("Cursor");
                    goodline = lb:WaitForChild("Inner"):WaitForChild("5"):WaitForChild("GoodLine");
                    cursorPosition = cursor.AbsolutePosition;
                    cursorSize = cursor.AbsoluteSize;
                    goodlinePosition = goodline.AbsolutePosition;
                    goodlineSize = goodline.AbsoluteSize;
                    isCursorInArea = ((cursorPosition.X + cursorSize.X) >= goodlinePosition.X) and (cursorPosition.X <= (goodlinePosition.X + goodlineSize.X)) and ((cursorPosition.Y + cursorSize.Y) >= goodlinePosition.Y) and (cursorPosition.Y <= (goodlinePosition.Y + goodlineSize.Y));
                    if isCursorInArea then
                        task.wait(0.05);
                        Click("Space", 0.1, 0.1);
                        success5 = true;
                        break;
                    end
                end
                if (success1 and success2 and success3 and success4 and success5) then
                    Fluent:Notify({
                        Title = "Archie hub",
                        Content = "Successfully hacked Computer!",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    });
                else
                    Fluent:Notify({
                        Title = "Archie hub",
                        Content = "Failed to hack Computer!",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    });
                end
            end
        end
    })
    Tabs.Main:AddButton({
        Title = "Anti Afk",
        Description = "Prevents you from being kicked by being Afk",
        Callback = function()
            for i, v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
                v:Disable();
            end
        end
    })

    Tabs.Main:AddButton({
        Title = "Unlock All Emotes",
        Description = "",
        Callback = function()
            Fluent:Notify({
                Title = "Archie Hub",
                Content = "Successfully recived all Emotes!",
                SubContent = "Open phone and go to emotes", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
            for i, v in next, getgc(true) do
                if type(v) == "table" and rawget(v, "Orange Justice") and rawget(v, "Twist") and rawget(v, "Jaywalk") then
                    for k, j in pairs(v) do
                        if type(j) == "table" and rawget(j, "AnimationId") then
                            for h, g in pairs(j) do
                                if h == "GamePass" or h == "Item" then
                                    j[h] = "Default"
                                    rawset(j, "Default", true)
                                end
                            end
                        end
                    end
                end
            end
        end
    })
    Tabs.Main:AddButton({
        Title = "Reset Character",
        Description = "",
        Callback = function()
            game.Players.LocalPlayer.Character.Humanoid.Health = 0;
	        game.Players.LocalPlayer.Character.Head:Destroy();
        end
    })
    Tabs.Main:AddButton({
        Title = "Unlock FOV",
        Description = "",
        Callback = function()
            local runService = game:GetService("RunService");
            local camera = workspace.Camera;
            local fov = 110;
            runService.RenderStepped:Connect(function()
                camera.FieldOfView = fov;
                if (fov >= 120) then
                    local dv = (1.7320508075688767 * ((camera.ViewportSize.Y / 2) / math.tan(math.rad(fov / 2)))) / (camera.ViewportSize.Y / 2);
                    camera.CFrame = camera.CFrame * CFrame.new(0, 0, 0, dv, 0, 0, 0, dv, 0, 0, 0, 1);
                end
            end);
        end
    })
    Tabs.Main:AddButton({
        Title = "ForceField Body",
        Description = "Makes your Character shine",
        Callback = function()
            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if (v:IsA("MeshPart") or v:IsA("Part")) then
                    v.Material = Enum.Material.ForceField;
                end
            end
        end
    })

    Tabs.Main:AddSection("Team Change")
    Tabs.Main:AddButton({
        Title = "Change to Prisoner",
        Description = "",
        Callback = function()
            require(game:GetService("ReplicatedStorage").Aero.Shared.Util).Network:Invoke("RequestTeamChange", "Prisoners");
        end
    })
    Tabs.Main:AddButton({
        Title = "Change to Police",
        Description = "",
        Callback = function()
            require(game:GetService("ReplicatedStorage").Aero.Shared.Util).Network:Invoke("RequestTeamChange", "Police");
        end
    })

    Tabs.Main:AddButton({
        Title = "Change to Heroes",
        Description = "",
        Callback = function()
            require(game:GetService("ReplicatedStorage").Aero.Shared.Util).Network:Invoke("RequestTeamChange", "Heroes");
        end
    })

    Tabs.Player:AddSection("Aim & Other")
    
    local hitboxexpander = Tabs.Player:AddKeybind("Keybind", {
        Title = "Toggle Hitbox Expander",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "X", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            enabledfff = Value;
            if enabledfff == false then
                pcall(function()
                    for i, v in pairs(game.Players:GetPlayers()) do
                        v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1);
                        v.Character.HumanoidRootPart.Transparency = 1;
                        v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Medium stone grey");
                        v.Character.HumanoidRootPart.Material = "Plastic";
                        v.Character.HumanoidRootPart.CanCollide = false;
                    end
                end);
            end
        end,
    })

    local hitboxsize = Tabs.Player:AddSlider("hitboxsizeslider", {
        Title = "Hitbox Size",
        Description = "Changes Hitbox Size of Players",
        Default = 10,
        Min = 0,
        Max = 35,
        Rounding = 0.1,
        Callback = function(Value)
            HeadSize = Value;
        end
    })

    Tabs.Main:AddButton({
        Title = "Disable Glider Deploy",
        Description = "",
        Callback = function()
            local c = require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.Parachute)
            c.ControlStart = function(_)
                --
            end
        end
    })
    local infstaminatoggle = Tabs.Player:AddToggle("infstamina", {Title = "Infinite Hero Stamina", Default = false })
    infstaminatoggle:OnChanged(function(Value)
        infstamina = Value
    end)

    local antitazetoggle = Tabs.Player:AddToggle("antitaze", {Title = "Anti Taze", Default = false })
    antitazetoggle:OnChanged(function(Value)
        antitaze = Value
    end)
    Tabs.Player:AddSection("Local Player")
    local flykeybind = Tabs.Player:AddKeybind("Keybind", {
        Title = "Toggle Fly",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "F", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            uis = game:GetService("UserInputService");
            local cmdp = game:GetService("Players");
            local cmdlp = cmdp.LocalPlayer;
            local player = cmdlp;
            local cmdl = game:GetService("Lighting");
            local cmdrs = game:GetService("ReplicatedStorage");
            local cmdrs2 = game:GetService("RunService");
            local cmdts = game:GetService("TweenService");
            local cmdvu = game:GetService("VirtualUser");
            local cmduis = game:GetService("UserInputService");
            local Mouses = cmdlp:GetMouse();
            cmdm = Mouses;
            FLYING = not FLYING;
            while not cmdlp or not cmdlp.Character or not cmdlp.Character:FindFirstChild("HumanoidRootPart") or not cmdlp.Character:FindFirstChild("Humanoid") or not cmdm do
                task.wait();
            end
            local T = cmdlp.Character.HumanoidRootPart;
            local CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0};
            local lCONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0};
            local SPEED = 0;
            function FLY()
                local BG = Instance.new("BodyGyro", T);
                local BV = Instance.new("BodyVelocity", T);
                BG.P = 90000;
                BG.maxTorque = Vector3.new(8999999488, 8999999488, 8999999488);
                BG.cframe = T.CFrame;
                BV.velocity = Vector3.new(0, 0, 0);
                BV.maxForce = Vector3.new(8999999488, 8999999488, 8999999488);
                task.spawn(function()
                    while FLYING do
                        if (((CONTROL.L + CONTROL.R) ~= 0) or ((CONTROL.F + CONTROL.B) ~= 0) or ((CONTROL.Q + CONTROL.E) ~= 0)) then
                            SPEED = 50;
                        elseif (not (((CONTROL.L + CONTROL.R) ~= 0) or ((CONTROL.F + CONTROL.B) ~= 0) or ((CONTROL.Q + CONTROL.E) ~= 0)) and (SPEED ~= 0)) then
                            SPEED = 0;
                        end
                        if (((CONTROL.L + CONTROL.R) ~= 0) or ((CONTROL.F + CONTROL.B) ~= 0) or ((CONTROL.Q + CONTROL.E) ~= 0)) then
                            BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED;
                            lCONTROL = {F=CONTROL.F,B=CONTROL.B,L=CONTROL.L,R=CONTROL.R};
                        elseif (((CONTROL.L + CONTROL.R) == 0) and ((CONTROL.F + CONTROL.B) == 0) and ((CONTROL.Q + CONTROL.E) == 0) and (SPEED ~= 0)) then
                            BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED;
                        else
                            BV.velocity = Vector3.new(0, 0, 0);
                        end
                        BG.cframe = workspace.CurrentCamera.CoordinateFrame;
                        task.wait();
                    end
                    CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0};
                    lCONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0};
                    SPEED = 0;
                    BG:destroy();
                    BV:destroy();
                    cmdlp.Character.Humanoid.PlatformStand = false;
                end);
            end
            cmdm.KeyDown:connect(function(KEY)
                if (KEY:lower() == "w") then
                    if require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.ClientVehicle).InsideVehicle then
                        CONTROL.F = speedofthevfly;
                    else
                        CONTROL.F = speedofthefly;
                    end
                elseif (KEY:lower() == "s") then
                    if require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.ClientVehicle).InsideVehicle then
                        CONTROL.B = -speedofthevfly;
                    else
                        CONTROL.B = -speedofthefly;
                    end
                elseif (KEY:lower() == "a") then
                    if require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.ClientVehicle).InsideVehicle then
                        CONTROL.L = -speedofthevfly;
                    else
                        CONTROL.L = -speedofthefly;
                    end
                elseif (KEY:lower() == "d") then
                    if require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.ClientVehicle).InsideVehicle then
                        CONTROL.R = speedofthevfly;
                    else
                        CONTROL.R = speedofthefly;
                    end
                elseif (KEY:lower() == "y") then
                    if require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.ClientVehicle).InsideVehicle then
                        CONTROL.Q = speedofthevfly * 2;
                    else
                        CONTROL.Q = speedofthefly * 2;
                    end
                elseif (KEY:lower() == "t") then
                    if require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.ClientVehicle).InsideVehicle then
                        CONTROL.E = -speedofthevfly * 2;
                    else
                        CONTROL.E = -speedofthefly * 2;
                    end
                end
            end);
            cmdm.KeyUp:connect(function(KEY)
                if (KEY:lower() == "w") then
                    CONTROL.F = 0;
                elseif (KEY:lower() == "s") then
                    CONTROL.B = 0;
                elseif (KEY:lower() == "a") then
                    CONTROL.L = 0;
                elseif (KEY:lower() == "d") then
                    CONTROL.R = 0;
                elseif (KEY:lower() == "y") then
                    CONTROL.Q = 0;
                elseif (KEY:lower() == "t") then
                    CONTROL.E = 0;
                end
            end);
            FLY();
        end,
    })
    local playerflyspeed = Tabs.Player:AddSlider("flyspeedslider", {
        Title = "Player Flyspeed",
        Description = "",
        Default = 5,
        Min = 0,
        Max = 50,
        Rounding = 0.1,
        Callback = function(Value)
            speedofthefly = Value
        end
    })
    local vehicleflyspeedslider = Tabs.Player:AddSlider("vflyspeedslider", {
        Title = "Vehicle Flyspeed",
        Description = "",
        Default = 1,
        Min = 0,
        Max = 20,
        Rounding = 0.1,
        Callback = function(Value)
            speedofthevfly = Value
        end
    })
    local walkspeedslider = Tabs.Player:AddSlider("walkspeedslider", {
        Title = "Walkspeed",
        Description = "",
        Default = 16,
        Min = 16,
        Max = 500,
        Rounding = 0.1,
        Callback = function(Value)
            walkspeedcontrol.CurrentWalkspeed = Value
        end
    })
    local shiftwalkspeedslider = Tabs.Player:AddSlider("shiftwalkspeedslider", {
        Title = "Shift Walkspeed",
        Description = "",
        Default = 24,
        Min = 24,
        Max = 500,
        Rounding = 0.1,
        Callback = function(Value)
            walkspeedsh = Value
        end
    })
    local hipheightslider = Tabs.Player:AddSlider("hipheightslider", {
        Title = "Hipheight",
        Description = "",
        Default = 2,
        Min = 2,
        Max = 100,
        Rounding = 0.1,
        Callback = function(Value)
            game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight = Value;
        end
    })
    local infjumptoggle = Tabs.Player:AddToggle("infjum", {Title = "Infinite Jump", Default = false })
    infjumptoggle:OnChanged(function(Value)
        infjump = Value
    end)
    local autosprinttoggle = Tabs.Player:AddToggle("autosprint", {Title = "Auto Sprint", Default = false })
    autosprinttoggle:OnChanged(function(Value)
        shiftspam = Value
    end)

    Tabs.Auto:AddSection("Auto Arrest")
    local autoarresttextbox = Tabs.Auto:AddInput("arrestplayer", {
        Title = "Arrest Player",
        Default = "Username",
        Placeholder = "put username or displayname here",
        Numeric = false, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(playername)
            oldloopvalue = noeloop
            oldfastvalue = TPFastMode
            noeloop = true
            TPFastMode = true
            if game.Players.LocalPlayer.Team.Name == "Police" then
                if aboveplayer(game.Players.LocalPlayer, false) == false then
                    Fluent:Notify({
                        Title = "Archie Hub",
                        Content = "Starting.",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    })
                    for i, v in pairs(game.Players:GetPlayers()) do
                        if string.find(v.Name:lower(), playername:lower()) or string.find(v.DisplayName:lower(), playername:lower()) then
                            if v.Team.Name == "Criminals" or v.Team.Name == "Villains" then
                                target = v
                                if aboveplayer(target, false) == false then
                                    InstaTeleport(target.Character.HumanoidRootPart.Position.x, target.Character.HumanoidRootPart.Position.y + 5, target.Character.HumanoidRootPart.Position.z, true)
                                    while task.wait() do
                                        if aboveplayer(target, false) == false then
                                            if aboveplayer(game.Players.LocalPlayer, false) == false then
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(target.Character.HumanoidRootPart.Position.x, target.Character.HumanoidRootPart.Position.y + 2, target.Character.HumanoidRootPart.Position.z)
                                                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                                spawn(function()
                                                    Click("E", 0.01, 0)
                                                end)
                                            else
                                                Fluent:Notify({
                                                    Title = "Archie Hub",
                                                    Content = "Target is under a Roof!",
                                                    SubContent = "", -- Optional
                                                    Duration = 5 -- Set to nil to make the notification not disappear
                                                })
                                                break
                                            end
                                        else
                                            Fluent:Notify({
                                                Title = "Archie Hub",
                                                Content = "Target is under a Roof!",
                                                SubContent = "", -- Optional
                                                Duration = 5 -- Set to nil to make the notification not disappear
                                            })
                                            break
                                        end
                                    end
                                else
                                    Fluent:Notify({
                                        Title = "Archie Hub",
                                        Content = "Target is under a Roof!",
                                        SubContent = "", -- Optional
                                        Duration = 5 -- Set to nil to make the notification not disappear
                                    })
                                end
                            else
                                Fluent:Notify({
                                    Title = "Archie Hub",
                                    Content = "Target is not a Criminal or Villain!",
                                    SubContent = "", -- Optional
                                    Duration = 5 -- Set to nil to make the notification not disappear
                                })
                            end
                        end
                    end
                else
                    Fluent:Notify({
                        Title = "Archie Hub",
                        Content = "You are under a Roof!",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    })
                end
            else
                Fluent:Notify({
                    Title = "Archie Hub",
                    Content = "You are not in the Police Team!",
                    SubContent = "", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
            Fluent:Notify({
                Title = "Archie Hub",
                Content = "Done!",
                SubContent = "", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
            noeloop = oldloopvalue
            TPFastMode = oldfastvalue
        end
    })
    Tabs.Auto:AddButton({
        Title = "Auto Arrest",
        Description = "Arrests every Criminal",
        Callback = function()
            if game.Players.LocalPlayer.Team.Name == "Police" then
                Fluent:Notify({
                    Title = "Archie Hub",
                    Content = "Starting!",
                    SubContent = "", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
                previousloop = noeloop;
                noeloop = true
                if aboveplayer(game.Players.LocalPlayer, false) == false then
                    for i = 1, 32 do
                        if aboveplayer(game.Players.LocalPlayer, false) == false then
                            print("targetting index of : ", i)
                            game.Players.LocalPlayer.Character.Humanoid.Sit = false
                            task.wait(0.3)
                            p, highstf = gethighestbounty(1, true)
                            if highstf ~= 0 then
                                target = gethighestbounty(i, true);
                                if aboveplayer(target, false) == false then
                                    local iiiii = target
                                    local pppppp = target.Character
                                    oldgr = workspace.Gravity
                                    workspace.Gravity = -2147483647
                                    InstaTeleport(pppppp.HumanoidRootPart.Position.x, pppppp.HumanoidRootPart.Position.y + 5, pppppp.HumanoidRootPart.Position.z, true, 1000000, 1000000, 1000000, 10, true)
                                    workspace.Gravity = oldgr
                                    while task.wait() do
                                        if aboveplayer(iiiii, false) == false then
                                            if aboveplayer(game.Players.LocalPlayer, false) == false then
                                                if game.Players.LocalPlayer.PlayerGui["All-RestrictedArea"].Enabled == false then
                                                    if pppppp:FindFirstChild("HumanoidRootPart") then
                                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pppppp.HumanoidRootPart.Position.x, pppppp.HumanoidRootPart.Position.y + 2, pppppp.HumanoidRootPart.Position.z)
                                                    end
                                                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuffs") then
                                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Handcuffs)
                                                    end
                                                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                                    spawn(function()
                                                        setcooldown(0.001)
                                                        Click("E", 0.01, 0)
                                                        print("pressed e")
                                                    end)
                                                else
                                                    Fluent:Notify({
                                                        Title = "Archie Hub",
                                                        Content = "Please wait, fixing position...",
                                                        SubContent = "", -- Optional
                                                        Duration = 10 -- Set to nil to make the notification not disappear
                                                    })
                                                    InstaTeleport(-72.02271270751953, 59.87224578857422, 2188.5439453125, false, 1000, 1000, 1000, 10, true)
                                                    task.wait(2)
                                                    Fluent:Notify({
                                                        Title = "Archie Hub",
                                                        Content = "Continuing",
                                                        SubContent = "", -- Optional
                                                        Duration = 5 -- Set to nil to make the notification not disappear
                                                    })
                                                    break
                                                end
                                            else
                                                Fluent:Notify({
                                                    Title = "Archie Hub",
                                                    Content = "You are under a Roof!",
                                                    SubContent = "", -- Optional
                                                    Duration = 5 -- Set to nil to make the notification not disappear
                                                })
                                                break
                                            end
                                        else
                                            Fluent:Notify({
                                                Title = "Archie Hub",
                                                Content = "Target is under a Roof!",
                                                SubContent = "", -- Optional
                                                Duration = 5 -- Set to nil to make the notification not disappear
                                            })
                                            break
                                        end
                                    end
                                end
                            else
                                Fluent:Notify({
                                    Title = "Archie Hub",
                                    Content = "The highest bounty is 0, stopped.",
                                    SubContent = "", -- Optional
                                    Duration = 5 -- Set to nil to make the notification not disappear
                                })
                                break
                            end
                        else
                            break
                        end
                    end
                else
                    Fluent:Notify({
                        Title = "Archie Hub",
                        Content = "You are under a Roof!",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    })
                end
            else
                Fluent:Notify({
                    Title = "Archie Hub",
                    Content = "You are not in the Police Team!",
                    SubContent = "", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
            Fluent:Notify({
                Title = "Archie Hub",
                Content = "Done!",
                SubContent = "", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
            noeloop = previousloop;
        end
    })

    Tabs.Auto:AddSection("Autorob Heist")
    Tabs.Auto:AddButton({
        Title = "Rob Club",
        Description = "",
        Callback = function()
            local TeleportService = game:GetService('TeleportService')
            local vim = game:GetService('VirtualInputManager')
            local u1 = require(game:GetService("ReplicatedStorage").Aero.Shared.Util)
            
            --TELEPORT & OTHER SETTINGS
            function Teleport(x,y,z,cd)
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
                task.wait(cd)
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
            function FastTeleport(x, y, z, speed)
                local targetPosition = Vector3.new(x, y, z)
                local speed = speed
                local maxForce = Vector3.new(math.huge, math.huge, math.huge)
            
                local velocity = Instance.new("BodyVelocity")
                velocity.MaxForce = maxForce
                velocity.Velocity = Vector3.new(0, 0, 0)
                velocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            
                while true do
                    local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    local direction = (targetPosition - currentPos).unit
                    local distance = (targetPosition - currentPos).magnitude
                    local distanceCheck = speed/30
                    if distance >= distanceCheck then
                        velocity.Velocity = direction * speed
                    else
                        velocity:Destroy()
                        for i = 1, 20 do
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            task.wait()
                        end
                        break
                    end
                    wait()
                end
            end
            function InstaTeleport(x, y, z)
                local LPRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
                FastTeleport(LPRootPart.CFrame.X, 1000, LPRootPart.CFrame.Z, 10000)
                FastTeleport(x, 1000, z, 10000)
                FastTeleport(x, y, z, 10000)
            end
            
            --AUTOROB CLUB
            para.CanStart = false
            InstaTeleport(1699.2288818359375, 73, -1244.564208984375)
            FastTeleport(1699.2288818359375, 234, -1244.564208984375)
            FastTeleport(1765.9652099609375, 228.81240844726562, -1224.5908203125, 800)
            FastTeleport(1813.0618896484375, 225.31044006347656, -1189.448486328125, 800)
            collectroom = game.Workspace.Heists.Club.Items.CollectArea
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1795.28,192.62,-1196.98)
            task.wait(0.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(collectroom.Position.x, 192.82, collectroom.Position.z)
            task.wait(0.4)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1818, 228, -1163)
            task.wait(4)
            dh = game.Players.LocalPlayer.PlayerGui:FindFirstChild("All-InBackpackDisplayHolder")
            if dh and dh.enabled then
                while game.Players.LocalPlayer.PlayerGui["All-InBackpackDisplayHolder"].MainHolder.Numerator.Text ~= game.Players.LocalPlayer.PlayerGui["All-InBackpackDisplayHolder"].MainHolder.Denominator.Text do
                    task.wait()
                end
            else
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1818, 228, -1163)
            task.wait(0.3)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(collectroom.Position.x, 192.82, collectroom.Position.z)
            task.wait(0.3)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1795.28,192.62,-1196.98)
            task.wait(0.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1780, 229.5, -1224.94)
            task.wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1763, 230, -1223)
            task.wait(0.3)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1752, 230, -1225)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1689, 232, -1237)
            FastTeleport(1716.18994140625, 229, -1227.63330078125, 500)
            InstaTeleport(148.93096923828125, 25.497514724731445, -218.92588806152344)
            FastTeleport(86.77104187011719, 25.243732452392578, -148.37075805664062, 40)
            task.wait(3)
            FastTeleport(150.64869689941406, 25.24077033996582, -185.33978271484375, 500)
        end
    })
    Tabs.Auto:AddButton({
        Title = "Rob Pyramid",
        Description = "",
        Callback = function()
            function spawncarandenter()
                local ohString1 = "UI";
                local ohString2 = "SpawnCar";
                local ohString3 = "Camaro";
                game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer(ohString1, ohString2, ohString3);
                waitforbutton();
                Click(Enum.KeyCode.E, 0.1, 0.1);
            end
            function level1noclip()
                repeat
                    task.wait();
                until game.Players.LocalPlayer.Character.Humanoid.SeatPart 
                p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent;
                for i = 1, 15 do
                    cartp(88.85484313964844, -79.82974243164062, -1238.4161376953125, 1000);
                    task.wait();
                end
            end
            function level2noclip()
                repeat
                    task.wait();
                until game.Players.LocalPlayer.Character.Humanoid.SeatPart 
                p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent;
                for i = 1, 15 do
                    cartp(-414.371337890625, -14.801307678222656, -1030.228515625, 1000);
                    task.wait();
                end
            end
            function level1()
                InstaTeleport(89.17739868164062, 40, -1232.9056396484375, true);
                task.wait(0.2);
                spawncarandenter();
                level1noclip();
                task.wait(1.5);
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y < 10) then
                    if game.Players.LocalPlayer.Character.Humanoid.SeatPart then
                        Click(Enum.KeyCode.Space, 0.1);
                    end
                    repeat
                        task.wait();
                    until not game.Players.LocalPlayer.Character.Humanoid.SeatPart 
                    tp(85.86502075195312, -53.65530776977539, -1231.7755126953125, 100);
                    tp(106.09539031982422, -98.5, -1226.3026123046875, 100);
                    waitforbutton();
                    setcooldown(0.001);
                    for i = 1, 20 do
                        Click(Enum.KeyCode.E, 0.001);
                    end
                    Teleport(109.74970245361328, -95.61529541015625, -1234.8094482421875, 0.1);
                    waitforbutton();
                    setcooldown(0.001);
                    for i = 1, 20 do
                        Click(Enum.KeyCode.E, 0.001);
                    end
                    task.wait(0.5);
                    Teleport(150.60116577148438, -51.386962890625, -1190.2261962890625, 0.2);
                    noclipped2 = true;
                    task.wait(0.1);
                    game.Players.LocalPlayer.PlayerGui.BlackScreenGui.Enabled = false;
                    InstaTeleport(150.25677490234375, 25.506908416748047, -217.7570343017578, false);
                    tp(84.41801452636719, 25.25277328491211, -151.80941772460938, 50);
                else
                    level1();
                end
            end
            function level2()
                InstaTeleport(-397, 60, -1040, true);
                task.wait(0.2);
                spawncarandenter();
                level2noclip();
                task.wait(1.5);
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y < 10) then
                    if game.Players.LocalPlayer.Character.Humanoid.SeatPart then
                        Click(Enum.KeyCode.Space, 0.1);
                    end
                    repeat
                        task.wait();
                    until not game.Players.LocalPlayer.Character.Humanoid.SeatPart 
                    tp(-414, -33, -1033, 100);
                    tp(-366, -48.5, -958, 100);
                    waitforbutton();
                    setcooldown(0.001);
                    for i = 1, 20 do
                        Click(Enum.KeyCode.E, 0.001);
                    end
                    Teleport(-360.11102294921875, -46.967933654785156, -950.0228271484375, 0.1);
                    waitforbutton();
                    setcooldown(0.001);
                    for i = 1, 20 do
                        Click(Enum.KeyCode.E, 0.001);
                    end
                    task.wait(0.5);
                    Teleport(-419.15, -2, -938.2, 0.2);
                    noclipped2 = true;
                    task.wait(0.1);
                    game.Players.LocalPlayer.PlayerGui.BlackScreenGui.Enabled = false;
                    InstaTeleport(150.25677490234375, 25.506908416748047, -217.7570343017578, false);
                    tp(84.41801452636719, 25.25277328491211, -151.80941772460938, 50);
                else
                    level2();
                end
            end
            if workspace.Heists.Pyramid:FindFirstChild("Level1") then
                above = aboveplayer(game.Players.LocalPlayer.Name, true)
                if not above then
                noclipped2 = false;
                override2 = false;
                if game.Players.LocalPlayer.PlayerGui:FindFirstChild("BlackScreenGui") then
                    bsc = game.Players.LocalPlayer.PlayerGui.BlackScreenGui;
                    bsc.Enabled = true;
                    bsc.BlackFrame.Style = Enum.FrameStyle.RobloxRound;
                    task.wait(0.1);
                    bsc.BlackFrame.Style = Enum.FrameStyle.Custom;
                else
                    spawn(function()
                        game.Players.LocalPlayer:Kick("screengui not found")
                    end)
                    task.wait(0.4)
                    while true do end
                end
                spawn(function()
                    if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("BlackScreenGui") then
                        spawn(function()
                            game.Players.LocalPlayer:Kick("screengui not found")
                        end)
                        task.wait(0.4)
                        while true do end
                    end
                    spawn(function()
                        game.Players.LocalPlayer.PlayerGui.BlackScreenGui.Changed:Connect(function(property)
                            if not noclipped2 then
                                if not override2 then
                                    spawn(function()
                                        game.Players.LocalPlayer:Kick("screengui " .. tostring(property) .. " changed")
                                    end)
                                    task.wait(0.4)
                                    while true do end
                                end
                            end
                        end);
                    end);
                    game.Players.LocalPlayer.PlayerGui.BlackScreenGui.BlackFrame.Changed:Connect(function(property)
                        if not noclipped2 then
                            if not override2 then
                                spawn(function()
                                    game.Players.LocalPlayer:Kick("blackframe " .. tostring(property) .. " changed")
                                end)
                                task.wait(0.4)
                                while true do end
                            end
                        end
                    end);
                end);
                task.wait(0.3);
                level1();
                else
                    Fluent:Notify({
                        Title = "Archie Hub",
                        Content = "You are under a Roof!",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    })
                end
            elseif workspace.Heists.Pyramid:FindFirstChild("Level2") then
                above = aboveplayer(game.Players.LocalPlayer.Name, true)
                if not above then
                noclipped2 = false;
                override2 = false;
                if game.Players.LocalPlayer.PlayerGui:FindFirstChild("BlackScreenGui") then
                    bsc = game.Players.LocalPlayer.PlayerGui.BlackScreenGui;
                    bsc.Enabled = true;
                    bsc.BlackFrame.Style = Enum.FrameStyle.RobloxRound;
                    task.wait(0.1);
                    bsc.BlackFrame.Style = Enum.FrameStyle.Custom;
                else
                    spawn(function()
                        game.Players.LocalPlayer:Kick("screengui not found")
                    end)
                    task.wait(0.4)
                    while true do end
                end
                spawn(function()
                    if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("BlackScreenGui") then
                        spawn(function()
                            game.Players.LocalPlayer:Kick("screengui not found")
                        end)
                        task.wait(0.4)
                        while true do end
                    end
                    spawn(function()
                        game.Players.LocalPlayer.PlayerGui.BlackScreenGui.Changed:Connect(function(property)
                            if not noclipped2 then
                                if not override2 then
                                    spawn(function()
                                        game.Players.LocalPlayer:Kick("screengui " .. tostring(property) .. " changed")
                                    end)
                                    task.wait(0.4)
                                    while true do end
                                end
                            end
                        end);
                    end);
                    game.Players.LocalPlayer.PlayerGui.BlackScreenGui.BlackFrame.Changed:Connect(function(property)
                        if not noclipped2 then
                            if not override2 then
                                spawn(function()
                                    game.Players.LocalPlayer:Kick("blackframe " .. tostring(property) .. " changed")
                                end)
                                task.wait(0.4)
                                while true do end
                            end
                        end
                    end);
                end);
                task.wait(0.3);
                level2();
                else
                    Fluent:Notify({
                        Title = "Archie Hub",
                        Content = "You are under a Roof!",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    })
                end
            else
                Fluent:Notify({
                    Title = "Archie Hub",
                    Content = "Pyramid is not opened!",
                    SubContent = "", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
        end
    })
    Tabs.Auto:AddButton({
        Title = "Rob Jewelry",
        Description = "",
        Callback = function()
            done = false;
            if (#workspace.Heists["Jewelry Store"].Items.Vent:GetChildren() == 1) then
                f = 0;
                done = false;
                hb = game:GetService("RunService").Heartbeat:Connect(function()
                    if (f < 150) then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-202.46188354492188, 141.7965087890625, 712.4617919921875);
                        f = f + 1;
                    elseif ((f == 150) or (f > 149)) then
                        done = true;
                    end
                end);
            else
                done = true;
            end
            repeat
                task.wait();
            until done 
            if (workspace.Heists["Jewelry Store"].Items.Diamonds.Containers.Glass:FindFirstChild("CanBeDamaged") or (#workspace.Heists["Jewelry Store"].Items.Vent:GetChildren() == 0)) then
                if game.Workspace.Heists["Jewelry Store"].Items:FindFirstChild("Laser") then
                    game.Workspace.Heists["Jewelry Store"].Items.Laser:Destroy();
                end
                if game.Workspace.Heists["Jewelry Store"].Items:FindFirstChild("LaserDoor") then
                    game.Workspace.Heists["Jewelry Store"].Items.LaserDoor:Destroy();
                end
                if game.Workspace.Heists["Jewelry Store"].Items:FindFirstChild("Spotlight") then
                    game.Workspace.Heists["Jewelry Store"].Items.Spotlight:Destroy();
                end
                task.wait(0.5);
                if InstaTeleport(-203.1533203125, 147.11549377441406, 714.52978515625, true) ~= "under a roof" then
                task.wait(1.5);
                Teleport(-218.21676635742188, 44.878021240234375, 714.8988037109375, 0.2);
                punch();
                task.wait(0.2);
                Teleport(-232.1437530517578, 44.87797546386719, 720.1504516601562, 0.2);
                punch();
                task.wait(0.2);
                Teleport(-248.03762817382812, 45.23802185058594, 726.2722778320312, 0.2);
                punch();
                task.wait(0.2);
                Teleport(-262.54876708984375, 44.87801742553711, 732.8526611328125, 0.2);
                punch();
                task.wait(0.2);
                Teleport(-214.16668701171875, 48.27802276611328, 710.5902099609375, 0.2);
                tp(-268.04437255859375, 46.67802429199219, 731.68017578125, 30);
                Teleport(-284.4754638671875, 44.97802734375, 770.3892211914062, 0.35);
                Teleport(-254.60752868652344, 25.780250549316406, 821.1755981445312, 0.35);
                Teleport(-215.4390106201172, 25.75469207763672, 761.2446899414062, 0.35);
                Teleport(-172.1982879638672, 25.66885757446289, 782.9047241210938, 0.35);
                setcooldown(0.001);
                waitforbutton();
                Click(Enum.KeyCode.E, 0.01);
                Teleport(-208.1318817138672, 25.677207946777344, 759.8880615234375, 0.2);
                punch();
                Teleport(-209.54885864257812, 27.118183135986328, 758.9752197265625, 1);
                tp(-192.72537231445312, 27.117786407470703, 751.8225708007812, 20);
                punch();
                tp(-199.37466430664062, 27.477741241455078, 737.7448120117188, 20);
                Teleport(-200.7261199951172, 27.477880477905273, 739.8182983398438, 0.2);
                punch();
                tp(-207.36932373046875, 27.478145599365234, 754.9833374023438, 20);
                task.wait(0.3);
                Teleport(-171.41831970214844, 25.673616409301758, 783.5303955078125, 0.3);
                setcooldown(0.001);
                waitforbutton();
                Click(Enum.KeyCode.E, 0.01);
                task.wait(0.3);
                spawn(function()
                    Fluent:Notify({
                        Title = "Archie Hub",
                        Content = "Please Wait...",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    })
                end);
                noclipped = false;
                override = false;
                if game.Players.LocalPlayer.PlayerGui:FindFirstChild("BlackScreenGui") then
                    bsc = game.Players.LocalPlayer.PlayerGui.BlackScreenGui;
                    bsc.Enabled = true;
                    bsc.BlackFrame.Style = Enum.FrameStyle.RobloxRound;
                    task.wait(0.1);
                    bsc.BlackFrame.Style = Enum.FrameStyle.Custom;
                else
                    while true do
                    end
                end
                spawn(function()
                    if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("BlackScreenGui") then
                        while true do
                        end
                    end
                    spawn(function()
                        game.Players.LocalPlayer.PlayerGui.BlackScreenGui.Changed:Connect(function(property)
                            if not noclipped then
                                if not override then
                                    while true do
                                    end
                                end
                            end
                        end);
                    end);
                    game.Players.LocalPlayer.PlayerGui.BlackScreenGui.BlackFrame.Changed:Connect(function(property)
                        if not noclipped then
                            if not override then
                                while true do
                                end
                            end
                        end
                    end);
                end);
                task.wait(0.3);
                tp(-218.4337615966797, 27.367530822753906, 783.5054321289062, 100);
                tp(-268.1515197753906, 58.637596130371094, 793.41552734375, 200);
                Teleport(-290.34857177734375, 58.88893508911133, 750.9640502929688, 0.3);
                tp(-203.70962524414062, 44.98734664916992, 715.1107177734375, 200);
                tp(-203.70962524414062, 200, 715.1107177734375, 400);
                tp(-187.8526611328125, 147.487548828125, 705.5648193359375, 200);
                tp(77.3438491821289, 137.10751342773438, 853.0025634765625, 400);
                tp(91.06292724609375, 142.4217071533203, 912.6390991210938, 100);
                tp(82, 27, 898, 100);
                function spawncarandenter()
                    local ohString1 = "UI";
                    local ohString2 = "SpawnCar";
                    local ohString3 = "Camaro";
                    game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer(ohString1, ohString2, ohString3);
                    waitforbutton();
                    Click(Enum.KeyCode.E, 0.01);
                end
                spawncarandenter();
                repeat
                    task.wait();
                until game.Players.LocalPlayer.Character.Humanoid.SeatPart 
                p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                car = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent;
                for i = 1, 15 do
                    cartp(64.87284088134766, 30, 867.466552734375, 1000);
                    task.wait();
                end
                task.wait(0.4);
                Click(Enum.KeyCode.Space, 0.1);
                noclipped = true;
                task.wait(0.1);
                bsc.Enabled = false;
                tp(39.305606842041016, 25.678028106689453, 776.1434936523438, 100);
                setcooldown(0.001);
                for i, v in pairs(workspace.Ignore:GetChildren()) do
                    if (v.Name == "ItemDuffelbag") then
                        v:Destroy();
                    end
                end
                waitforbutton();
                Click(Enum.KeyCode.E, 0.01);
                took = false;
                done = false;
                workspace.Ignore.ChildAdded:Connect(function(child)
                    if ((child.Name == "ItemDuffelbag") and not took) then
                        took = true;
                        spawn(function()
                            task.wait(3.2);
                            df = workspace.Ignore:WaitForChild("ItemDuffelbag"):WaitForChild("ToResize");
                            df.Parent.Name = "bag2";
                            df2 = workspace.Ignore:WaitForChild("ItemDuffelbag"):WaitForChild("ToResize");
                            tp(df.Position.x, df.Position.y + 6, df.Position.z, 100);
                            setcooldown(0.001);
                            waitforbutton();
                            Click(Enum.KeyCode.E, 0.01);
                            task.wait(0.5);
                            tp(49.76912307739258, 28.178030014038086, 830.1497192382812, 100);
                            setcooldown(0.001);
                            waitforbutton();
                            Click(Enum.KeyCode.E, 0.5);
                            task.wait(2.2);
                            tp(df2.Position.x, df2.Position.y + 6, df2.Position.z, 100);
                            setcooldown(0.001);
                            waitforbutton();
                            Click(Enum.KeyCode.E, 0.01);
                            task.wait(0.7);
                            tp(49.93207550048828, 28.177989959716797, 830.3630981445312, 100);
                            setcooldown(0.001);
                            waitforbutton();
                            Click(Enum.KeyCode.E, 0.5);
                            task.wait(2.2);
                            done = true;
                        end);
                    end
                end);
                repeat
                    task.wait();
                until done 
                Teleport(56.365745544433594, 25.418027877807617, 824.1410522460938, 0.3);
                Teleport(60.52540588378906, 25.17802619934082, 840.1036987304688, 0.3);
                waitforbutton();
                Click(Enum.KeyCode.E, 0.01);
                task.wait(2.2);
                Click(Enum.KeyCode.W, 2);
                p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                cartp(p.x, 700, p.z, 300);
                cartp(-1481.8668212890625, 700, 2972.01904296875, 1400);
                cartp(-1481.8668212890625, 14, 2972.01904296875, 700);
                cartp(-1481.30810546875, 13, 3093.927734375, 200);
                task.wait(5);
                cartp(-1481.8668212890625, 14, 2972.01904296875, 700);
                p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                cartp(p.x, 700, p.z, 700);
                cartp(362.9347229003906, 700, -1685.4400634765625, 1400);
                cartp(362.9347229003906, 13, -1685.4400634765625, 700);
                cartp(472.30743408203125, 13, -1679.287353515625, 300);
                end
            end
        end
    })
    Tabs.Auto:AddButton({
        Title = "Rob Plane",
        Description = "",
        Callback = function()
            planeh = workspace.Heists.Plane
            if planeh:FindFirstChild("Plane") then
                plane = planeh.Plane
                c4 = plane.C4
                hpos = game:GetService("Workspace").Heists.Plane.Plane.Hatch.Position
                o = InstaTeleport(hpos.x, hpos.y + 10, hpos.z, true)
                if not o == "under a roof" then
                    for i = 1, 50 do
                        hpos = game:GetService("Workspace").Heists.Plane.Plane.Hatch.Position
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hpos.x, hpos.y + 4, hpos.z)
                        task.wait()
                    end
                    function doc4()
                        if not c4["1"]:FindFirstChild("PlaneC4PlantComplete") then
                            for i = 1, 10 do
                                c4pos = c4["1"].Position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(c4pos.x, c4pos.y + 4, c4pos.z)
                                task.wait()
                            end
                            waitforbutton()
                            setcooldown(0.001)
                            for i = 1, 5 do
                                Click("E", 0.01, 0)
                            end
                            for i = 1, 10 do
                                hpos = game:GetService("Workspace").Heists.Plane.Plane.Hatch.Position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hpos.x, hpos.y + 4, hpos.z)
                                task.wait()
                            end
                        end
                        if not c4["2"]:FindFirstChild("PlaneC4PlantComplete") then
                            for i = 1, 10 do
                                c4pos = c4["2"].Position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(c4pos.x, c4pos.y + 4, c4pos.z)
                                task.wait()
                            end
                            waitforbutton()
                            setcooldown(0.001)
                            for i = 1, 5 do
                                Click("E", 0.01, 0)
                            end
                            for i = 1, 10 do
                                hpos = game:GetService("Workspace").Heists.Plane.Plane.Hatch.Position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hpos.x, hpos.y + 4, hpos.z)
                                task.wait()
                            end
                        end
                        if not c4["3"]:FindFirstChild("PlaneC4PlantComplete") then
                            for i = 1, 10 do
                                c4pos = c4["3"].Position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(c4pos.x, c4pos.y + 4, c4pos.z)
                                task.wait()
                            end
                            waitforbutton()
                            setcooldown(0.001)
                            for i = 1, 5 do
                                Click("E", 0.01, 0)
                            end
                            for i = 1, 10 do
                                hpos = game:GetService("Workspace").Heists.Plane.Plane.Hatch.Position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hpos.x, hpos.y + 4, hpos.z)
                                task.wait()
                            end
                        end
                        if not c4["4"]:FindFirstChild("PlaneC4PlantComplete") then
                            for i = 1, 10 do
                                c4pos = c4["4"].Position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(c4pos.x, c4pos.y + 4, c4pos.z)
                                task.wait()
                            end
                            waitforbutton()
                            setcooldown(0.001)
                            for i = 1, 5 do
                                Click("E", 0.01, 0)
                            end
                            for i = 1, 10 do
                                hpos = game:GetService("Workspace").Heists.Plane.Plane.Hatch.Position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hpos.x, hpos.y + 4, hpos.z)
                                task.wait()
                            end
                        end
                        if not c4["1"]:FindFirstChild("PlaneC4PlantComplete") or not c4["2"]:FindFirstChild("PlaneC4PlantComplete") or not c4["3"]:FindFirstChild("PlaneC4PlantComplete") or not c4["4"]:FindFirstChild("PlaneC4PlantComplete") then
                            doc4()
                        end
                    end
                    doc4()
                    repeat task.wait(); wind = workspace.Heists.Plane.Plane.Interior["Meshes/Cargo_plane_Window"].Position; game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(wind.x, wind.y - 6, wind.z)  until plane:FindFirstChild("PlaneSinkParticle")
                    if workspace.Heists.Plane:FindFirstChild("Plane") then
                        if workspace.Heists.Plane:FindFirstChild("planeclone") then workspace.Heists.Plane.planeclone:Destroy() end
                        realplane = workspace.Heists.Plane.Plane;
                        realplane.Archivable = true;
                        clone = realplane:Clone();
                        clone.Parent = workspace.Heists.Plane;
                        clone.Name = "planeclone";
                        if clone:FindFirstChild("Lasers") then
                            clone.Lasers:Destroy();
                        end
                        if realplane:FindFirstChild("Lasers") then
                            realplane.Lasers:Destroy();
                        end
                    end
                    bags = workspace.Ignore:WaitForChild("PlaneBags", 999999999)
                    game:GetService("Players").LocalPlayer.PlayerGui["All-InBackpackDisplayHolder"].MainHolder.Numerator.Text = "0"
                    while task.wait() do
                        if game:GetService("Players").LocalPlayer.PlayerGui["All-InBackpackDisplayHolder"].MainHolder.Numerator.Text ~= game:GetService("Players").LocalPlayer.PlayerGui["All-InBackpackDisplayHolder"].MainHolder.Denominator.Text then
                            repeat task.wait() until bags:FindFirstChild("PlaneDufflebag")
                            dufflebag = bags:FindFirstChild("PlaneDufflebag")
                            for i = 1, 10 do
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(dufflebag:WaitForChild("Handle").Position.x, dufflebag:WaitForChild("Handle").Position.y, dufflebag:WaitForChild("Handle").Position.z)
                                task.wait()
                            end
                            waitforbutton()
                            setcooldown(0.001)
                            Click("E", 0.01, 0.5)
                            task.wait(0.5)
                        else break end
                    end
                    task.wait(0.2)
                    spawn(function()
                        repeat task.wait() until not workspace.Heists.Plane:FindFirstChild("Plane")
                        workspace.Heists.Plane:FindFirstChild("planeclone"):Destroy()
                    end)
                    repeat
                        InstaTeleport(150.25677490234375, 25.506908416748047, -217.7570343017578, false);
                        tp(84.41801452636719, 25.25277328491211, -151.80941772460938, 50);
                        task.wait(2)
                    until game:GetService("Players").LocalPlayer.PlayerGui["All-InBackpackDisplayHolder"].Enabled == false
                end
            else
                Fluent:Notify({
                    Title = "Archie Hub",
                    Content = "Plane is not spawned.",
                    SubContent = "", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
        end
    })
    Tabs.Auto:AddSection("Autorob Small Stores & Casino")

    Tabs.Auto:AddButton({
        Title = "Rob Small Stores",
        Description = "Autorobs the Small Stores",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/klusiaholamafi/Autorob-Normal/main/Code"))();
        end
    })
    Tabs.Auto:AddButton({
        Title = "Rob Serverhop Small Stores",
        Description = "Rob Small Stores over Servers",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/klusiaholamafi/Autorob-Serverhop/main/Code"))();
        end
    })
    Tabs.Auto:AddButton({
        Title = "Spin Casino Wheel",
        Description = "Spins the Casino Wheel",
        Callback = function()
            InstaTeleport(1700, 25, 928, true);
            task.wait(0.2);
            tp(1700, 38, 928, 250);
            tp(1704, 38, 817, 500);
            Teleport(1706, 37, 796, 0.3);
            tp(1720.0570068359375, 37.3449821472168, 597.8731079101562, 750);
            Teleport(1700.516357421875, 31.044940948486328, 599.6107177734375, 0.1);
            waitforbutton();
            setcooldown(0.001);
            Click(Enum.KeyCode.E, 0.01);
        end
    })
    getgenv().NameTag = true;
    getgenv().NameSize = 15;
    getgenv().Health = true;
    getgenv().distanceshow = false;
    getgenv().OutLine = true;
    getgenv().OutLineColour = Color3.new(1, 1, 0);
    getgenv().FillTransparency = 0;
    getgenv().FillColour = Color3.new(1, 1, 0);
    function CreateFolder()
        Folder = Instance.new("Folder", game:GetService("CoreGui"));
        Folder.Name = "Archie HubESP";
    end
    CreateFolder();
    function AddOutline(Player)
        local Highlight = Instance.new("Highlight", Folder);
        Highlight.Adornee = Player;
        task.spawn(function()
            while task.wait(0.1) do
                if OutLine then
                    Highlight.OutlineTransparency = 0;
                else
                    Highlight.OutlineTransparency = 0.99999;
                end
                Highlight.FillColor = FillColour;
                Highlight.FillTransparency = FillTransparency;
                Highlight.OutlineColor = OutLineColour;
            end
        end);
    end
    function AddNameTag(Player)
        if (Player.Parent.Name ~= game.Players.LocalPlayer.Name) then
            local BGui = Instance.new("BillboardGui", Folder);
            local Frame = Instance.new("Frame", BGui);
            local TextLabel = Instance.new("TextLabel", Frame);
            repeat
                wait();
            until Player:FindFirstChild("Head") 
            BGui.Adornee = Player:WaitForChild("Head");
            BGui.StudsOffset = Vector3.new(0, 3, 0);
            BGui.AlwaysOnTop = true;
            BGui.MaxDistance = math.huge;
            BGui.Size = UDim2.new(100, 0, 100, 0);
            Frame.Size = UDim2.new(1, 0, 1, 0);
            task.spawn(function()
                while task.wait(0.1) do
                    TextLabel.TextSize = NameSize;
                    if NameTag then
                        TextLabel.Transparency = 0;
                    else
                        TextLabel.Transparency = 1;
                    end
                    if Player:FindFirstChild("HumanoidRootPart") then
                        local distance = (Player:WaitForChild("HumanoidRootPart", 9999).Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart", 9999).Position).Magnitude;
                        TextLabel.BackgroundTransparency = 1;
                        if Health then
                            TextLabel.Text = Player.Name .. " [" .. Player.Humanoid.Health .. "/" .. Player.Humanoid.MaxHealth .. "]";
                        end
                        if (distanceshow and Health) then
                            TextLabel.Text = Player.Name .. " [" .. Player.Humanoid.Health .. "/" .. Player.Humanoid.MaxHealth .. "]" .. " | " .. math.round(distance);
                        end
                        if (distanceshow and not Health) then
                            TextLabel.Text = Player.Name .. " | " .. math.round(distance);
                        end
                        if (not Health and not distanceshow) then
                            TextLabel.Text = Player.Name;
                        end
                    end
                end
            end);
            Frame.BackgroundTransparency = 1;
            TextLabel.BackgroundTransparency = 1;
            for i, v in pairs(game.Players:GetChildren()) do
                if (v.Name == Player.Name) then
                    ThePlayer = v;
                end
            end
            TextLabel.TextColor3 = ThePlayer.TeamColor.Color;
            TextLabel.Font = Enum.Font.GothamBlack;
            TextLabel.Size = UDim2.new(1, 0, 1, 0);
        end
    end
    function LoadPlayerESP()
        for i, v in pairs(game.Players:GetChildren()) do
            if (v ~= game:GetService("Players").LocalPlayer) then
                task.spawn(function()
                    v.CharacterAdded:Connect(function(Character)
                        if OutLine then
                            AddOutline(v.Character);
                        end
                        if NameTag then
                            AddNameTag(v.Character);
                        end
                    end);
                    if v.Character then
                        if OutLine then
                            AddOutline(v.Character);
                        end
                        if NameTag then
                            AddNameTag(v.Character);
                        end
                    end
                end);
            end
        end
    end
    function ReflashESP()
        local LastName = NameTag;
        local LastHealth = Health;
        local LastOutLine = OutLine;
        local LastFillTransparency = FillTransparency;
        game:GetService("CoreGui"):FindFirstChild("Archie HubESP"):Destroy();
        CreateFolder();
        getgenv().NameTag = true;
        getgenv().Health = true;
        getgenv().OutLine = true;
        getgenv().FillTransparency = 0;
        LoadPlayerESP();
        getgenv().NameTag = LastName;
        getgenv().Health = LastHealth;
        getgenv().OutLine = LastOutLine;
        getgenv().FillTransparency = LastFillTransparency;
    end
    game:GetService("Players").PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(Character)
            if OutLine then
                AddOutline(Character);
            end
            if NameTag then
                AddNameTag(Character);
            end
        end);
    end);
    game:GetService("Players").PlayerRemoving:Connect(function(player)
        ReflashESP();
    end);
    LoadPlayerESP();
    getgenv().NameTag = false;
    getgenv().NameSize = 15;
    getgenv().Health = true;
    getgenv().OutLine = false;
    getgenv().OutLineColour = Color3.new(1, 1, 0);
    getgenv().FillTransparency = 0.999;
    getgenv().FillColour = Color3.new(1, 1, 0);
    task.spawn(function()
        while task.wait() do
            ReflashESP();
            task.wait(25);
        end
    end);
    local function API_Check()
        if (Drawing == nil) then
            return "No";
        else
            return "Yes";
        end
    end
    local Find_Required = API_Check();
    if (Find_Required == "No") then
        NotificationLibrary:SendNotification("Error", "Your Exploit is unsupported for Tracers!", 3);
        return;
    end
    local RunService = game:GetService("RunService");
    local Players = game:GetService("Players");
    local Camera = game:GetService("Workspace").CurrentCamera;
    local UserInputService = game:GetService("UserInputService");
    local TestService = game:GetService("TestService");
    local Typing = false;
    SendNotifications = true;
    DefaultSettings = false;
    TeamCheck = false;
    FromMouse = false;
    FromCenter = false;
    FromBottom = true;
    TracersVisible = false;
    TracerColor = Color3.fromRGB(255, 80, 10);
    TracerThickness = 1;
    TracerTransparency = 0.7;
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        ReflashESP()
    end)
    local function CreateTracers()
        for _, v in next, Players:GetPlayers() do
            if (v.Name ~= game.Players.LocalPlayer.Name) then
                local TracerLine = Drawing.new("Line");
                RunService.RenderStepped:Connect(function()
                    if ((workspace:FindFirstChild(v.Name) ~= nil) and (workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil)) then
                        local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1;
                        local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p);
                        TracerLine.Thickness = TracerThickness;
                        TracerLine.Transparency = TracerTransparency;
                        TracerLine.Color = v.TeamColor.Color;
                        if ((FromMouse == true) and (FromCenter == false) and (FromBottom == false)) then
                            TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y);
                        elseif ((FromMouse == false) and (FromCenter == true) and (FromBottom == false)) then
                            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2);
                        elseif ((FromMouse == false) and (FromCenter == false) and (FromBottom == true)) then
                            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y);
                        end
                        if (OnScreen == true) then
                            TracerLine.To = Vector2.new(Vector.X, Vector.Y);
                            if (TeamCheck == true) then
                                if (Players.LocalPlayer.Team ~= v.Team) then
                                    TracerLine.Visible = TracersVisible;
                                else
                                    TracerLine.Visible = false;
                                end
                            else
                                TracerLine.Visible = TracersVisible;
                            end
                        else
                            TracerLine.Visible = false;
                        end
                    else
                        TracerLine.Visible = false;
                    end
                end);
                Players.PlayerRemoving:Connect(function()
                    TracerLine.Visible = false;
                end);
            end
        end
        Players.PlayerAdded:Connect(function(Player)
            Player.CharacterAdded:Connect(function(v)
                if (v.Name ~= game.Players.LocalPlayer.Name) then
                    local TracerLine = Drawing.new("Line");
                    RunService.RenderStepped:Connect(function()
                        if ((workspace:FindFirstChild(v.Name) ~= nil) and (workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil)) then
                            local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1;
                            local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p);
                            TracerLine.Thickness = TracerThickness;
                            TracerLine.Transparency = TracerTransparency;
                            TracerLine.Color = TracerColor;
                            if ((FromMouse == true) and (FromCenter == false) and (FromBottom == false)) then
                                TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y);
                            elseif ((FromMouse == false) and (FromCenter == true) and (FromBottom == false)) then
                                TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2);
                            elseif ((FromMouse == false) and (FromCenter == false) and (FromBottom == true)) then
                                TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y);
                            end
                            if (OnScreen == true) then
                                TracerLine.To = Vector2.new(Vector.X, Vector.Y);
                                if (TeamCheck == true) then
                                    if (Players.LocalPlayer.Team ~= Player.Team) then
                                        TracerLine.Visible = TracersVisible;
                                    else
                                        TracerLine.Visible = false;
                                    end
                                else
                                    TracerLine.Visible = TracersVisible;
                                end
                            else
                                TracerLine.Visible = false;
                            end
                        else
                            TracerLine.Visible = false;
                        end
                    end);
                    Players.PlayerRemoving:Connect(function()
                        TracerLine.Visible = false;
                    end);
                end
            end);
        end);
    end
    UserInputService.TextBoxFocused:Connect(function()
        Typing = true;
    end);
    UserInputService.TextBoxFocusReleased:Connect(function()
        Typing = false;
    end);
    UserInputService.InputBegan:Connect(function(Input)
        if ((Input.KeyCode == ModeSkipKey) and (Typing == false)) then
            if ((FromMouse == true) and (FromCenter == false) and (FromBottom == false) and (TracersVisible == true)) then
                FromCenter = false;
                FromBottom = true;
                FromMouse = false;
            elseif ((FromMouse == false) and (FromCenter == false) and (FromBottom == true) and (TracersVisible == true)) then
                FromCenter = true;
                FromBottom = false;
                FromMouse = false;
            elseif ((FromMouse == false) and (FromCenter == true) and (FromBottom == false) and (TracersVisible == true)) then
                FromCenter = false;
                FromBottom = false;
                FromMouse = true;
            end
        elseif ((Input.KeyCode == DisableKey) and (Typing == false)) then
            TracersVisible = not TracersVisible;
        end
    end);
    local Success, Errored = pcall(function()
        CreateTracers();
    end);
    Tabs.ESP:AddSection("Player ESP")
    local shownametoggle = Tabs.ESP:AddToggle("namees", {Title = "Show Names", Default = false })
    shownametoggle:OnChanged(function(Value)
        NameTag = Value
        ReflashESP()
    end)
    local showhealthtoggle = Tabs.ESP:AddToggle("health", {Title = "Show Health", Default = false })
    showhealthtoggle:OnChanged(function(Value)
        Health = Value
    end)
    local showoutlinetoggle = Tabs.ESP:AddToggle("outline", {Title = "Show Outline", Default = false })
    showoutlinetoggle:OnChanged(function(Value)
        OutLine = Value
    end)
    local showdistancetoggle = Tabs.ESP:AddToggle("distance", {Title = "Show Distance", Default = false })
    showdistancetoggle:OnChanged(function(Value)
        distanceshow = Value
    end)
    local showchamstoggle = Tabs.ESP:AddToggle("chams", {Title = "Show Chams", Default = false })
    showchamstoggle:OnChanged(function(Value)
        if Value then
            FillTransparency = 0;
        else
            FillTransparency = 0.999;
        end
    end)
    local showtracertoggle = Tabs.ESP:AddToggle("tracer", {Title = "Show Tracer", Default = false })
    showtracertoggle:OnChanged(function(Value)
        TracersVisible = Value
    end)
    Tabs.ESP:AddButton({
        Title = "Refresh ESP",
        Description = "Restarts the ESP",
        Callback = function()
            ReflashESP()
        end
    })
    Tabs.ESP:AddSection("Other ESP")
    local cratesp = Tabs.ESP:AddToggle("crate", {Title = "Crate ESP", Default = false })
    cratesp:OnChanged(function(Value)
        CrateESP = Value;
    end)
    Tabs.ESP:AddButton({
        Title = "Club Button ESP",
        Description = "Shows the Club Button",
        Callback = function()
            for __, v in pairs(game.Workspace.Heists.Club.Items:GetDescendants()) do
                if (v.Name == "Button") then
                    local a = Instance.new("BillboardGui", v);
                    a.Name = "Archie HubESP1min";
                    a.Size = UDim2.new(10, 0, 10, 0);
                    a.AlwaysOnTop = true;
                    local b = Instance.new("Frame", a);
                    b.Size = UDim2.new(1, 0, 1, 0);
                    b.BackgroundTransparency = 0.8;
                    b.BorderSizePixel = 0;
                    b.BackgroundColor3 = Color3.new(1, 0, 0);
                    local c = Instance.new("TextLabel", b);
                    c.Size = UDim2.new(2, 0, 2, 0);
                    c.BorderSizePixel = 0;
                    c.TextSize = 20;
                    c.Text = v.Name;
                    c.BackgroundTransparency = 1;
                end
            end
        end
    })
    Tabs.Car:AddSection("Car Miscellaneous")
    local spawnvehicle = Tabs.Car:AddInput("spawn vehicle", {
        Title = "Spawn Vehicle",
        Default = "Case sensitive | Own",
        Placeholder = "vehicle name",
        Numeric = false, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(vehiclename)
            game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer("UI", "SpawnCar", vehiclename);
        end
    })
    local carfliptogg = Tabs.Car:AddToggle("carflip", {Title = "Auto Flip Car", Default = false })
    carfliptogg:OnChanged(function(Value)
        autocarflip = Value
    end)
    local boostspam = Tabs.Car:AddToggle("boostspamming", {Title = "Auto Spam Boost", Default = false })
    boostspam:OnChanged(function(Value)
        boostspam = Value
        task.spawn(function()
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "BoostRegenPerSecond")) then
                    rawset(v, "BoostRegenPerSecond", 5000);
                end
            end
        end);
    end)
    local spamhorn = Tabs.Car:AddToggle("hornspamming", {Title = "Auto Spam Horn", Default = false })
    spamhorn:OnChanged(function(Value)
        hornspam = Value
    end)
    local spamsiren = Tabs.Car:AddToggle("sirenspamming", {Title = "Auto Spam Siren", Default = false })
    spamsiren:OnChanged(function(Value)
        sirene = Value
end)
    local carflip = Tabs.Car:AddToggle("carflip", {Title = "Enable Hover Mode (Y/Z)", Default = false })
    carflip:OnChanged(function(Value)
        for i, v in next, getgc(true) do
			if ((type(v) == "table") and rawget(v, "MaxSpeed")) then
				rawset(v, "CanTurnHoverMode", Value);
			end
		end
    end)
    Tabs.Car:AddSection("Vehicle Modifications")
    Tabs.Car:AddButton({
        Title = "Mod Car",
        Description = "",
        Callback = function()
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "MaxSpeed")) then
                    rawset(v, "MaxSpeed", 3000);
                    rawset(v, "StartTime", 0.01);
                    rawset(v, "BoostRegenPerSecond", 5000);
                end
            end
        end
    })
    Tabs.Car:AddButton({
        Title = "Mod Helicopter",
        Description = "",
        Callback = function()
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "MaxSpeed")) then
                    rawset(v, "MaxSpeed", 3000);
                    rawset(v, "StartTime", 0.01);
                end
            end
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "Missiles")) then
                    v.MissileCooldown = 0.1;
                    v.MissileTargetRange = 2000;
                    v.MissileLock = 0.1;
                end
            end
        end
    })
    Tabs.Car:AddButton({
        Title = "Mod BRRT",
        Description = "",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/klusiaholamafi/Mod-A10/main/Code"))();
        end
    })
    Tabs.Car:AddButton({
        Title = "Infinite Boost",
        Description = "",
        Callback = function()
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "BoostRegenPerSecond")) then
                    rawset(v, "BoostRegenPerSecond", 5000);
                end
            end
        end
    })
    local vehiclemaxspeedslider = Tabs.Car:AddSlider("vehiclespeed", {
        Title = "Vehicle Max Speed",
        Description = "Maximum Speed of Vehicle",
        Default = 100,
        Min = 0,
        Max = 3000,
        Rounding = 0.1,
        Callback = function(Value)
            _G.Maxspeed = Value
            loadstring(game:HttpGet("https://raw.githubusercontent.com/klusiaholamafi/Vehicle-Max-Speed/main/Code"))();
        end
    })
    local vehiclestart = Tabs.Car:AddSlider("vehiclestart", {
        Title = "Vehicle Start Time",
        Description = "Starting Time of Vehicle",
        Default = 2,
        Min = 0.1,
        Max = 5,
        Rounding = 0.1,
        Callback = function(Value)
            _G.Starttime = Value
            loadstring(game:HttpGet("https://raw.githubusercontent.com/klusiaholamafi/Vehicle-Start-Time/main/Code"))();
        end
    })

    Tabs.Mods:AddSection("Gun Modifications")
    Tabs.Mods:AddButton({
        Title = "Mod Guns Maximum",
        Description = "Warning! Mods All Guns!",
        Callback = function()
            for i,v in next, getgc(true) do
                if type(v) == "table" and rawget(v, "Damage") then
                    rawset(v, "RateOfFire", 0) -- firerate
					rawset(v, "ReloadTime", 0) -- ReloadTime 
					rawset(v, "ClipSize", math.huge) -- inf ammo only works on shotguns etc (math.huge or 0 etc) MaxAmmo
					rawset(v, "MinAccuracy", 0) 
					rawset(v, "MaxAccuracy", 0)
					rawset(v, "Range", math.huge) -- gun range (serversided)
					rawset(v, "Clips", math.huge) -- Ammo
                end
            end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Mod Guns Realistic",
        Description = "Warning! Mods All Guns!",
        Callback = function()
            for i,v in next, getgc(true) do
                if type(v) == "table" and rawget(v, "Damage") then
                   rawset(v, "RateOfFire", 0.1) -- firerate
                   rawset(v, "ClipSize", 2500) -- inf ammo only works on shotguns etc (math.huge or 0 etc) MaxAmmo
                   rawset(v, "Clips", 2500) -- Ammo
                end
              end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Infinite Ammo",
        Description = "",
        Callback = function()
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "Damage")) then
                    rawset(v, "ClipSize", math.huge);
                    rawset(v, "Clips", math.huge);
                end
            end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Anti Recoil",
        Description = "",
        Callback = function()
            for i,v in next, getgc(true) do
                if type(v) == "table" and rawget(v, "Damage") then
                    rawset(v, "MinAccuracy", 1) 
                    rawset(v, "MaxAccuracy", 1)
                end
            end
        end
    })
    local Ammoslider = Tabs.Mods:AddSlider("Ammoslider", {
        Title = "Ammo",
        Description = "Ammunition of youre Gun",
        Default = 30,
        Min = 0,
        Max = 5000,
        Rounding = 0.1,
        Callback = function(Value)
            _G.Ammo = Value
	        loadstring(game:HttpGet("https://raw.githubusercontent.com/klusiaholamafi/Ammo-Slider/main/Code"))();
        end
    })
    local Firerateslider = Tabs.Mods:AddSlider("Firerateslider", {
        Title = "Firerate",
        Description = "Fire Rate of youre Gun",
        Default = 0.5,
        Min = 0.01,
        Max = 2,
        Rounding = 10,
        Callback = function(Value)
            _G.Firerate = Value
            loadstring(game:HttpGet("https://raw.githubusercontent.com/klusiaholamafi/Firerate/main/Code"))();
        end
    })
    Tabs.Mods:AddSection("Specific Gun Modifications")
    Tabs.Mods:AddButton({
        Title = "Mod Famas",
        Description = "",
        Callback = function()
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "Damage")) then
                    rawset(v, "Type", 6816341075);
                    rawset(v, "FireMode", "Auto");
                    rawset(v, "RateOfFire", 0.001);
                    rawset(v, "ClipSize", 5000);
                    rawset(v, "Clips", 4999);
                    rawset(v, "Burst", 2.9);
                    rawset(v, "BurstTime", 0);
                    rawset(v, "HeadshotMultiplier", 3.6924);
                end
            end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Mod G36",
        Description = "",
        Callback = function()
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "Damage")) then
                    rawset(v, "Type", 6816341075);
                    rawset(v, "FireMode", "Auto");
                    rawset(v, "RateOfFire", 0.001);
                    rawset(v, "ClipSize", 5000);
                    rawset(v, "Clips", 4999);
                    rawset(v, "Burst", 2.9);
                    rawset(v, "BurstTime", 0);
                    rawset(v, "HeadshotMultiplier", 1.6);
                end
            end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Mod M1014",
        Description = "",
        Callback = function()
            for i,v in next, getgc(true) do
                if type(v) == "table" and rawget(v, "Damage") then
                    rawset(v, "RateOfFire", 0) -- firerate                    
                    rawset(v, "ClipSize", 5000) -- inf ammo only works on shotguns etc (math.huge or 0 etc) MaxAmmo
                    rawset(v, "FireMode", "Burst") -- Burst , Auto
                    rawset(v, "Clips", 4999) -- Ammo
                end
            end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Mod Pistol",
        Description = "",
        Callback = function()
            for i,v in next, getgc(true) do
                if type(v) == "table" and rawget(v, "Damage") then
                    rawset(v, "RateOfFire", 0.12) -- firerate                    
                    rawset(v, "ClipSize", 20) -- inf ammo only works on shotguns etc (math.huge or 0 etc) MaxAmmo
                    rawset(v, "FireMode", "Auto") -- Burst , Auto
                    rawset(v, "Clips", 19) -- Ammo
                end
            end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Mod AA12",
        Description = "",
        Callback = function()
            for i, v in next, getgc(true) do
                if ((type(v) == "table") and rawget(v, "Damage")) then
                    rawset(v, "Type", 6816341075);
                    rawset(v, "FireMode", "Auto");
                    rawset(v, "RateOfFire", 0);
                    rawset(v, "ClipSize", 5000);
                    rawset(v, "Clips", 4999);
                    rawset(v, "Burst", 13.9);
                    rawset(v, "BurstTime", 0);
                end
            end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Mod Shotgun",
        Description = "",
        Callback = function()
            for i,v in next, getgc(true) do
                if type(v) == "table" and rawget(v, "Damage") then
                    rawset(v, "RateOfFire", 0) -- firerate
					rawset(v, "ReloadTime", 0) -- ReloadTime 
					rawset(v, "ClipSize", math.huge) -- inf ammo only works on shotguns etc (math.huge or 0 etc) MaxAmmo
					rawset(v, "MinAccuracy", 0) 
					rawset(v, "MaxAccuracy", 0)
					rawset(v, "Range", math.huge) -- gun range (serversided)
					rawset(v, "Clips", math.huge) -- Ammo
                end
            end
        end
    })
    Tabs.Mods:AddButton({
        Title = "Mod Grenade Launcher",
        Description = "",
        Callback = function()
            for i,v in next, getgc(true) do
                if type(v) == "table" and rawget(v, "Damage") then
                    rawset(v, "RateOfFire", 0.01) 
                    rawset(v, "ExplosionRadius", 50);  -- firerate
                    rawset(v, "ClipSize", 11) -- inf ammo only works on shotguns etc (math.huge or 0 etc) MaxAmmo
                    rawset(v, "Clips",11) 
                     rawset(v, "FireMode", "Burst")
                       rawset(v, "Burst", 1.9);
                    rawset(v, "BurstTime", 0);                 
                 end
            end
        end
    })

    Tabs.Tp:AddSection("Auto Escape Prison")
    Tabs.Tp:AddButton({
        Title = "Escape Prison",
        Description = "",
        Callback = function()
            success1 = false;
	        hb = game:GetService("RunService").Heartbeat:Connect(function()
                if not success1 then
                    if not game.Players.LocalPlayer.Character.Humanoid.SeatPart then
                        if not success1 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-91, 25.4, -173);
                            Click("E", 0.01, 0);
                        end
                    else
                        success1 = true;
                        repeat Click("Space", 0.1, 0); until not game.Players.LocalPlayer.Character.Humanoid.SeatPart 
                    end
                end
            end);
        repeat wait(); until success end
    })
    Tabs.Tp:AddSection("Teleport to Player")
    local tptoplayer = Tabs.Tp:AddInput("tptoplayer", {
        Title = "Teleport to Player",
        Default = "Playername",
        Placeholder = "Shortcut, displayname or username allowed",
        Numeric = false, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(playername)
            for i, v in pairs(game.Players:GetPlayers()) do
                if string.find(v.Name:lower(), playername:lower()) or string.find(v.DisplayName:lower(), playername:lower()) then
                    k = v.Character.HumanoidRootPart.Position;
                    p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                    InstaTeleport(k.x, k.y + 10, k.z, true);
                end
            end
        end
    })
    Tabs.Tp:AddSection("Heist Teleports")
    Tabs.Tp:AddButton({
        Title = "Teleport to Jewelry",
        Description = "",
        Callback = function()
            InstaTeleport(-188, 25, 692, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Pyramid",
        Description = "",
        Callback = function()
            InstaTeleport(-272, 152, -1352, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Bank",
        Description = "",
        Callback = function()
            InstaTeleport(638, 50, 468, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Casino",
        Description = "",
        Callback = function()
            InstaTeleport(1695, 25, 925, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Club",
        Description = "",
        Callback = function()
            InstaTeleport(1691, 73, -1229, true);
        end
    })
    Tabs.Tp:AddSection("Other Teleports")
    Tabs.Tp:AddButton({
        Title = "Teleport to Criminal Base",
        Description = "",
        Callback = function()
            InstaTeleport(-56, 25, -103, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Prison Out",
        Description = "",
        Callback = function()
            InstaTeleport(-1862, 47, -181, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Prison In",
        Description = "",
        Callback = function()
            InstaTeleport(-2115, 47, -259, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Area 51",
        Description = "",
        Callback = function()
            InstaTeleport(-1844, 252, 2342, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Airport",
        Description = "",
        Callback = function()
            InstaTeleport(557, 116, 2112, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Gun Store",
        Description = "",
        Callback = function()
            InstaTeleport(842, 38, -1040, true);
        end
    })
    Tabs.Tp:AddButton({
        Title = "Teleport to Vehicle Mod Store",
        Description = "",
        Callback = function()
            InstaTeleport(1432, 25, 521, true);
        end
    })
    Tabs.Tp:AddSection("Teleport Settings")
    Tabs.Tp:AddButton({
        Title = "Cancel Teleport",
        Description = "Cancels the current Teleport",
        Callback = function()
            for i = 1, 3 do
                canceltp = true;
                task.wait(0.15);
            end
        end
    })
    local enablefasttp = Tabs.Tp:AddToggle("enablefasttp", {Title = "Fast Teleport", Default = false })
    enablefasttp:OnChanged(function(Value)
        TPFastMode = Value
    end)
    local tpspeedup = Tabs.Tp:AddSlider("tpspeedup", {
        Title = "Teleport Speed Up",
        Description = "",
        Default = 1000,
        Min = 800,
        Max = 10000,
        Rounding = 0.1,
        Callback = function(Value)
            goupspeed = Value;
        end
    })
    local tpspeeduntil = Tabs.Tp:AddSlider("tpspeeduntil", {
        Title = "Teleport Speed Until",
        Description = "",
        Default = 1000,
        Min = 800,
        Max = 10000,
        Rounding = 0.1,
        Callback = function(Value)
            gountilspeed = Value;
        end
    })
    local tpspeeddown = Tabs.Tp:AddSlider("tpspeeddown", {
        Title = "Teleport Speed Down",
        Description = "",
        Default = 1000,
        Min = 800,
        Max = 10000,
        Rounding = 0.1,
        Callback = function(Value)
            godownspeed = Value;
        end
    })
    local tploops = Tabs.Tp:AddSlider("tploops", {
        Title = "Teleport Loops",
        Description = "",
        Default = 10,
        Min = 1,
        Max = 30,
        Rounding = 0.1,
        Callback = function(Value)
            setuploops = Value;
        end
    })
    Tabs.Laser:AddSection("Remove All Laser")
    Tabs.Laser:AddButton({
        Title = "Remove All Lasers",
        Description = "",
        Callback = function()
            if game.Workspace.Heists.Bank.Items.Chunk:FindFirstChild("Deposit") then
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.LiftHallway.Function.Lasers:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.BottomSection.Function.Lasers:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.BottomSection.Function.LaserRotate:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.BottomSection.Function.BankLasers2:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.CameraLasers:Destroy();
            end
            if game.Workspace.Heists.Bank.Items.Chunk:FindFirstChild("Mint") then
                game.Workspace.Heists.Bank.Items.Chunk.Mint.RoomB.Lasers.Main:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Mint.RoomB.GreenLasers:Destroy();
            end
            game.Workspace.Heists["Jewelry Store"].Items.Laser:Destroy();
            game.Workspace.Heists["Jewelry Store"].Items.LaserDoor:Destroy();
            game.Workspace.Heists["Jewelry Store"].Items.Spotlight:Destroy();
            game.Workspace.Heists.Casino.Stealthy.Items.Detectors:Destroy();
            game.Workspace.Heists.Casino.Stealthy.Items.MovingLasers:Destroy();
            game.Workspace.Heists.Casino.Stealthy.Items.NightDoor:Destroy();
            if workspace.Heists.Plane:FindFirstChild("Plane") then
                realplane = workspace.Heists.Plane.Plane;
                realplane.Archivable = true;
                clone = realplane:Clone();
                clone.Parent = workspace.Heists.Plane;
                clone.Name = "planeclone";
                clone.Lasers:Destroy();
                realplane.Lasers:Destroy();
            else
                Fluent:Notify({
                    Title = "Archie Hub",
                    Content = "Plane not spawned!",
                    SubContent = "discord.gg/B7YBTTRvj4", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
            game.Workspace.MovingLasers.AppleStoreFloorA:Destroy();
		    game.Workspace.MovingLasers.AppleStoreFloorB:Destroy();
            if game.Workspace.Heists.Pyramid:FindFirstChild("Level1") then
                game.Workspace.Heists.Pyramid.Level1.SpikeTraps:Destroy();
                game.Workspace.Heists.Pyramid.Level1.Flamethrowers:Destroy();
                game.Workspace.Heists.Pyramid.Level1["Boulder Run"].DestroyPlanks:Destroy();
            end
            if game.Workspace.Heists.Pyramid:FindFirstChild("Level2") then
                game.Workspace.Heists.Pyramid.Level2.PressurePlates:Destroy();
                game.Workspace.Heists.Pyramid.Level2.Flamethrowers:Destroy();
                game.Workspace.Heists.Pyramid.Level2.RockWall:Destroy();
            end
            if game.Workspace.Heists.Club:FindFirstChild("Level2") then
				game.Workspace.Heists.Club.Level2.Items.LaserWalls:Destroy(); --level 2
            end
				if game.Workspace.Heists.Club:FindFirstChild("Level1") then
                game.Workspace.Heists.Club.Level1.Items.Lasers:Destroy(); --level 1
			end
            if game.Workspace.Heists.Club:FindFirstChild("Level3") then
                game.Workspace.Heists.Club.Level3.Items.RotatingPlatform.Rotate:Destroy();
            end
        end
    })
    Tabs.Laser:AddSection("Remove Specific Laser")
    Tabs.Laser:AddButton({
        Title = "Remove Bank Laser",
        Description = "",
        Callback = function()
            if game.Workspace.Heists.Bank.Items.Chunk:FindFirstChild("Deposit") then
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.LiftHallway.Function.Lasers:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.BottomSection.Function.Lasers:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.BottomSection.Function.LaserRotate:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.BottomSection.Function.BankLasers2:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Deposit.CameraLasers:Destroy();
            end
            if game.Workspace.Heists.Bank.Items.Chunk:FindFirstChild("Mint") then
                game.Workspace.Heists.Bank.Items.Chunk.Mint.RoomB.Lasers.Main:Destroy();
                game.Workspace.Heists.Bank.Items.Chunk.Mint.RoomB.GreenLasers:Destroy();
            end
        end
    })
    Tabs.Laser:AddButton({
        Title = "Remove Jewelry Laser",
        Description = "",
        Callback = function()
            if  game.Workspace.Heists["Jewelry Store"].Items.Laser then
            game.Workspace.Heists["Jewelry Store"].Items.Laser:Destroy();
            game.Workspace.Heists["Jewelry Store"].Items.LaserDoor:Destroy();
            game.Workspace.Heists["Jewelry Store"].Items.Spotlight:Destroy();
            end
        end
    })
    Tabs.Laser:AddButton({
        Title = "Remove Club Laser",
        Description = "",
        Callback = function()
			if game.Workspace.Heists.Club:FindFirstChild("Level2") then
				game.Workspace.Heists.Club.Level2.Items.LaserWalls:Destroy(); --level 2
            end
				if game.Workspace.Heists.Club:FindFirstChild("Level1") then
                game.Workspace.Heists.Club.Level1.Items.Lasers:Destroy(); --level 1
			end
            if game.Workspace.Heists.Club:FindFirstChild("Level3") then
                game.Workspace.Heists.Club.Level3.Items.RotatingPlatform.Rotate:Destroy();
            end
        end
    })
    Tabs.Laser:AddButton({
        Title = "Remove Pyramid Laser",
        Description = "",
        Callback = function()
            if game.Workspace.Heists.Pyramid:FindFirstChild("Level1") then
                game.Workspace.Heists.Pyramid.Level1.SpikeTraps:Destroy();
                game.Workspace.Heists.Pyramid.Level1.Flamethrowers:Destroy();
                game.Workspace.Heists.Pyramid.Level1["Boulder Run"].DestroyPlanks:Destroy();
            end
            if game.Workspace.Heists.Pyramid:FindFirstChild("Level2") then
                game.Workspace.Heists.Pyramid.Level2.PressurePlates:Destroy();
                game.Workspace.Heists.Pyramid.Level2.Flamethrowers:Destroy();
                game.Workspace.Heists.Pyramid.Level2.RockWall:Destroy();
            end
        end
    })
    Tabs.Laser:AddButton({
        Title = "Remove Casino Laser",
        Description = "",
        Callback = function()
            game.Workspace.Heists.Casino.Stealthy.Items.Detectors:Destroy();
            game.Workspace.Heists.Casino.Stealthy.Items.MovingLasers:Destroy();
            game.Workspace.Heists.Casino.Stealthy.Items.NightDoor:Destroy();
        end
    })
    Tabs.Laser:AddButton({
        Title = "Remove Plane Laser",
        Description = "",
        Callback = function()
            if workspace.Heists.Plane:FindFirstChild("Plane") then
                realplane = workspace.Heists.Plane.Plane;
                realplane.Archivable = true;
                clone = realplane:Clone();
                clone.Parent = workspace.Heists.Plane;
                clone.Name = "planeclone";
                clone.Lasers:Destroy();
                realplane.Lasers:Destroy();
            else
                Fluent:Notify({
                    Title = "Archie Hub",
                    Content = "Plane not spawned!",
                    SubContent = "discord.gg/B7YBTTRvj4", -- Optional
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
        end
    })
    Tabs.Laser:AddButton({
        Title = "Remove Apple Store Laser",
        Description = "",
        Callback = function()
            game.Workspace.MovingLasers.AppleStoreFloorA:Destroy();
		    game.Workspace.MovingLasers.AppleStoreFloorB:Destroy();
        end
    })
    Tabs.detect:AddSection("Update Detect")

    local kicktoggle = Tabs.detect:AddToggle("kickonupdate", {Title = "Kick on Update", Default = false })
    kicktoggle:OnChanged(function(Value)
        kickonupdate = not kickonupdate
        notifyonupdate = false
    end)

    local notifyupdate = Tabs.detect:AddToggle("notifyonupdate", {Title = "Notify on Update", Default = false })
    notifyupdate:OnChanged(function(Value)
        kickonupdate = false
        notifyonupdate = not notifyonupdate
    end)
    Notify = false;
    task.spawn(function()
        local TargetID = {[1]=59967,[2]=62346773,[3]=116481933,[4]=2032622,[5]=932083,[6]=430348004,[7]=4610703127,[8]=1933300649,[9]=8002766,[10]=16161864,[11]=17897891,[12]=721771859,[13]=83641955,[14]=898616125,[15]=1327827528,[16]=966027914,[17]=146462043,[18]=958389997,[19]=94467335,[20]=908360954,[21]=698617806,[22]=70556831,[23]=1299780523,[24]=1647502388,[25]=3183391648,[26]=28962045,[27]=225259944,[28]=4276937661,[29]=512754036,[30]=731501956,[31]=146493490,[32]=608027295,[33]=211222858,[34]=2678001507,[35]=68777399,[36]=35479046,[37]=35479046,[38]=75151198,[39]=15180512,[40]=191803941,[41]=30944240,[42]=92812719,[43]=702252975,[44]=1131551308,[45]=153343142,[46]=1805793503,[47]=24883415,[48]=749064269,[49]=373061764,[50]=127514028,[51]=1169232379,[52]=974223821,[53]=1084171270,[54]=456177771,[55]=109225997,[56]=885920088,[57]=74810618,[58]=588504342,[59]=68728334,[60]=1008353195,[61]=13629636,[62]=943911395,[63]=1216109201,[64]=72579861,[65]=134262088,[66]=157180286,[67]=18394351,[68]=4426328480,[69]=24243319,[70]=53574228,[71]=165681568,[72]=94782426,[73]=1461506964,[74]=1461506964};
        function DefinePlayer(PlayerID)
            for i = 1, #TargetID do
                if (PlayerID == TargetID[i]) then
                    return true;
                end
            end
        end
        game:GetService("Players").PlayerAdded:Connect(function(Player)
            if Notify then
                if DefinePlayer(Player.UserId) then
                    for i = 1, 1 do
                        Fluent:Notify({
                            Title = "Admin Joined!",
                            Content = "Leave the game to avoid a Ban!",
                            SubContent = "", -- Optional
                            Duration = 5 -- Set to nil to make the notification not disappear
                        });
                    end
                end
            elseif autoleaveonmod then
                if DefinePlayer(Player.UserId) then
                    for i = 1, 5 do
                        game.Players.LocalPlayer:Kick("Admin | Mod Joined! \r Shutdown game in " .. (5 - i) .. " seconds");
                        task.wait(1);
                    end
                    game:Shutdown();
                end
            end
        end);
    end)
    Tabs.detect:AddSection("Admin Detect")
    local kickonadmintoggle = Tabs.detect:AddToggle("kickonadmin", {Title = "Kick when Admin Join", Default = false })
    kickonadmintoggle:OnChanged(function(Value)
        autoleaveonmod = Value;
        if Value then
            for i, v in pairs(game.Players:GetPlayers()) do
                if (v ~= game.Players.LocalPlayer) then
                    if DefinePlayer(v.UserId) then
                        for i = 1, 5 do
                            game.Players.LocalPlayer:Kick("Admin / Mod is already in game! \r Shutdown game in " .. (5 - i) .. " seconds");
                            task.wait(1);
                        end
                        game:Shutdown();
                    end
                end
            end
        end
    end)

    local notifyadmintoggle = Tabs.detect:AddToggle("notifyadmin", {Title = "Notify when Admin Join", Default = true })
    notifyadmintoggle:OnChanged(function(Value)
        Notify = Value;
        if Value then
            for i, v in pairs(game.Players:GetPlayers()) do
                if (v ~= game.Players.LocalPlayer) then
                    if DefinePlayer(v.UserId) then
                        for i = 1, 1 do
                            Fluent:Notify({
                                Title = "Admin Detected!",
                                Content = "Leave the game to avoid a Ban!",
                                SubContent = "", -- Optional
                                Duration = 5 -- Set to nil to make the notification not disappear
                            });
                        end
                    end
                end
            end
        end
    end)

    Tabs.status:AddSection("Heists")
    local plane = Tabs.status:AddParagraph({
        Title = "Plane:",
        Content = "Loading..."  
    })
    local ship = Tabs.status:AddParagraph({
        Title = "Ship:",
        Content = "Loading..."
    })
    local bank = Tabs.status:AddParagraph({
        Title = "Bank:",
        Content = "Loading..."
    })
    local club = Tabs.status:AddParagraph({
        Title = "Club:",
        Content = "Loading..."
    })
    local jewelry = Tabs.status:AddParagraph({
        Title = "Jewelry:",
        Content = "Loading..."
    })
    local pyramid = Tabs.status:AddParagraph({
        Title = "Pyramid:",
        Content = "Loading..."
    })
    Tabs.status:AddSection("Player")
    local highbounty = Tabs.status:AddParagraph({
        Title = "Highest Bounty:",
        Content = "Loading..."
    })
    local highcash = Tabs.status:AddParagraph({
        Title = "Highest Cash:",
        Content = "Loading..."
    })
    local highlevel = Tabs.status:AddParagraph({
        Title = "Highest Level:",
        Content = "Loading..."
    })
    Tabs.status:AddSection("General")
    local curtime = Tabs.status:AddParagraph({
        Title = "Current Time:",
        Content = "Loading..."
    })
    local executor = Tabs.status:AddParagraph({
        Title = "Executor:",
        Content = identifyexecutor() or "Unknown"
    })
    local fpslab = Tabs.status:AddParagraph({
        Title = "FPS:",
        Content = math.round(workspace:GetRealPhysicsFPS())
    })
    local playerslab = Tabs.status:AddParagraph({
        Title = "Players:",
        Content = #game.Players:GetPlayers() .. "/" .. game.Players.MaxPlayers
    })
    local response = nil
    local req = http_request or request or (syn and syn.request);
    response = game:GetService("HttpService"):JSONDecode(req({Url=("https://users.roblox.com/v1/users/" .. game.Players.LocalPlayer.UserId)}).Body);
    Tabs.status:AddSection("Local Player")
    local namelab = Tabs.status:AddParagraph({
        Title = "Name:",
        Content = game.Players.LocalPlayer.Name
    })
    local displaylab = Tabs.status:AddParagraph({
        Title = "Display Name:",
        Content = game.Players.LocalPlayer.DisplayName
    })
    local useridlab = Tabs.status:AddParagraph({
        Title = "User ID:",
        Content = game.Players.LocalPlayer.UserId
    })
    local createdlab = Tabs.status:AddParagraph({
        Title = "Account Creation Date:",
        Content = response.created
    })
    Tabs.Tcredits:AddSection("Discord")
    Tabs.Tcredits:AddButton({
        Title = "Archie Hub",
        Description = "Click to Copy",
        Callback = function()
            setclipboard(tostring("discord.gg/B7YBTTRvj4"))
            Fluent:Notify({
                Title = "Archie Hub",
                Content = "Copied to Clipboard!",
                SubContent = "discord.gg/B7YBTTRvj4", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
        end
    })
    Tabs.Tcredits:AddSection("Credits")
    local creditslab = Tabs.Tcredits:AddParagraph({
        Title = "Script | deni210 & aymarko",
        Content = ""
    })
    local creditslab = Tabs.Tcredits:AddParagraph({
        Title = "Testing | evildragon0000",
        Content = ""
    })
    Tabs.Tcredits:AddSection("Version")
    local betaverslab = Tabs.Tcredits:AddParagraph({
        Title = "Version 1.2",
        Content = "Last Update 24/08/2023"
    })



    game:GetService("RunService").RenderStepped:Connect(function()
		for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
			if (v:IsA("Model") and (v.Name == "Crate")) then
				if v:FindFirstChild("Crate") then
					if (v.Crate:FindFirstChild("Parachute") and not v.Crate:FindFirstChildWhichIsA("BillboardGui")) then
						local cr = v.Crate;
						local billboardGui = Instance.new("BillboardGui");
						billboardGui.AlwaysOnTop = true;
						billboardGui.Size = UDim2.new(0, 100, 0, 100);
						billboardGui.StudsOffset = Vector3.new(0, 3, 0);
						billboardGui.Adornee = cr.Parent;
						local frame = Instance.new("Frame");
						frame.Size = UDim2.new(1, 0, 1, 0);
						frame.BackgroundTransparency = 1;
						frame.Parent = billboardGui;
						local imageLabel = Instance.new("ImageLabel");
						imageLabel.Size = UDim2.new(1, 0, 1, 0);
						imageLabel.Image = "rbxassetid://14318690497";
						imageLabel.BackgroundTransparency = 1;
						imageLabel.Parent = frame;
						billboardGui.Parent = cr;
						task.spawn(function()
							while task.wait(0.001) do
								if CrateESP then
									imageLabel.ImageTransparency = 0;
								else
									imageLabel.ImageTransparency = 0.999;
								end
							end
						end);
					end
				end
			end
		end
	end);
    game:GetService("UserInputService").JumpRequest:connect(function()
        if infjump then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping");
        end
    end);
    task.spawn(function()
        while true do
            if lesslag.isallowedtorunspawnloadstring then
                lesslag.isallowedtorunspawnloadstring = false
            end
            if lesslag.isallowedtorunrefreshesp then
                lesslag.isallowedtorunrefreshesp = false
                task.spawn(function()
                    ReflashESP()
                    task.wait(60)
                    lesslag.isallowedtorunrefreshesp = true
                end)
            end
            if lesslag.isallowedtorunheistcheck then
                lesslag.isallowedtorunheistcheck = false
                task.spawn(function()
                    curtime:SetDesc(os.date("%A, %B %d, %I:%M:%S %p", os.time()))
                    fpslab:SetDesc(math.round(workspace:GetRealPhysicsFPS()))
                    playerslab:SetDesc(#game.Players:GetPlayers() .. "/" .. game.Players.MaxPlayers)
                    if (#workspace.Heists.Plane:GetChildren() > 0) then
                        plane:SetDesc("Spawned");
                    else
                        plane:SetDesc("Not Spawned");
                    end
                    if workspace.Heists.Bank.Items.Chunk:FindFirstChild("Deposit") then
                        bank:SetDesc("Opened");
                    else
                        bank:SetDesc("Closed");
                    end
                    if (workspace.Heists.Club:FindFirstChild("Level1") or workspace.Heists.Club:FindFirstChild("Level2") or workspace.Heists.Club:FindFirstChild("Level3")) then
                        club:SetDesc("Opened");
                    else
                        club:SetDesc("Closed");
                    end
                    if (workspace.Heists["Jewelry Store"].Items.Diamonds.Containers.Glass:FindFirstChild("CanBeDamaged") or (#workspace.Heists["Jewelry Store"].Items.Vent:GetChildren() == 0)) then
                        jewelry:SetDesc("Opened");
                    else
                        jewelry:SetDesc("Closed");
                    end
                    if (workspace.Heists.Pyramid:FindFirstChild("Level1") or workspace.Heists.Pyramid:FindFirstChild("Level2")) then
                        pyramid:SetDesc("Opened");
                    else
                        pyramid:SetDesc("Closed");
                    end
                    if (workspace.Heists.Ship:FindFirstChild("Ship") or workspace.Heists.Ship:FindFirstChild("CollectMoney")) then
                        ship:SetDesc("Spawned");
                    else
                        ship:SetDesc("Not Spawned");
                    end
                    target, bounty = gethighestbounty(1, true);
                    highbounty:SetDesc(target.Name .. " ( " .. bounty .. " )");
                    target, cash = gethighestcash();
                    highcash:SetDesc(target .. " ( " .. cash .. " )");
                    target, level = gethighestlevel();
                    highlevel:SetDesc(target .. " ( " .. level .. " )");
                    task.wait(2)
                    lesslag.isallowedtorunheistcheck = true
                end)
            end
            if lesslag.isallowedtorunblackscreenproc then
                lesslag.isallowedtorunblackscreenproc = false
                task.spawn(function()
                    if noclipped == false or noclipped2 == false then
                        if (game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead) then
                            Fluent:Notify({
                                Title = "Archie Hub",
                                Content = "You Died, please wait...",
                                SubContent = "discord.gg/B7YBTTRvj4", -- Optional
                                Duration = 5 -- Set to nil to make the notification not disappear
                            })
                            task.wait(5.5);
                            override = true;
                            override2 = true;
                            task.wait(0.1);
                            game.Players.LocalPlayer.PlayerGui.BlackScreenGui.Enabled = false;
                            spawn(function()
                                task.wait(0.5);
                                override = false;
                                override2 = false;
                            end);
                        end
                    end
                    lesslag.isallowedtorunblackscreenproc = true
                end)
            end
            if lesslag.isallowedtoruncarflip then
                lesslag.isallowedtoruncarflip = false
                task.spawn(function()
                    if autocarflip then
                        if game.Players.LocalPlayer.Character.Humanoid.SeatPart then
                            Click("B", 0.1, 0);
                        end
                    end
                    lesslag.isallowedtoruncarflip = true
                end)
            end
            if lesslag.isallowedtorunspamhorn then
                lesslag.isallowedtorunspamhorn = false
                task.spawn(function()
                    if hornspam then
                        if game.Players.LocalPlayer.Character.Humanoid.SeatPart then
                            Click("H", 1, 0.1);
                            Click("H", 0.1, 0);
                        end
                    end
                    lesslag.isallowedtorunspamhorn = true
                end)
            end
            if lesslag.isallowedtorunboostspam then
                lesslag.isallowedtorunboostspam = false
                task.spawn(function()
                    if boostspam then
                        if game.Players.LocalPlayer.Character.Humanoid.SeatPart then
                            Click(Enum.KeyCode.LeftControl, 3.6, 0);
                            Click(Enum.KeyCode.LeftControl, 0.1);
                        end
                    end
                    lesslag.isallowedtorunboostspam = true
                end)
            end
            if lesslag.isallowedtorunshiftspam then
                lesslag.isallowedtorunshiftspam = false
                task.spawn(function()
                    if shiftspam then
                        if not game.Players.LocalPlayer.Character.Humanoid.SeatPart then
                            Click(Enum.KeyCode.LeftShift, 3, 0);
                            Click(Enum.KeyCode.LeftShift, 0.1);
                        end
                    end
                    lesslag.isallowedtorunshiftspam = true
                end)
            end
            if lesslag.isallowedtorunnoe then
                lesslag.isallowedtorunnoe = false
                task.spawn(function()
                    if noeloop then
                        setcooldown(0.001);
                    end
                    if antitaze then
                        rc.Unragdoll();
                        AeroUtil.Network:Fire("RagdollUpdate", false);
                    end
                    if infstamina then
                        u11.Stamina = 100
                    end
                    lesslag.isallowedtorunnoe = true
                end)
            end
            if lesslag.isallowedtorunsirenspam then
                lesslag.isallowedtorunsirenspam = false
                task.spawn(function()
                    if sirene then
                        if game.Players.LocalPlayer.Character.Humanoid.SeatPart then
                            Click("U", 0.01, 0);
                        end
                    end
                    lesslag.isallowedtorunsirenspam = true
                end)
            end
            if lesslag.isallowedtorunhumanoidloop then
                lesslag.isallowedtorunhumanoidloop = false
                task.spawn(function()
                    if enabledfff then
                        for i, v in next, game:GetService("Players"):GetPlayers() do
                            if (v.Name ~= game:GetService("Players").LocalPlayer.Name) then
                                if enabledfff then
                                    pcall(function()
                                        v.Character.HumanoidRootPart.Size = Vector3.new(HeadSize, HeadSize, HeadSize);
                                        v.Character.HumanoidRootPart.Transparency = 0.9;
                                        v.Character.HumanoidRootPart.BrickColor = BrickColor.new("White");
                                        v.Character.HumanoidRootPart.Material = "Neon";
                                        v.Character.HumanoidRootPart.CanCollide = false;
                                    end);
                                end
                            end
                        end
                    end
                    lesslag.isallowedtorunhumanoidloop = true
                end)
            end
            task.wait()
        end
    end)
end
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Archie Hub")
SaveManager:SetFolder("Mad City")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()

Tabs.Settings:AddSection("Developer Tools")
Tabs.Settings:AddButton({
    Title = "IY Dex",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))();
    end
})
Tabs.Settings:AddButton({
    Title = "BabyHamsta Dex",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end
})
Tabs.Settings:AddButton({
    Title = "Get Path Tool",
    Description = "",
    Callback = function()
        local Player = game:GetService("Players").LocalPlayer;
        local Tool = Instance.new("Tool");
        Tool.RequiresHandle = false;
        Tool.Name = "PathTool";
        Tool.Activated:Connect(function()
            print(game:GetService("Players").LocalPlayer:GetMouse().Target:GetFullName());
            setclipboard(game:GetService("Players").LocalPlayer:GetMouse().Target:GetFullName());
        end);
        Tool.Parent = Player.Backpack;
    end
})
Tabs.Settings:AddButton({
    Title = "Get Teleport Tool",
    Description = "",
    Callback = function()
        local Player = game:GetService("Players").LocalPlayer;
        local Mouse = Player:GetMouse();
        local Tool = Instance.new("Tool");
        Tool.RequiresHandle = false;
        Tool.Name = "TPTool";
        Tool.Activated:Connect(function()
            local Root = Player.Character.HumanoidRootPart;
            local Pos = Mouse.Hit.Position + Vector3.new(0, 2.5, 0);
            local Offset = Pos - Root.Position;
            Root.CFrame = Root.CFrame + Offset;
        end);
        Tool.Parent = Player.Backpack;
    end
})
Tabs.Settings:AddButton({
    Title = "Get Position (F9)",
    Description = "",
    Callback = function()
        print(game.Players.LocalPlayer.Character.HumanoidRootPart.Position);
        Fluent:Notify({
            Title = "Archie Hub",
            Content = "Your Position: " .. tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position),
            SubContent = "discord.gg/B7YBTTRvj4", -- Optional
            Duration = 5 -- Set to nil to make the notification not disappear
        })
    end
})
Tabs.Settings:AddButton({
    Title = "Copy Position (K)",
    Description = "",
    Callback = function()
        local cmdp = game:GetService("Players");
        local cmdlp = cmdp.LocalPlayer;
        local Mouses = cmdlp:GetMouse();
        cmdm = Mouses;
        cmdm.KeyDown:connect(function(key)
            if (key:lower() == "k") then
                setclipboard(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position));
            end
        end);
    end
})
