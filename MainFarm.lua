-- DMS HUB | ملف الفارم المطور V5 (إصلاح شامل للضرب والتجميع)
task.spawn(function()
    local player = game.Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")

    -- وظيفة تجهيز السلاح (تأكد من اختيار Melee أو Sword أو Fruit)
    local function equipWeapon()
        pcall(function()
            if _G.Weapon then
                local tool = player.Backpack:FindFirstChild(_G.Weapon) or player.Character:FindFirstChild(_G.Weapon)
                if not tool then
                    -- محاولة البحث عن السلاح حسب النوع (ToolTip)
                    for _, v in pairs(player.Backpack:GetChildren()) do
                        if v:IsA("Tool") and (v.ToolTip == _G.Weapon or v.Name == _G.Weapon) then
                            player.Character.Humanoid:EquipTool(v)
                        end
                    end
                else
                    -- إذا كان السلاح في الشنطة جهزه
                    if tool.Parent == player.Backpack then
                        player.Character.Humanoid:EquipTool(tool)
                    end
                end
            end
        end)
    end

    while _G.farming do
        task.wait(0.1)
        pcall(function()
            equipWeapon() -- تجهيز السلاح المختار

            -- تفعيل الهاكي تلقائياً لزيادة الدمج
            if not player.Character:FindFirstChild("HasBuso") then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end

            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    -- طيران سلس خلف العدو
                    local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                    local dist = (player.Character.HumanoidRootPart.Position - targetPos.p).Magnitude
                    
                    if dist > 5 then
                        local tween = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(dist/125, Enum.EasingStyle.Linear), {CFrame = targetPos})
                        tween:Play()
                        tween.Completed:Wait()
                    end
                    
                    -- حلقة القتل الفائق
                    while _G.farming and v.Humanoid.Health > 0 do
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                        
                        -- 1. تجميع كل البوتات القريبة (Magnet)
                        for _, bot in pairs(game.Workspace.Enemies:GetChildren()) do
                            if bot:FindFirstChild("HumanoidRootPart") and (bot.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 40 then
                                bot.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                bot.HumanoidRootPart.CanCollide = false
                                if bot.Humanoid.Health <= 0 then bot:Destroy() end
                            end
                        end

                        -- 2. الضرب التلقائي السريع جداً (Fast Attack)
                        if player.Character:FindFirstChildOfClass("Tool") then
                            player.Character:FindFirstChildOfClass("Tool"):Activate()
                        end
                        -- محاكاة اللمس لزيادة السرعة
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        
                        task.wait(0.01) -- سرعة "تخبل" فعلياً
                    end
                end
            end
        end)
    end
end)
