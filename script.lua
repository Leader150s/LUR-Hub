local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "DMS HUB | GEAR 5",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false,
   -- هنا سر اللون الأزرق الملكي الداكن
   Theme = "Ocean", 
})

-- قسم الرئيسية مع أيقونة لوفي
local MainTab = Window:CreateTab("🏠 الرئيسية", 4483362458) 

MainTab:CreateSection("لوحة تحكم DMS")

MainTab:CreateLabel("مرحباً بك يا ملك القراصنة!")

-- إضافة صورة لوفي (جرب هذا الرابط المباشر)
MainTab:CreateImage({
   Name = "LuffyGear5",
   Image = "rbxassetid://13426210080", -- آيدي صورة لوفي Gear 5 من روبلوكس
   Size = UDim2.new(0, 200, 0, 200),
})

-- قسم القتال (المهم)
local CombatTab = Window:CreateTab("⚔️ القتال", 4483362458)

CombatTab:CreateSection("تطوير المستوى (Farm)")

CombatTab:CreateToggle({
   Name = "تشغيل الأوتو فارم (DMS Safe)",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
          Rayfield:Notify({Title = "DMS HUB", Content = "تم تفعيل الهاكي الملكي.. جاري التلفيل!", Duration = 5})
      end
   end,
})

-- قسم الإعدادات
local SettingsTab = Window:CreateTab("⚙️ الإعدادات", 4483362458)
SettingsTab:CreateSection("تحكم في الواجهة")

SettingsTab:CreateButton({
   Name = "إغلاق السكربت",
   Callback = function()
       Rayfield:Destroy()
   end,
})
