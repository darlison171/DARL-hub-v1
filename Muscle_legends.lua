-- Configuração da janela Rayfield com Key System e Discord Invite completo
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Nexus Hub | Blox Fruits",
   LoadingTitle = "Carregando Nexus Hub...",
   LoadingSubtitle = "by Darlison",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NexusHub",
      FileName = "NexusSettings"
   },
   Discord = {
      Enabled = true,
      Invite = "https://discord.gg/rUApaHer7e", -- link completo do Discord
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Nexus Hub - Key System",
      Subtitle = "A Key está no canal 📌・key do Discord",
      Note = "Key atual: NEXUS-2025",
      FileName = "NexusKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = "NEXUS-2025"
   }
})

-- Continua o resto do script normalmente