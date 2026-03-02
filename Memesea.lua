local player = game.Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowNexus"
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 420, 0, 320)
main.Position = UDim2.new(0.5, -210, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0,15)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0,255,120)
stroke.Thickness = 2

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "SHADOW NEXUS"
title.TextColor3 = Color3.fromRGB(0,255,120)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- Close Button
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0,35,0,35)
close.Position = UDim2.new(1,-40,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(40,0,0)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

close.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

-- Container
local container = Instance.new("Frame", main)
container.Size = UDim2.new(1,-30,1,-70)
container.Position = UDim2.new(0,15,0,55)
container.BackgroundTransparency = 1

-- Variables
local AutoFarm = false
local AutoRebirth = false

-- Button Function
local function createButton(text, y, callback)
	local btn = Instance.new("TextButton", container)
	btn.Size = UDim2.new(1,0,0,45)
	btn.Position = UDim2.new(0,0,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
	
	btn.MouseButton1Click:Connect(function()
		callback(btn)
	end)
end

-- Auto Farm
createButton("Auto Farm: OFF", 0, function(btn)
	AutoFarm = not AutoFarm
	btn.Text = "Auto Farm: " .. (AutoFarm and "ON" or "OFF")
end)

-- Auto Rebirth
createButton("Auto Rebirth: OFF", 60, function(btn)
	AutoRebirth = not AutoRebirth
	btn.Text = "Auto Rebirth: " .. (AutoRebirth and "ON" or "OFF")
end)

-- Teleport Sell
createButton("Teleport Sell", 120, function()
	if workspace:FindFirstChild("SellZone") and player.Character then
		player.Character:MoveTo(workspace.SellZone.Position)
	end
end)

-- System Loop
task.spawn(function()
	while true do
		task.wait(0.5)
		
		local stats = player:FindFirstChild("leaderstats")
		if stats then
			local level = stats:FindFirstChild("Level")
			local coins = stats:FindFirstChild("Coins")
			local rbm = stats:FindFirstChild("RBM")
			
			if AutoFarm and level and coins then
				level.Value += 1
				coins.Value += level.Value * 2
			end
			
			if AutoRebirth and level and coins and rbm then
				if level.Value >= 35 and coins.Value >= 35000 then
					level.Value = 0
					coins.Value = 0
					rbm.Value += 1
				end
			end
		end
	end
end)
