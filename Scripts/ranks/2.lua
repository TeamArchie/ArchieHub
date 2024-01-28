    local args = {
        [1] = "Marauder"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shop"):FireServer(unpack(args))