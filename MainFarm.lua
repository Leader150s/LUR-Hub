-- DMS HUB | KILL AURA & MAGNET V6 (نظام المربع المدمر)
task.spawn(function()
    local player = game.Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")

    -- وظيفة تجهيز السلاح المختار
    local function equipWeapon()
        pcall(function()
            if _G.Weapon then
                local tool = player.Backpack:FindFirstChild(_G.Weapon) or player.Character:FindFirstChild(_G.Weapon)
                if tool and tool.Parent == player.Backpack then
                    player.Character.Humanoid:EquipTool(tool)
                end
            end
        end)
    end

    -- محرك الضرب بالمجال (Kill Aura)
    while _G.farming do
        task.wait(0.1)
        pcall(function()
            equipWeapon()

            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    
                    -- الطيران لموقع البوتات
                    local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                    local dist = (player.Character.HumanoidRootPart.Position - targetPos.p).Magnitude
                    
                    if dist > 5 then
                        local tween = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(dist/130, Enum.EasingStyle.Linear), {CFrame = targetPos})
                        tween:Play()
                        tween.Completed:Wait()
                    end
                    
                    -- حلقة القتل بالمجال (المربع)
                    while _G.farming and v.Humanoid.Health > 0 do
                        task.wait()
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)

                        -- 1. نظام الـ Magnet (سحب الوحوش للمربع)
                        for _, bot in pairs(game.Workspace.Enemies:GetChildren()) do
                            if bot:FindFirstChild("HumanoidRootPart") and (bot.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                bot.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                bot.HumanoidRootPart.CanCollide = false
                                
                                -- 2. نظام الـ Kill Aura (تدميج تلقائي لكل من في المربع)
                                pcall(function()
                                    -- إرسال إشارة الضرب مباشرة للسيرفر (أسرع طريقة)
                                    local args = {
                                        [1] = bot.Humanoid
                                    }
                                    -- هذه الأوامر تختلف حسب اللعبة، لكن Activate تفي بالغرض مع الـ Magnet
                                    if player.Character:FindFirstChildOfClass("Tool") then
                                        player.Character:FindFirstChildOfClass("Tool"):Activate()
                                    end
                                end)
                            end
                        end
                        
                        -- محاكاة الضرب السريع جداً
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                    end
                end
            end
        end)
    end
end)
