-- 📦 DARLhub - Muscle Legends (com Fluent UI) -- Requer executor KRNL ou similar

-- 🧱 Carrega Fluent UI 
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2Swiftz/UI-Library/main/Libraries/FluentUI-Example.lua"))()

local window = Fluent:CreateWindow({ Title = "💪 DARLhub | Muscle Legends", SubTitle = "By Darlison", TabWidth = 160, Size = UDim2.fromOffset(600, 400), Theme = "Dark" })

-- 🌟 Variáveis Globais
local vezesBug = 150 local delayBug = 0.05 local autoFarm = false local autoRebirth = false local autoEquip = false local autoOrb = false local xpAtual = 0 local maxXP = 250 local glitchNotificado = false

-- 🔁 Loops de funcionalidades 
spawn(function() while true do if autoFarm then game:GetService("ReplicatedStorage").Events.Train:FireServer("Bench Press") end wait(0.2) end end)

spawn(function() while true do if autoRebirth then game:GetService("ReplicatedStorage").Events.Rebirth:FireServer() end wait(1) end end)

spawn(function() while true do if autoEquip then game:GetService("ReplicatedStorage").Events.EquipPet:FireServer("Orange Hedgehog") end wait(2) end end)

spawn(function() while true do if autoOrb then for _, v in pairs(workspace.Orbs:GetChildren()) do if v:IsA("Model") and v:FindFirstChild("TouchInterest") then firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0) wait() firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1) end end end wait(1.5) end end)

spawn(function() while true do xpAtual += 1 if xpAtual >= maxXP - 1 and not glitchNotificado then glitchNotificado = true Fluent:Notify({Title = "🔥 Glitch Pronto", Content = "Seu pet está quase upando!", Duration = 5}) end wait(1.2) end end)

-- 🐾 Aba Pets 
local tabPets = window:AddTab({Title = "🐾 Pets"})

local petSection = tabPets:AddSection("Orange Hedgehog") petSection:AddSlider("Repetições do Glitch", {Min = 10, Max = 300, Default = vezesBug}, function(v) vezesBug = v end)

petSection:AddSlider("Delay entre Equips", {Min = 0.01, Max = 0.3, Default = delayBug}, function(v) delayBug = v end)

petSection:AddButton("🔥 Bugar Pet", function() local rs = game:GetService("ReplicatedStorage") local equip = rs:WaitForChild("Events"):WaitForChild("EquipPet") local unequip = rs:WaitForChild("Events"):WaitForChild("UnequipPet") for i = 1, vezesBug do unequip:FireServer("Orange Hedgehog") wait(delayBug) equip:FireServer("Orange Hedgehog") wait(delayBug) end Fluent:Notify({Title = "✅ Concluído", Content = "Boost aplicado."}) end)

-- 💪 Aba de Farm local 
tabFarm = window:AddTab({Title = "💪 Farm"})

local farmSection = tabFarm:AddSection("Auto Farm") farmSection:AddToggle("Ativar Auto Farm", autoFarm, function(v) autoFarm = v end)

farmSection:AddToggle("Auto Rebirth", autoRebirth, function(v) autoRebirth = v end)

farmSection:AddToggle("Auto Equipar Ouriço", autoEquip, function(v) autoEquip = v end)

farmSection:AddToggle("Auto Coletar Orbs", autoOrb, function(v) autoOrb = v end)

-- 🔔 Aba XP local 
tabGlitch = window:AddTab({Title = "🔔 Glitch"}) local glitchSection = tabGlitch:AddSection("Monitor XP")

glitchSection:AddSlider("XP Máximo Simulado", {Min = 100, Max = 500, Default = maxXP}, function(v) maxXP = v end)

glitchSection:AddButton("Resetar XP Simulado", function() xpAtual = 0 glitchNotificado = false Fluent:Notify({Title = "Resetado", Content = "XP zerado"}) end)

-- ❌ Fechar local 
tabFechar = window:AddTab({Title = "❌ Fechar"}) tabFechar:AddButton("Fechar UI", function() window:Close() end)