-- DMS HUB | AUTO LEVEL FARM & REAL DAMAGE V16
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- وظيفة الطيران السلس (آمن ضد الطرد)
local function toPos(targetCFrame)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local dist = (player.Character.HumanoidRootPart.Position - targetCFrame.p).Magnitude
        local speed = 120 -- سرعة آمنة
        local tween = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(dist/speed, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

task.spawn(function()
    while _G.farming do
        task.wait(0.5)
        pcall(function()
            local myLevel = player.Data.Level.Value
            local targetEnemy = nil
            local minDistance = math.huge

            -- البحث عن الوحوش التي تناسب ليفلك في كامل الماب
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    -- جلب لفل الوحش للتأكد أنه مناسب (أو قريب من ليفلك)
                    local enemyLevel = v:FindFirstChild("Level") and v.Level.Value or 0
                    
                    -- إذا كنت ماكس (2550+) يركز على وحوش الجزيرة الأخيرة
                    -- وإذا كنت أقل، يركز على الوحوش التي لفلها قريب من ليفلك
                    if (myLevel >= 2500 and enemyLevel >= 2400) or (math.abs(myLevel - enemyLevel) <= 200) then
                        local dist = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                        if dist < minDistance then
                            minDistance = dist
                            targetEnemy = v
                        end
                    end
                end
            end

            -- إذا وجد الوحش المناسب، ابدأ العملية
            if targetEnemy then
                -- 1. الطيران لموقع الوحش
                local targetPos = targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                local fly = toPos(targetPos)
                if fly then fly.Completed:Wait() end

                -- 2. حلقة القتل والدمج (Kill Aura)
                while _G.farming and targetEnemy.Humanoid.Health > 0 do
                    player.Character.HumanoidRootPart.CFrame = targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                    
                    -- تجميع الوحوش (Magnet)
                    for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                        if m.Name == targetEnemy.Name and (m.HumanoidRootPart.Position - targetEnemy.HumanoidRootPart.Position).Magnitude < 50 then
                            m.HumanoidRootPart.CFrame = targetEnemy.HumanoidRootPart.CFrame
                            m.HumanoidRootPart.CanCollide = false
                        end
                    end

                    -- تنفيذ الدمج التلقائي (هنا الحل النهائي للدمج)
                    if player.Character:FindFirstChildOfClass("Tool") then
                        player.Character:FindFirstChildOfClass("Tool"):Activate()
                        -- ضربة السيرفر المباشرة (هذه التي تظهر أرقام الدمج)
                        ReplicatedStorage.Remotes.Validator:FireServer(math.huge)
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                    end
                    task.wait(0.01)
                end
            end
        end)
    end
end)
