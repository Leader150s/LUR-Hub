local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "DMS HUB | GEAR 5",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false,
   -- تعديل الثيم ليكون أكثر وضوحاً
   Theme = "DarkBlue", 
})

-- قسم الرئيسية
local MainTab = Window:CreateTab("🏠 الرئيسية", 4483362458) 

-- إضافة "بانر" أو صورة لوفي في البداية
MainTab:CreateParagraph({Title = "👑 مرحباً بك يا ملك القراصنة", Content = "DMS HUB هو رفيقك لتختيم اللعبة!"})

-- محاولة إظهار صورة لوفي Gear 5 (رابط مباشر)
MainTab:CreateImage({
   Name = "LuffyGear5",
   Image = "http://www.roblox.com/asset/?id=13426210080", -- رابط أصل الصورة
   Size = UDim2.new(0, 250, 0, 250),
})

-- قسم القتال (هنا الأزرار اللي طلبتها)
local CombatTab = Window:CreateTab("⚔️ القتال", 4483362458)

CombatTab:CreateSection("أدوات التلفيل (Farm)")

CombatTab:CreateToggle({
   Name = "تشغيل الأوتو فارم (تحديث نيكا 🛡️)",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          -- استدعاء ملف الفاروم الفرعي
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
          Rayfield:Notify({Title = "DMS HUB", Content = "تم تفعيل محرك نيكا! بدأت الرحلة..", Duration = 5})
      end
   end,
})

-- زر إضافي للسرعة
CombatTab:CreateSlider({
   Name = "سرعة الضرب (Spam)",
   Min = 0,
   Max = 100,
   CurrentValue = 50,
   Flag = "Slider1",
   Callback = function(Value)
      -- هنا نربط قيمة السرعة بالكود لاحقاً
   end,
})
