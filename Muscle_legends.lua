--// Nexus Hub - Zombie Attack Edition
local NexusUI = Instance.new("ScreenGui")
local OpenBtn = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local TabHolder = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")

NexusUI.Name = "NexusHub"
NexusUI.ResetOnSpawn = false
NexusUI.Parent = game:GetService("CoreGui")

-- Botão flutuante
OpenBtn.Name = "OpenBtn"
OpenBtn.Text = "⚙"
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -22)
OpenBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 70)
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Font = Enum.Font.GothamBlack
OpenBtn.TextScaled = true
OpenBtn.ZIndex = 10
OpenBtn.Parent = NexusUI

-- Janela principal
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 320)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = NexusUI

-- Topo
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(40, 0, 70)
TopBar.Parent = MainFrame

Title.Name = "Title"
Title.Text = "Nexus Hub | Zombie Attack"
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = TopBar

CloseBtn.Name = "CloseBtn"
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, 40, 1, 0)
CloseBtn.Position = UDim2.new(1, -45, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 40)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextScaled = true
CloseBtn.Parent = TopBar

-- Abas
TabHolder.Name = "TabHolder"
TabHolder.Size = UDim2.new(0, 120, 1, -40)
TabHolder.Position = UDim2.new(0, 0, 0, 40)
TabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabHolder.Parent = MainFrame

-- Conteúdo
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -120, 1, -40)
ContentFrame.Position = UDim2.new(0, 120, 0, 40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.Parent = MainFrame

-- Abrir/Fechar
OpenBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	OpenBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	OpenBtn.Visible = true
end)

-- Função criar Tab
local function CreateTab(tabName, callback)
	local TabButton = Instance.new("TextButton")
	TabButton.Text = tabName
	TabButton.Size = UDim2.new(1, 0, 0, 40)
	TabButton.BackgroundColor3 = Color3.fromRGB(45, 0, 70)
	TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.Font = Enum.Font.Gotham
	TabButton.TextScaled = true
	TabButton.Parent = TabHolder

	TabButton.MouseButton1Click:Connect(function()
		for _, v in pairs(ContentFrame:GetChildren()) do
			if v:IsA("GuiObject") then v:Destroy() end
		end
		callback(ContentFrame)
	end)
end

-- Funções Extras (Botão, Toggle)
local function CreateButton(parent, text, callback)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 50)
	btn.BackgroundColor3 = Color3.fromRGB(50, 0, 90)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.Parent = parent
	btn.MouseButton1Click:Connect(callback)
end

local function CreateToggle(parent, text, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -20, 0, 40)
	frame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 50)
	frame.BackgroundColor3 = Color3.fromRGB(50, 0, 90)
	frame.Parent = parent

	local label = Instance.new("TextLabel")
	label.Text = text
	label.Size = UDim2.new(0.7, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.Parent = frame

	local toggleBtn = Instance.new("TextButton")
	toggleBtn.Size = UDim2.new(0.3, -5, 1, -10)
	toggleBtn.Position = UDim2.new(0.7, 5, 0, 5)
	toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 50)
	toggleBtn.Text = "OFF"
	toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
	toggleBtn.Font = Enum.Font.GothamBold
	toggleBtn.TextScaled = true
	toggleBtn.Parent = frame

	local state = false
	toggleBtn.MouseButton1Click:Connect(function()
		state = not state
		toggleBtn.Text = state and "ON" or "OFF"
		toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(100, 0, 50)
		callback(state)
	end)
end

--// Abas com funções para Zombie Attack

-- Auto Farm
CreateTab("Auto Farm", function(parent)
	CreateToggle(parent, "Auto Kill Zombies", function(state)
		getgenv().AutoKill = state
		while getgenv().AutoKill and task.wait() do
			for _, mob in pairs(workspace:GetChildren()) do
				if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("Head") then
					game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Hit", mob.Humanoid, 1000)
				end
			end
		end
	end)

	CreateToggle(parent, "Auto Pickup Drops", function(state)
		getgenv().AutoPick = state
		while getgenv().AutoPick and task.wait() do
			for _, drop in pairs(workspace.Drops:GetChildren()) do
				if drop:IsA("BasePart") then
					game.Players.LocalPlayer.Character:MoveTo(drop.Position)
				end
			end
		end
	end)
end)

-- Player
CreateTab("Player", function(parent)
	CreateButton(parent, "God Mode", function()
		local char = game.Players.LocalPlayer.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid.MaxHealth = math.huge
			char.Humanoid.Health = math.huge
		end
	end)

	CreateButton(parent, "Speed x2", function()
		local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
		if hum then hum.WalkSpeed = hum.WalkSpeed * 2 end
	end)
end)

-- Teleport
CreateTab("Teleport", function(parent)
	CreateButton(parent, "Spawn", function()
		game.Players.LocalPlayer.Character:MoveTo(Vector3.new(0,5,0))
	end)

	CreateButton(parent, "Safe Zone", function()
		game.Players.LocalPlayer.Character:MoveTo(Vector3.new(100,10,100))
	end)
end)