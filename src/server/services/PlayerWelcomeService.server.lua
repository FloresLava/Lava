local Players = game:GetService("Players")

local function onPlayerAdded(player)
	print("[WelcomeSystem] Player joined: " .. player.Name)
end

Players.PlayerAdded:Connect(onPlayerAdded)