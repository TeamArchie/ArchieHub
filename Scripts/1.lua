local args = {
    [1] = "Viking"
}

game:GetService("ReplicatedStorage"):WaitForChild("Shop"):FireServer(unpack(args))