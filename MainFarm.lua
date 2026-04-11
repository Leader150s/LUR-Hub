-- DMS HUB | SMART FARM ENGINE (Level Max Optimized)
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

task.spawn(function()
    while _G.farming do
        task.wait(0.1)
        pcall(function()
            -- البحث عن أقرب وحش (لأن ليفلك ماكس)
            local closestEnemy = nil
            local shortestDist = math.huge

            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local d = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if d < shortestDist then
                        shortestDist = d
                        closestEnemy = v
                    end
                end
            end

            if closestEnemy then
                -- طيران سلس (Tween) آمن
                local targetPos = closestEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                if (player.Character.HumanoidRootPart.Position - targetPos.p).Magnitude > 5 then
                    TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = targetPos}):Play()
                end

                -- حلقة الدمج الفوري (Kill Aura + Auto Clicker)
                while _G.farming and closestEnemy.Humanoid.Health > 0 do
                    player.Character.HumanoidRootPart.CFrame = closestEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                    
                    -- سحب الوحوش القريبة (Magnet)
                    for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                        if m:FindFirstChild("HumanoidRootPart") and (m.HumanoidRootPart.Position - closestEnemy.HumanoidRootPart.Position).Magnitude < 40 then
                            m.HumanoidRootPart.CFrame = closestEnemy.HumanoidRootPart.CFrame
                            m.HumanoidRootPart.CanCollide = false
                            
                            -- تنفيذ الدمج التلقائي (أوتو كلكر)
                            if player.Character:FindFirstChildOfClass("Tool") then
                                player.Character:FindFirstChildOfClass("Tool"):Activate()
                            end
                        end
                    end
                    task.wait(0.01)
                end
            end
        end)
    end
end)
