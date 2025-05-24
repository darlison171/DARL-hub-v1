-- Carregar OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Criar a janela
local Window = OrionLib:MakeWindow({
    Name = "Meme Sea Hub", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "MemeSeaConfig"
})

-- Variável de controle
local exemploToggle = false

-- Função de exemplo
function exemploFuncao()
    while exemploToggle do
        print("Toggle ativada!")
        task.wait(1)
    end
end

-- Criar uma aba
local MainTab = Window:MakeTab({
    Name = "Principal", 
    Icon = "rbxassetid://4483345998", 
    PremiumOnly = false
})

-- Criar uma Toggle
MainTab:AddToggle({
    Name = "Exemplo de Toggle",
    Default = false,
    Callback = function(Value)
        exemploToggle = Value
        if Value then
            exemploFuncao()
        end
    end
})

-- Inicializar a UI
OrionLib:Init()