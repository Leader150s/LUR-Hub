local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- إعداد النافذة الرئيسية
local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار قواعد البيانات",
   LoadingTitle = "DMS HUB | جاري تحميل البيانات",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" 
})

local MainTab = Window:CreateTab("🏠 الرئيسية", 4483362458)

_G.farming = false
_G.Weapon = ""

-- وظيفة ذكية لجلب أسلحتك الحالية فقط
local function getMyTools()
    local tools = {}
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then table.insert(tools, v.Name) end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then table.insert(tools, v.Name) end
    end
    return tools
end

-- زر التشغيل (يربط الواجهة بقاعدة البيانات في الملف الثاني)
MainTab:CreateToggle({
   Name = "⚔️ تشغيل الفارم الذكي (قواعد البيانات)",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          -- استدعاء ملف القاعدة من GitHub
          loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/MainFarm.lua"))()
      end
   end,
})

-- قائمة اختيار السلاح
MainTab:CreateDropdown({
   Name = "إختر سلاحك (سيف / فاكهة / أسلوب)",
   Options = getMyTools(),
   CurrentOption = {""},
   MultipleOptions = false,
   Callback = function(Option)
      _G.Weapon = Option[1]
      Rayfield:Notify({
         Title = "تم اختيار السلاح",
         Content = "السلاح المعتمد الآن: " .. _G.Weapon,
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- [[ نظام تثبيت السلاح القوي ]]
-- هذا الكود يمنع السلاح من النزول من يدك أثناء التلفيل
task.spawn(function()
    while true do
        task.wait(0.1)
        if _G.farming and _G.Weapon ~= "" then
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local pack = game.Players.LocalPlayer.Backpack
                local tool = pack:FindFirstChild(_G.Weapon)
                if tool then
                    char.Humanoid:EquipTool(tool)
                end
            end)
        end
    end
end)

MainTab:CreateSection("📊 معلومات السيرفر")
MainTab:CreateLabel("المستوى الحالي: " .. game.Players.LocalPlayer.Data.Level.Value)

Rayfield:Notify({
   Title = "جاهز للعمل!",
   Content = "اختر سلاحك ثم فعل الفارم ليبدأ السكربت بالعمل حسب القاعدة",
   Duration = 5,
   Image = 4483362458,
})
