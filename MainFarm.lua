-- DMS HUB | نظام المربع والدمج التلقائي V7
task.spawn(function()
    local player = game.Players.LocalPlayer
    local TweenService = game:GetService("TweenService")
    
    -- وظيفة تجهيز السلاح بقوة
    local function forceEquip()
        if _G.Weapon ~= "" then
            local tool = player.Backpack:FindFirstChild(_G.Weapon)
            if tool then
                player.Character.Humanoid:EquipTool(tool)
            end
        end
    end

    while _G.farming do
        task.wait()
        pcall(function()
            forceEquip()
            
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    -- الطيران والاستقرار فوق الوحوش
                    local targetCFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                    player.Character.HumanoidRootPart.CFrame = targetCFrame
                    
                    -- إنشاء "مربع" القتل (Kill Aura)
                    for _, monster in pairs(game.Workspace.Enemies:GetChildren()) do
                        if monster:FindFirstChild("HumanoidRootPart") and (monster.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 45 then
                            -- سحبهم لنقطة المربع
                            monster.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                            monster.HumanoidRootPart.CanCollide = false
                            
                            -- تنفيذ الدمج التلقائي (السر في Activate + VirtualUser)
                            if player.Character:FindFirstChildOfClass("Tool") then
                                player.Character:FindFirstChildOfClass("Tool"):Activate()
                                -- إرسال هجوم وهمي للسيرفر لضمان الدمج
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                            end
                        end
                    end
                end
            end
        end)
    end
end)
