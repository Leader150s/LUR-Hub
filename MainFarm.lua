-- ملف الفارم المحسن V4 (اختيار السلاح التلقائي)
task.spawn(function()
    local player = game.Players.LocalPlayer
    local function equipWeapon()
        local backpack = player.Backpack
        local character = player.Character
        
        if _G.Weapon then
            for _, v in pairs(backpack:GetChildren()) do
                if v:IsA("Tool") and v.ToolTip == _G.Weapon then
                    character.Humanoid:EquipTool(v)
                end
            end
        end
    end

    local TweenService = game:GetService("TweenService")
    while _G.farming do
        task.wait(0.1)
        pcall(function()
            equipWeapon() -- يجهز السلاح اللي اخترته من القائمة

            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                    local dist = (player.Character.HumanoidRootPart.Position - targetPos.p).Magnitude
                    
                    if dist > 5 then
                        local tween = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(dist/120, Enum.EasingStyle.Linear), {CFrame = targetPos})
                        tween:Play()
                        tween.Completed:Wait()
                    end
                    
                    while _G.farming and v.Humanoid.Health > 0 do
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                        
                        -- تنفيذ الضرب
                        if player.Character:FindFirstChildOfClass("Tool") then
                            player.Character:FindFirstChildOfClass("Tool"):Activate()
                        end
                        
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        
                        task.wait(0.05)
                    end
                end
            end
        end)
    end
end)
