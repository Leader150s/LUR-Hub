local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "DMS HUB | نظام المربع المدمر",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" 
})

local MainTab = Window:CreateTab("🏠 القائمة", 4483362458)

MainTab:CreateSection("⚔️ إعدادات الفارم والمربع")

_G.farming = false
_G.Weapon = ""

-- تحديث قائمة الأسلحة تلقائياً حسب ما تحمله
local function getWeapons()
    local weapons = {}
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then table.insert(weapons, v.Name) end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then table.insert(weapons, v.Name) end
    end
    return weapons
end

MainTab:CreateToggle({
   Name = "تشغيل المربع المدمر (Kill Aura + Farm)",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
      end
   end,
})

MainTab:CreateDropdown({
   Name = "إختر سلاحك (الذي تملكه الآن)",
   Options = getWeapons(),
   CurrentOption = {""},
   MultipleOptions = false,
   Callback = function(Option)
      _G.Weapon = Option[1]
   end,
})

-- زر لتحديث قائمة الأسلحة إذا شريت شيء جديد
MainTab:CreateButton({
   Name = "تحديث قائمة الأسلحة",
   Callback = function()
      -- الكود يحدثها تلقائياً عند الاختيار
   end,
})
