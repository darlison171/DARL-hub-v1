local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("ImageButton")
button.Size = UDim2.new(0, 80, 0, 80)
button.Position = UDim2.new(0.05, 0, 0.05, 0)
button.BackgroundTransparency = 1
button.Image = "rbxassetid://104487529937663"
button.ScaleType = Enum.ScaleType.Fit
button.Parent = gui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(1, 0)
uicorner.Parent = button

button.MouseButton1Click:Connect(function()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
end)

local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/vateq/UILIBrewrites/refs/heads/main/justtestin"))()
local win = SolarisLib:New({
  Name = "Meme Sea - By DYHUB",
  FolderToSave = "SolarisLibStuff"
})

local tab = win:Tab("AutoFarm")
local sec = tab:Section("AutoFarm")

local tab2 = win:Tab("Stats")
local sec2 = tab2:Section("Stats")

local tab6 = win:Tab("Shop")
local sec3 = tab6:Section("Buy/Redeem")

local tab3 = win:Tab("Auto Farm Spec")
local sec4 = tab3:Section("Auto Farm Boss")
local sec42 = tab3:Section("Auto Farm Specified")

local tab5 = win:Tab("Auto Raid")
local autoraidsec = tab5:Section("Auto Raid")

local tab4 = win:Tab("Settings")
local sec6 = tab4:Section("Settings")

_G.candyhub = {
    autofloppa = false,
    tokill = "Floppa",
    questmode = true,
    quest = "Floppa Quest 1",
    autos = true,
    allowbosses = true,
    devtest = true,
    platform = true,
    buyfruitmode = 'Money',
    stats_s = {},
    boss = false,
    weapon = 'Combat',
    memebeast = false,
    autoboss = false,
    tokill_level = 1,
    tokill_bosses = {},
    evilnoob = false,
    amount = 1,
    autoraid = false,
    monsters = {},
    autokillspec = false,
    tokill_monster = 'Red Sus',
}

local function getNil(name,class) 
    return game.Players.LocalPlayer.Character:FindFirstChildOfClass('Tool')
end

local function Press(key)
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, key, false, nil)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, key, false, nil)
end

local function click(cd)
    if not game.Players.LocalPlayer.Character:FindFirstChild(_G.candyhub.weapon) then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(_G.candyhub.weapon) then
            game.Players.LocalPlayer.Backpack:FindFirstChild(_G.candyhub.weapon).Parent = game.Players.LocalPlayer.Character
        end
    end
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton1(Vector2.new(10000,10000), game:GetService("Workspace").Camera.CFrame)
end

local function CheckQuest()
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('QuestGui') then
        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('QuestGui'):FindFirstChild('Holder') then
            if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('QuestGui'):FindFirstChild('Holder'):FindFirstChild('QuestSlot1') then
                return game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1.Visible
            end
        end
    end
end

local function SureQuest(QuestTarget)
    if game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1.QuestGiver.Text ~= QuestTarget then
        local args = {[1] = "Abandon_Quest",[2] = {["QuestSlot"] = "QuestSlot1"}}
        game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("QuestEvents"):WaitForChild("Quest"):FireServer(unpack(args))
    end
end

local function GetLevel()
    return game:GetService("Players").LocalPlayer.PlayerData.Level.Value
end

local function Lives()
    if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
            if game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') then
                if game.Players.LocalPlayer.Character:FindFirstChild('Humanoid').Health >= 1 then
                    return true
                else
                    return false
                end
            end
        end
    end
end

local function StoreEquippedFruit()
    if Lives() then
        local args = {[1] = "Eatable_Power",[2] = {["Action"] = "Store",["Tool"] = getNil("PowerName", "PowerClassName")}}
        game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules"):FireServer(unpack(args))
    end
end


local function UseAura()
    if Lives() then
        if game.Players.LocalPlayer.Character:FindFirstChild('AuraColor_Folder') then
            if not game.Players.LocalPlayer.Character:FindFirstChild('AuraColor_Folder'):FindFirstChild('LeftHand_AuraColor') then
                game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Ability"):InvokeServer('Aura')
            end
        end
    end
end

-- workspace.Island.MrBeastIsland.Paths:GetChildren()[12]

local function AreaCheck(level)
    if level >= 2200 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn9') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["MrBeast Island"].CFrame
        end
    elseif level >= 2100 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn9') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["MrBeast Island"].CFrame
        end
    elseif level >= 1900 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn8') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Pvp Arena"].CFrame
        end
    elseif level >= 1700 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn10') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Forgotten Island"].CFrame
        end
    elseif level >= 1450 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn7') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Sus Island"].CFrame
        end
    elseif level >= 1200 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn6') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Moai Island"].CFrame
        end
    elseif level >= 1150 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn7') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Sus Island"].CFrame
        end
    elseif level >= 950 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn5') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Pumpkin Island"].CFrame
        end
    elseif level >= 750 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn4') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Sand Island"].CFrame
        end
    elseif level >= 600 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn3') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Gorilla Island"].CFrame
        end
    elseif level >= 300 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn2') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Snow Island"].CFrame
        end
    elseif level >= 1 then
        if not workspace.NPCs.SetSpawn_Npc:FindFirstChild('SetSpawn1') and Lives() and _G.candyhub.autofloppa then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.SpawnLocations["Floppa Island"].CFrame
        end
    end
    --if Lives() then
    --    if _G.candyhub.autofloppa then
    --        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.QuestLocaion:FindFirstChild(_G.candyhub.quest).CFrame
    --    end
    --end
end

local function UseQuest(proximity)
    if identifyexecutor() == 'Solara' then
        fireproximityprompt(proximity, 5)
    elseif identifyexecutor() == 'Xeno' then
        fireproximityprompt(proximity, 5)
    else
        local VirtualInputManager = game:GetService("VirtualInputManager")
        VirtualInputManager:SendKeyEvent(true, "E", false, nil)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, "E", false, nil)
    end
end

local function GetQuest(npc)
    local u = 'Floppa Quest '
    if npc == 'Floppa' then
        return u..'1'
    elseif npc == 'Golden Floppa' then
        return u..'2'
    elseif npc == 'Big Floppa' then
        return u..'3' -- BOSS
    elseif npc == 'Doge' then
        return u..'4'
    elseif npc == 'Cheems' then
        return u..'5'
    elseif npc == 'Walter Dog' then
        return u..'6' -- BOSS
    elseif npc == 'Staring Fish' then
        return u..'7'
    elseif npc == 'Hamster' then
        return u..'8'
    elseif npc == 'Snow Tree' then
        return u..'9'
    elseif npc == 'The Rock' then
        return u..'10'
    elseif npc == 'Banana Cat' then
        return u..'11'
    elseif npc == 'Egg Dog' then
        return u..'13'
    elseif npc == 'Sus Face' then
        return u..'12' -- BOSS
    elseif npc == 'Popcat' then
        return u..'14'
    elseif npc == 'Gorilla King' then
        return u..'15' -- BOSS
    elseif npc == 'Smiling Cat' then
        return u..'16'
    elseif npc == 'Killerfish' then
        return u..'17'
    elseif npc == 'Bingus' then
        return u..'18'
    elseif npc == 'Obamid' then
        return u..'19' -- BOSS
    elseif npc == 'Floppy' then
        return u..'20'
    elseif npc == 'Creepy Head' then
        return u..'21'
    elseif npc == 'Scary Skull' then
        return u..'22'
    elseif npc == 'Pink Absorber' then
        return u..'24' -- BOSS
    elseif npc == 'Troll Face' then
        return u..'25'
    elseif npc == 'Uncanny Cat' then
        return u..'26'
    elseif npc == 'Quandale Dingle' then
        return u..'27'
    elseif npc == 'Moai' then
        return u..'28' -- BOSS
    elseif npc == 'Evil Noob' then
        return u..'29'
    elseif npc == 'Red Sus' then
        return u..'30'
    elseif npc == 'Sus Duck' then
        return u..'31'
    elseif npc == 'Lord Sus' then
        return u..'32'
    elseif npc == 'Sigma Man' then
        return u..'33'
    elseif npc == 'Dancing Cat' then
        return u..'34'
    elseif npc == 'Toothless Dragon' then
        return u..'35'
    elseif npc == 'Manly Nugget' then
        return u..'36'
    elseif npc == 'Huh Cat' then
        return u..'37'
    elseif npc == 'Mystical Tree' then
        return u..'38'
    elseif npc == 'Old Man' then
        return u..'39'
    elseif npc == 'Nyan Cat' then
        return u..'40'
    elseif npc == 'Baller' then
        return u..'41'
    elseif npc == 'Slicer' then
        return u..'42'
    elseif npc == 'Rick Roller' then
        return u..'43' -- BOSS
    elseif npc == 'Gigachad' then
        return u..'44'
    elseif npc == 'MrBeast' then
        return u..'45' -- BOSS
    elseif npc == 'Handsome Man' then
        return u..'46'
    elseif npc == 'Sogga' then
        return 'Dancing Banana Quest'
    else
        return ''
    end
end

local itemslist = {}
itemslist = {}
for i, item in game.Players.LocalPlayer.Backpack:GetChildren() do
    if not item.Name:match('Power') then
        table.insert(itemslist, tostring(item.Name))
    end
end


local weapondropdown = sec:Dropdown("AutoFarm Weapon: ", itemslist,"Combat","Dropdown", function(t)
    _G.candyhub.weapon = t
end)

sec:Button("Refresh Weapons List", function()
    itemslist = {}
    for i, item in game.Players.LocalPlayer.Backpack:GetChildren() do
        if not item.Name:match('Power') then
            table.insert(itemslist, tostring(item.Name))
        end
    end
    weapondropdown:Refresh(itemslist, true)
end)

local autofarmtoggle = sec:Toggle("Auto Farm", false,"Toggle", function(t)
    _G.candyhub.autofloppa = t
    while _G.candyhub.autofloppa and task.wait() do
        for i,monster in workspace.Monster:GetChildren() do
            if monster.Name == _G.candyhub.tokill then
                if monster:FindFirstChild("HumanoidRootPart") and monster:FindFirstChild("Humanoid") then
                    if Lives() then
                        if monster:FindFirstChild("Humanoid").Health >= 1 then
                            monster:FindFirstChild("HumanoidRootPart").Size=Vector3.new(17,17,17)
                            if _G.candyhub.devtest then
                                monster:FindFirstChild("HumanoidRootPart").Transparency = 0.8
                            end
                            SureQuest(_G.candyhub.quest)
                            if not CheckQuest() then
                                if workspace.NPCs.Quests_Npc:FindFirstChild(_G.candyhub.quest) then
                                    if Lives() and workspace.NPCs.Quests_Npc[_G.candyhub.quest]:FindFirstChild('Block') then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.QuestLocaion:FindFirstChild(_G.candyhub.quest).CFrame
                                        task.wait(0.1)
                                        UseQuest(workspace.NPCs.Quests_Npc[_G.candyhub.quest].Block:FindFirstChild('QuestPrompt'))
                                        UseQuest(workspace.NPCs.Quests_Npc[_G.candyhub.quest].Block:FindFirstChild('QuestPrompt'))
                                        task.wait(0.1)
                                    end
                                else
                                    if Lives() then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Location.QuestLocaion:FindFirstChild(_G.candyhub.quest).CFrame
                                    end
                                end
                            end
                            UseAura()
                            while monster:FindFirstChild("Humanoid").Health >= 1 and _G.candyhub.autofloppa and Lives() do
                                if monster:FindFirstChild("HumanoidRootPart") then
                                    monster:FindFirstChild("HumanoidRootPart").Size=Vector3.new(17,17,17)
                                    if _G.candyhub.devtest then
                                        monster:FindFirstChild("HumanoidRootPart").Transparency = 0.8
                                    end
                                end
                                if Lives() then
                                    monster:FindFirstChild("HumanoidRootPart").Size=Vector3.new(17,17,17)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = monster:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, -5, 8)
                                end
                                click(10)
                                task.wait()
                            end
                        end
                    end
                end
            end
        end
    end
end)

sec:Toggle("Allow Bosses", false,"Toggle", function(t)
    _G.candyhub.allowbosses = t
end)

local bringenemiestoggle = sec:Toggle("Bring Enemies (Ignore Bosses)", false,"Toggle", function(t)
    _G.candyhub.bringenemies = t
    while _G.candyhub.bringenemies and task.wait() do
        if _G.candyhub.autofloppa and not _G.candyhub.autoraid and not _G.candyhub.autokillspec then
            for i, monster in workspace.Monster:GetChildren() do
                if monster:FindFirstChild('Humanoid') then
                    if monster:FindFirstChild('Humanoid').Health >= 1 then
                        if monster:FindFirstChild('HumanoidRootPart') and Lives()then
                            if monster.Name == _G.candyhub.tokill and not _G.candyhub.boss then
                                if workspace.NPCs.Quests_Npc:FindFirstChild(_G.candyhub.quest) then
                                    --task.wait(0.5)
                                    if Lives() and workspace.NPCs.Quests_Npc[_G.candyhub.quest]:FindFirstChild('Block') then
                                        monster:FindFirstChild('HumanoidRootPart').CFrame = workspace.NPCs.Quests_Npc[_G.candyhub.quest].Block.CFrame * CFrame.new(0,8,0)
                                        --monster:FindFirstChild('HumanoidRootPart').CFrame = workspace.Location.Enemy_Location:FindFirstChild(monster.Name).CFrame * CFrame.new(0,6,0)
                                    end
                                end
                                --monster:FindFirstChild('HumanoidRootPart').CFrame = workspace.NPCs.Quests_Npc[_G.candyhub.quest].Block.CFrame * CFrame.new(0,5,-8)
                            end
                        end
                    end
                end
            end
        elseif _G.candyhub.autoraid and not _G.candyhub.autofloppa and not _G.candyhub.autokillspec then
            for i, monster in workspace.Monster:GetChildren() do
                if monster:FindFirstChild('Humanoid') then
                    if monster:FindFirstChild('Humanoid').Health >= 1 then
                        if monster:FindFirstChild('HumanoidRootPart') and Lives()then
                            if monster.Name == 'Floppa Man' or monster.Name == 'Epic Doge' or monster.Name == 'Speedy Cheems' or monster.Name == 'Tanky Moai' or monster.Name == 'Killer Nugget' or monster.Name == 'The Stone' or monster.Name == 'Capybara' then
                                if Lives() then
                                    if game.Players.LocalPlayer:GetAttribute('Raiding') ~= '' then
                                        monster:FindFirstChild('HumanoidRootPart').CFrame = workspace.Raids:FindFirstChild('Raid_'..game.Players.LocalPlayer:GetAttribute('Raiding')).Statue.Floppa.CFrame * CFrame.new(0,28,-10)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        elseif _G.candyhub.autokillspec and not _G.candyhub.autofloppa and not _G.candyhub.autoraid then
            for i, monster in workspace.Monster:GetChildren() do
                if monster:FindFirstChild('Humanoid') then
                    if monster:FindFirstChild('Humanoid').Health >= 1 then
                        if monster:FindFirstChild('HumanoidRootPart') and Lives()then
                            if monster.Name == _G.candyhub.tokill_monster then
                                if Lives() then
                                    monster:FindFirstChild('HumanoidRootPart').CFrame = workspace.Location.Enemy_Location:FindFirstChild(monster.Name).CFrame * CFrame.new(0,10,0)
                                end
                            end
                        end
  
