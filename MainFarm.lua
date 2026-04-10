-- LUR HUB - SMART TWEEN ENGINE (المحرك الطائر)
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

_G.farming = true

-- وظيفة الطيران السلس (Tween)
function toTarget(targetCFrame)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local distance = (character.HumanoidRootPart.Position - targetCFrame.p).Magnitude
        local speed = 100 -- سرعة الطيران (100 هي السرعة الآمنة لبلوكس فروت)
        
        local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        
        tween:Play()
        return tween
    end
end

task.spawn(function()
    while _G.farming do
        task.wait(0.1)
        pcall(function()
            -- البحث عن أقرب عدو
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    -- الطيران لمكان العدو (الوقوف فوقه بمسافة 8 خطوات)
                    local farmPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                    local move = toTarget(farmPos)
                    
                    -- الانتظار حتى يصل للطير بسلام
                    if move then move.Completed:Wait() end
                    
                    -- البدء بالضرب أثناء الوقوف فوقه
                    while _G.farming and v.Humanoid.Health > 0 do
                        character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        task.wait(0.1)
                    end
                end
            end
        end)
    end
end)
