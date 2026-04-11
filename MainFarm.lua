-- DMS HUB | AUTO DAMAGE & MAGNET ENGINE V10
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- وظيفة تجهيز السلاح (ضرورية للدمج)
function equipWeapon()
    pcall(function()
        if _G.Weapon ~= "" then
            local tool = player.Backpack:FindFirstChild(_G.Weapon) or player.Character:FindFirstChild(_G.Weapon)
            if tool and tool.Parent == player.Backpack then
                player.Character.Humanoid:EquipTool(tool)
            end
        end
    end)
end

task.spawn(function()
    while _G.farming do
        task.wait(0.1)
        pcall(function()
            equipWeapon()

            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    
                    -- طيران انسيابي (Tween) لمنع الطرد
                    local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                    local dist = (player.Character.HumanoidRootPart.Position - targetPos.p).Magnitude
                    if dist > 5 then
                        local tween = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(dist/100, Enum.EasingStyle.Linear), {CFrame = targetPos})
                        tween:Play()
                        tween.Completed:Wait()
                    end

                    -- حلقة "المربع المدمر" (الدمج التلقائي)
                    while _G.farming and v.Humanoid.Health > 0 do
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)

                        -- 1. تجميع كل الوحوش في "مربع" واحد (Magnet)
                        for _, monster in pairs(game.Workspace.Enemies:GetChildren()) do
                            if monster:FindFirstChild("HumanoidRootPart") and (monster.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                monster.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                monster.HumanoidRootPart.CanCollide = false
                                
                                -- 2. تفعيل الدمج التلقائي (بدون لمس يدوي)
                                pcall(function()
                                    if player.Character:FindFirstChildOfClass("Tool") then
                                        -- استخدام الـ Activate + الهجوم الوهمي لضمان الدمج
                                        player.Character:FindFirstChildOfClass("Tool"):Activate()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                                    end
                                end)
                            end
                        end
                        task.wait(0.01) -- سرعة هجوم نيكا القصوى
                    end
                end
            end
        end)
    end
end)
