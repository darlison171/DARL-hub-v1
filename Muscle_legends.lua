local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
	Name = "💪 Muscle Legends | Bug do Ouriço Laranja",
	LoadingTitle = "Carregando UI...",
	LoadingSubtitle = "By Darlison",
	ConfigurationSaving = {
		Enabled = true
	},
	KeySystem = false
})

local Aba = Janela:CreateTab("🐾 Bug Pet", 4483362458)
Aba:CreateSection("Orange Hedgehog – Boost de Força")


local vezes = 100
local delay = 0.05

Aba:CreateSlider({
	Name = "Quantas vezes executar",
	Range = {10, 300},
	Increment = 10,
	Suffix = "x",
	CurrentValue = vezes,
	Flag = "vezes",
	Callback = function(val)
		vezes = val
	end
})

Aba:CreateSlider({
	Name = "Delay entre cada loop",
	Range = {0.01, 0.3},
	Increment = 0.01,
	Suffix = "s",
	CurrentValue = delay,
	Flag = "delay",
	Callback = function(val)
		delay = val
	end
})

Aba:CreateButton({
	Name = "🔥 Bugar Força com Orange Hedgehog",
	Callback = function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local equipPet = ReplicatedStorage:WaitForChild("Events"):WaitForChild("EquipPet")
		local unequipPet = ReplicatedStorage:WaitForChild("Events"):WaitForChild("UnequipPet")
		local petName = "Orange Hedgehog"

		for i = 1, vezes do
			pcall(function()
				unequipPet:FireServer(petName)
				wait(0.05)
				equipPet:FireServer(petName)
			end)
			wait(delay)
		end

		Rayfield:Notify({
			Title = "✅ Bug finalizado!",
			Content = "Boost de força aplicado!",
			Duration = 5,
			Image = 4483362458
		})
	end
})

-- Botão para fechar a UI
Aba:CreateButton({
	Name = "❌ Fechar Interface",
	Callback = function()
		Rayfield:Destroy()
	end
})
