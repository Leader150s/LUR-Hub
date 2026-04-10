local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "DMS HUB | اختيار السلاح",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" 
})

local MainTab = Window:CreateTab("🏠 القائمة", 4483362458)

MainTab:CreateSection("⚔️ إعدادات الفارم")

-- متغيرات الاختيار
_G.Weapon = "أسلوب قتال" -- السلاح الافتراضي
_G.farming = false

MainTab:CreateToggle({
   Name = "تشغيل التلفيل التلقائي",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
      end
   end,
})

-- قائمة اختيار السلاح
MainTab:CreateDropdown({
   Name = "إختر السلاح المستخدم",
   Options = {"Melee","Sword","Blox Fruit"},
   CurrentOption = {"Melee"},
   MultipleOptions = false,
   Flag = "WeaponDropdown",
   Callback = function(Option)
      _G.Weapon = Option[1]
      Rayfield:Notify({Title = "DMS HUB", Content = "تم اختيار: " .. _G.Weapon, Duration = 2})
   end,
})

MainTab:CreateSection("شخصية نيكا (DMS)")
MainTab:CreateImage({
   Name = "Luffy",
   Image = "rbxassetid://13426210080", 
   Size = UDim2.new(0, 200, 0, 200),
})
