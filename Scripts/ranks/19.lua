    local args = {
        [1] = "Sea King"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shop"):FireServer(unpack(args))