local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "DMS HUB | نظام المهمات الذكي",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" 
})

local MainTab = Window:CreateTab("🏠 الرئيسية", 4483362458)

_G.farming = false
_G.Weapon = ""

local function getMyTools()
    local t = {}
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then table.insert(t, v.Name) end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then table.insert(t, v.Name) end
    end
    return t
end

MainTab:CreateToggle({
   Name = "⚔️ تشغيل الفاروم حسب اللفل (دمج حقيقي)",
   CurrentValue = false,
   Flag = "SmartFarm",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
      end
   end,
})

MainTab:CreateDropdown({
   Name = "إختر سلاحك",
   Options = getMyTools(),
   CurrentOption = {""},
   MultipleOptions = false,
   Callback = function(Option)
      _G.Weapon = Option[1]
   end,
})

-- تثبيت السلاح بقوة
task.spawn(function()
    while true do
        task.wait(0.1)
        if _G.farming and _G.Weapon ~= "" then
            pcall(function()
                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(_G.Weapon)
                if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
            end)
        end
    end
end)
