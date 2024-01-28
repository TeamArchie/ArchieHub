    local args = {
        [1] = "Barbarian"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shop"):FireServer(unpack(args))