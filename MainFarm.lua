-- DMS HUB | SAFE TWEEN & KILL AURA V8
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- وظيفة الطيران الآمن (تمنع الطرد)
function safeTween(targetCFrame)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local dist = (char.HumanoidRootPart.Position - targetCFrame.p).Magnitude
        local speed = 100 -- سرعة طيران آمنة
        local info = TweenInfo.new(dist/speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(char.HumanoidRootPart, info, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- محرك الفارم الذكي
task.spawn(function()
    while _G.farming do
        task.wait(0.5)
        pcall(function()
            -- 1. تجهيز السلاح المختار
            if _G.Weapon ~= "" then
                local tool = player.Backpack:FindFirstChild(_G.Weapon)
                if tool then player.Character.Humanoid:EquipTool(tool) end
            end

            -- 2. البحث عن الوحوش القريبة من مستواك (نظام بسيط لعدم التشتت)
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    
                    -- طيران آمن فوق الوحش
                    local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                    local tween = safeTween(targetPos)
                    if tween then tween.Completed:Wait() end
                    
                    -- حلقة "المربع المدمر" (الدمج الجماعي)
                    while _G.farming and v.Humanoid.Health > 0 do
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                        
                        -- سحب الوحوش القريبة (Magnet)
                        for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                            if m:FindFirstChild("HumanoidRootPart") and (m.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 40 then
                                m.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                m.HumanoidRootPart.CanCollide = false
                                
                                -- تنفيذ الدمج التلقائي
                                if player.Character:FindFirstChildOfClass("Tool") then
                                    player.Character:FindFirstChildOfClass("Tool"):Activate()
                                end
                            end
                        end
                        task.wait(0.1)
                    end
                end
            end
        end)
    end
end)
