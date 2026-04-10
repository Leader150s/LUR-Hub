local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ إصدار ملك القراصنة",
   LoadingTitle = "جاري تشغيل محرك نيكا الأسطوري...",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" 
})

-- 🏠 القسم الرئيسي (هنا تظهر صورة لوفي والأزرار فوراً)
local MainTab = Window:CreateTab("🏠 القائمة الرئيسية", 4483362458)

MainTab:CreateSection("لوحة تحكم DMS الملكية")

-- زر تشغيل الفاروم (حطيته في الوجه عشان ما تتعب وتدور عليه)
_G.farming = false
MainTab:CreateToggle({
   Name = "⚔️ تشغيل الأوتو فارم (طيران + ضرب)",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      _G.farming = Value
      if Value then
          Rayfield:Notify({Title = "DMS HUB", Content = "تم تفعيل الهاكي الملكي!", Duration = 3})
          
          -- محرك الفاروم (طيران سلس ضد الطرد)
          task.spawn(function()
              local TweenService = game:GetService("TweenService")
              while _G.farming do
                  task.wait(0.1)
                  pcall(function()
                      for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                          if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                              -- الطيران للعدو
                              local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                              local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - targetPos.p).Magnitude
                              local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(dist/100, Enum.EasingStyle.Linear), {CFrame = targetPos})
                              tween:Play()
                              tween.Completed:Wait()
                              
                              -- الضرب المستمر
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

MainTab:CreateSection("شخصية نيكا (DMS)")

-- صورة لوفي (استخدمت آيدي مختلف لضمان الظهور)
MainTab:CreateImage({
   Name = "Luffy",
   Image = "rbxassetid://13426210080",
   Size = UDim2.new(0, 250, 0, 250),
})

MainTab:CreateLabel("مرحباً بك يا ملك القراصنة.. استمتع بالفرم!")
