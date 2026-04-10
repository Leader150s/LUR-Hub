local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "DMS HUB | GEAR 5",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" 
})

local MainTab = Window:CreateTab("🏠 القائمة", 4483362458)

_G.farming = false
MainTab:CreateToggle({
   Name = "⚔️ تشغيل الفارم المطور (الملف الفرعي)",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          -- هنا الربط مع ملفك الثاني
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
      end
   end,
})

MainTab:CreateSection("شخصية نيكا (DMS)")
MainTab:CreateImage({
   Name = "Luffy",
   Image = "rbxassetid://13426210080", 
   Size = UDim2.new(0, 200, 0, 200),
})
