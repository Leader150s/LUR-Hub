local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "DMS HUB | نظام الدمج التلقائي",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" 
})

local MainTab = Window:CreateTab("🏠 القائمة", 4483362458)

_G.farming = false
_G.Weapon = ""

-- تحديث تلقائي لقائمة أسلحتك
local function getTools()
    local tools = {}
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then table.insert(tools, v.Name) end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then table.insert(tools, v.Name) end
    end
    return tools
end

MainTab:CreateToggle({
   Name = "⚔️ تشغيل الأوتو دمج + فارم",
   CurrentValue = false,
   Flag = "AutoDamageToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
      end
   end,
})

MainTab:CreateDropdown({
   Name = "إختر سلاح الدمج",
   Options = getTools(),
   CurrentOption = {""},
   MultipleOptions = false,
   Callback = function(Option)
      _G.Weapon = Option[1]
   end,
})
