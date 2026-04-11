-- DMS HUB | REAL AUTO QUEST & LEVEL FARM V15
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- قاعدة بيانات المهمات واللفل (تلقائية)
function getQuestData()
    local lvl = player.Data.Level.Value
    if lvl < 10 then
        return "Bandit", "BanditQuest1", 1, "Rebel"
    elseif lvl >= 10 and lvl < 15 then
        return "Monkey", "JungleQuest", 1, "Monkey"
    elseif lvl >= 15 and lvl < 30 then
        return "Gorilla", "JungleQuest", 2, "Gorilla"
    elseif lvl >= 30 and lvl < 40 then
        return "Pirate", "BuggyQuest1", 1, "Pirate"
    -- إذا كنت ليفل ماكس أو عالي جداً يذهب لآخر مهمة متاحة في العالم
    elseif lvl >= 2500 then 
        return "Candy Pirate", "CandyQuest", 1, "Candy Pirate"
    else
        -- نظام تلقائي للبحث عن أقرب وحش يناسب اللفل إذا لم يتم تحديد اسم المهمة
        return "Enemies", "Quest", 1, "Enemies"
    end
end

-- وظيفة أخذ المهمة من السيرفر
function takeQuest(questName, level)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questName, level)
end

task.spawn(function()
    while _G.farming do
        task.wait(0.5)
        pcall(function()
            local monsterName, questName, questLevel, mobTitle = getQuestData()

            -- 1. التأكد من وجود مهمة (إذا ما عندك مهمة يروح ياخذها)
            if not player.PlayerGui.Main.Quest.Visible then
                -- طيران لمكان المهمة (هنا نضع إحداثيات المهمة أو نطير لأقرب NPC)
                takeQuest(questName, questLevel)
            end

            -- 2. البحث عن الوحش الخاص بالمهمة
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v.Name == monsterName and v.Humanoid.Health > 0 then
                    
                    -- طيران سلس
                    local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                    if (player.Character.HumanoidRootPart.Position - targetPos.p).Magnitude > 5 then
                        TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = targetPos}):Play()
                    end

                    -- 3. الجلد (دمج حقيقي)
                    while _G.farming and v.Humanoid.Health > 0 and player.PlayerGui.Main.Quest.Visible do
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                        
                        -- دمج سريع جداً (Kill Aura)
                        if player.Character:FindFirstChildOfClass("Tool") then
                            player.Character:FindFirstChildOfClass("Tool"):Activate()
                            -- إرسال ضربة مباشرة للسيرفر
                            ReplicatedStorage.Remotes.Validator:FireServer(math.huge)
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                        end
                        task.wait(0.01)
                    end
                end
            end
        end)
    end
end)
