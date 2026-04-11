-- DMS HUB | SMART AUTO QUEST & KILL AURA V11
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. وظيفة تثبيت السلاح (ما يتغير أبداً طول ما الفاروم شغال)
task.spawn(function()
    while true do
        task.wait(0.1)
        if _G.farming and _G.Weapon ~= "" then
            pcall(function()
                local tool = player.Backpack:FindFirstChild(_G.Weapon)
                if tool then
                    player.Character.Humanoid:EquipTool(tool)
                end
            end)
        end
    end
end)

-- 2. وظيفة الطيران الآمن (Tween)
function toPos(targetCFrame)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local dist = (char.HumanoidRootPart.Position - targetCFrame.p).Magnitude
        local info = TweenInfo.new(dist/100, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(char.HumanoidRootPart, info, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- 3. محرك الفارم الذكي (مهمات حسب اللفل + Kill Aura)
task.spawn(function()
    while _G.farming do
        task.wait(1)
        pcall(function()
            local myLevel = player.Data.Level.Value
            
            -- هنا السكربت يحدد الوحش المناسب لليفلك (نظام بسيط كمثال)
            -- يمكنك إضافة كل مهمات بلوكس فروت هنا
            local targetMonster = "Mercenary" -- افتراضي
            if myLevel >= 10 and myLevel < 15 then targetMonster = "Gorilla"
            elseif myLevel >= 15 then targetMonster = "Bobby" end 

            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v.Name == targetMonster and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    
                    -- طيران للمنطقة
                    local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                    local tween = toPos(targetPos)
                    if tween then tween.Completed:Wait() end
                    
                    -- حلقة المربع المدمر (Auto Clicker + Kill Aura)
                    while _G.farming and v.Humanoid.Health > 0 do
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                        
                        -- سحب وتدميج كل الوحوش في المربع
                        for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                            if m:FindFirstChild("HumanoidRootPart") and (m.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                m.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                m.HumanoidRootPart.CanCollide = false
                                
                                -- الاوتو كلكر الداخلي (دمج فوري)
                                if player.Character:FindFirstChildOfClass("Tool") then
                                    player.Character:FindFirstChildOfClass("Tool"):Activate()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                                end
                            end
                        end
                        task.wait(0.01)
                    end
                end
            end
        end)
    end
end)
