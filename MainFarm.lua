-- DMS HUB | LEVEL BASED FARM & INSTANT DAMAGE V13
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- دالة تحديد الوحش حسب اللفل (نظام الماكس)
function getTargetMonster()
    local myLevel = player.Data.Level.Value
    if myLevel >= 2550 then return "Candy Pirate" -- ليفل ماكس (بحر 3)
    elseif myLevel >= 1500 then return "Forgotten Pirate" -- ليفل عالي (بحر 2)
    else return "Royal Guard" end -- ليفل متوسط
end

task.spawn(function()
    while _G.farming do
        task.wait(0.1)
        pcall(function()
            local targetName = getTargetMonster()
            
            -- البحث عن الوحش المحدد لليفلك فقط
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v.Name == targetName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    
                    -- طيران آمن فوق الوحش المحدد
                    local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                    if (player.Character.HumanoidRootPart.Position - targetPos.p).Magnitude > 10 then
                        TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new((player.Character.HumanoidRootPart.Position - targetPos.p).Magnitude/100, Enum.EasingStyle.Linear), {CFrame = targetPos}):Play()
                        task.wait(0.5)
                    end

                    -- حلقة القتل (هنا الدمج الحقيقي)
                    while _G.farming and v.Humanoid.Health > 0 do
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                        
                        -- 1. سحب الوحوش القريبة (Magnet)
                        for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                            if m.Name == targetName and m:FindFirstChild("HumanoidRootPart") and (m.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                m.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                m.HumanoidRootPart.CanCollide = false
                                
                                -- 2. الدمج التلقائي (Remote Attack)
                                -- إرسال أمر الضرب المباشر لضمان دمج 100%
                                if player.Character:FindFirstChildOfClass("Tool") then
                                    player.Character:FindFirstChildOfClass("Tool"):Activate()
                                    -- محرك الضرب المتقدم (إرسال للهيت بوكس)
                                    ReplicatedStorage.Remotes.Validator:FireServer(math.huge) 
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
