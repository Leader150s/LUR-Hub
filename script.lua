local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "جاري تحضير قوة نيكا...",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" -- اللون الأزرق الملكي
})

-- إنشاء الصفحة الرئيسية (كل شيء سيكون هنا لراحتك)
local MainTab = Window:CreateTab("🏠 القائمة", 4483362458)

MainTab:CreateSection("⚔️ محرك الفارم (DMS Safe)")

_G.farming = false
MainTab:CreateToggle({
   Name = "تشغيل التلفيل التلقائي (طيران + ضرب)",
   CurrentValue = false,
   Flag = "AutoFarm", 
   Callback = function(Value)
      _G.farming = Value
      if Value then
         Rayfield:Notify({Title = "DMS HUB", Content = "تم تفعيل الهاكي الملكي.. ابدأ الرحلة!", Duration = 4})
         
         -- محرك الطيران والضرب المدمج
         task.spawn(function()
            local TweenService = game:GetService("TweenService")
            while _G.farming do
               task.wait(0.1)
               pcall(function()
                  for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                     if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        -- طيران سلس
                        local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                        local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - targetPos.p).Magnitude
                        local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(dist/100, Enum.EasingStyle.Linear), {CFrame = targetPos})
                        tween:Play()
                        tween.Completed:Wait()
                        
                        -- ضرب العدو
                        while _G.farming and v.Humanoid.Health > 0 do
                           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                           game:GetService("VirtualUser"):CaptureController()
                           game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
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

MainTab:CreateSection("🎨 التصميم والشعار")

-- صورة لوفي Gear 5 (ستظهر في منتصف القائمة)
MainTab:CreateImage({
   Name = "LuffyGear5",
   Image = "rbxassetid://13426210080",
   Size = UDim2.new(0, 200, 0, 200),
})

MainTab:CreateLabel("مرحباً بك يا ملك القراصنة في DMS HUB")
MainTab:CreateParagraph({Title = "نصيحة المطور", Content = "استخدم سيفاً أو فاكهة بيدك قبل تفعيل السكربت لضمان الضرب السريع."})

MainTab:CreateButton({
   Name = "إغلاق الواجهة",
   Callback = function()
      Rayfield:Destroy()
   end,
})
