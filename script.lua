-- LUR HUB - THE LOADER (الموزع)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUR HUB ⚡ GEAR 5",
   LoadingTitle = "جاري تشغيل الأنظمة...",
   LoadingSubtitle = "بواسطة Leader150s",
})

local Tab = Window:CreateTab("🏠 الرئيسية", 4483362458)

Tab:CreateButton({
   Name = "تشغيل الأوتو فارم (من الملف الفرعي)",
   Callback = function()
      -- هذا السطر يروح ينادي الملف الثاني
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/main/MainFarm.lua"))()
   end,
})
