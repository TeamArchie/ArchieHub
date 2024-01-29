    local args = {
        [1] = "Dark Knight"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shop"):FireServer(unpack(args))