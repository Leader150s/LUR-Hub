-- DMS HUB - ALL IN ONE (النسخة الكاملة النهائية)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "جاري تشغيل محرك نيكا الأسطوري...",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" -- هذا اللون الأزرق الملكي الداكن
})

-- متغيرات الفاروم
_G.farming = false

-- وظيفة الطيران السلس (Tween) مدمجة هنا
local TweenService = game:GetService("TweenService")
function toTarget(targetCFrame)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local distance = (character.HumanoidRootPart.Position - targetCFrame.p).Magnitude
        local tweenInfo = TweenInfo.new(distance / 100, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- 🏠 القسم الرئيسي
local MainTab = Window:CreateTab("🏠 الرئيسية", 4483362458)
MainTab:CreateSection("لوحة تحكم DMS الملكية")

MainTab:CreateImage({
   Name = "LuffyGear5",
   Image = "rbxassetid://13426210080", -- صورة لوفي Gear 5
   Size = UDim2.new(0, 200, 0, 200),
})

MainTab:CreateLabel("مرحباً بك يا ملك القراصنة في DMS HUB")

-- ⚔️ قسم القتال (الفاروم مدمج هنا)
local CombatTab = Window:CreateTab("⚔️ القتال", 4483362458)
CombatTab:CreateSection("تطوير المستوى (Safe Farm)")

CombatTab:CreateToggle({
   Name = "تشغيل الأوتو فارم (طيران + ضرب)",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          Rayfield:Notify({Title = "DMS HUB", Content = "تم تفعيل الهاكي الملكي!", Duration = 3})
          
          -- محرك الفاروم المدمج
          task.spawn(function()
              while _G.farming do
                  task.wait(0.1)
                  pcall(function()
                      for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                          if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                              local farmPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                              toTarget(farmPos)
                              
                              while _G.farming and v.Humanoid.Health > 0 do
                                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                                  game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                                  task.wait(0.1)
                              end
                          end
                      end
                  end)
              end
          end)
      end
   end,
})

-- ⚙️ الإعدادات
local SettingsTab = Window:CreateTab("⚙️ الإعدادات", 4483362458)
SettingsTab:CreateButton({
   Name = "تدمير الواجهة (Close UI)",
   Callback = function()
       Rayfield:Destroy()
   end,
})

Rayfield:Notify({Title = "جاهز!", Content = "DMS HUB شغال الآن بأفضل أداء", Duration = 5})
