    local args = {
        [1] = "Raider"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shop"):FireServer(unpack(args))