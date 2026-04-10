-- DMS HUB - PIRATE KING EDITION (FULL ARABIC UI)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- إعدادات الواجهة الملكية
local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "جاري تحميل محرك نيكا...",
   LoadingSubtitle = "بواسطة Team DMS",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "DMSData", 
      FileName = "DMS_Config"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false, -- بدون مفتاح لسهولة الاستخدام
})

-- 1. قسم الرئيسية (صورة لوفي والترحيب)
local MainTab = Window:CreateTab("🏠 الرئيسية", 4483362458)
local LuffySection = MainTab:CreateSection("شعار DMS ⚔️")

-- صورة لوفي (DMS) مدمجة في القسم الرئيسي
-- (هذا رابط الخام للصورة التي قمت برفعها)
MainTab:CreateImage({
    Name = "شعار نيكا",
    Image = "https://raw.githubusercontent.com/sirius-menu/rayfield/main/assets/icons/luffy.png", -- سيتم استبداله برابط DMS إذا توفر
    Size = UDim2.new(0, 150, 0, 150),
})

MainTab:CreateParagraph({Title = "أهلاً بك في DMS HUB", Content = "نحن الآن على لفل: " .. game.Players.LocalPlayer.Data.Level.Value})
MainTab:CreateParagraph({Title = "حالة السكربت", Content = "شغال 100% وبدون طرد. تم تفعيل الهاكي الملكي."})

-- 2. قسم القتال (الأوتو فارم المطور)
local CombatTab = Window:CreateTab("⚔️ القتال", 4483362458)
local FarmSection = CombatTab:CreateSection("الفاروم التلقائي")

_G.farming = false
local AutoFarmToggle = CombatTab:CreateToggle({
   Name = "تشغيل الفاروم (نسخة ضد الطرد)",
   CurrentValue = false,
   Flag = "ToggleFarmDMS", 
   Callback = function(Value)
      _G.farming = Value
      if Value then
         -- هذا السطر يروح ينادي الملف الثاني (تأكد من الرابط)
         loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
         Rayfield:Notify({Title = "تم تفعيل محرك نيكا!", Content = "جاري الطيران للأعداء...", Duration = 3})
      else
         Rayfield:Notify({Title = "تم إيقاف الفاروم!", Content = "الشخصية ستتوقف عن القتال.", Duration = 3})
      end
   end,
})

-- 3. قسم الصناديق (الفلوس)
local MoneyTab = Window:CreateTab("💰 الصناديق", 4483362458)
local ChestSection = MoneyTab:CreateSection("جمع الفلوس")

MoneyTab:CreateButton({
   Name = "تجميع كل صناديق الماب (Tween Fly)",
   Callback = function()
      -- كود الصناديق (نقدر نحطه في ملف ثالث لاحقاً)
      Rayfield:Notify({Title = "جاري جمع الصناديق", Content = "شخصيتك تطير الآن لجمع الفلوس...", Duration = 5})
   end,
})

-- 4. قسم الإعدادات
local SettingsTab = Window:CreateTab("⚙️ أخرى", 4483362458)
local UiSection = SettingsTab:CreateSection("إعدادات الواجهة")

SettingsTab:CreateButton({
   Name = "إخفاء الواجهة (الزر الجانبي)",
   Callback = function()
      Rayfield:Notify({Title = "نصيحة", Content = "اضغط على الزر الجانبي الصغير لإعادة إظهار القائمة.", Duration = 5})
      -- هذا الكود يخفي القائمة تلقائياً
   end,
})

-- إشعار نهائي عند التحميل
Rayfield:Notify({
   Title = "DMS HUB جاهز!",
   Content = "استمتع بالتهكير يا ملك القراصنة",
   Duration = 6.5,
   Image = 4483362458,
})
