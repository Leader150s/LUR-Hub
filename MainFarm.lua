-- DMS HUB | UNIVERSAL DATABASE V19 (FORCED MOVEMENT)
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- قاعدة البيانات (تأكد من ليفل 2800)
local AllSeaData = {
    ["Sea3"] = {
        {lvl = 1500, name = "Pirate Millionaire", qName = "TurtleQuest1", qNum = 1, npc = CFrame.new(-13242, 531, -7562), mob = CFrame.new(-13242, 531, -7562)},
        {lvl = 2500, name = "Cookie Pirate", qName = "CakeQuest1", qNum = 1, npc = CFrame.new(-2022, 37, -12140), mob = CFrame.new(-2100, 40, -12200)},
        {lvl = 2800, name = "Cake Guard", qName = "CakeQuest2", qNum = 1, npc = CFrame.new(-2022, 37, -12140), mob = CFrame.new(-2340, 40, -12100)}
    }
}

-- وظيفة الانتقال الفوري (أضمن من الطيران حالياً للتجربة)
local function forceMove(target)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = target
    end
end

task.spawn(function()
    while _G.farming do
        task.wait(0.2) -- تسريع الاستجابة
        pcall(function()
            -- فحص البحر
            local sea = (game.PlaceId == 7449925032 and "Sea3") or "Sea1"
            local myLvl = player.Data.Level.Value
            
            -- اختيار المهمة
            local q = AllSeaData[sea][1]
            for _, v in pairs(AllSeaData[sea]) do
                if myLvl >= v.lvl then q = v end
            end

            -- التنفيذ
            if not player.PlayerGui.Main.Quest.Visible then
                forceMove(q.npc)
                task.wait(0.5)
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.qName, q.qNum)
            else
                forceMove(q.mob)
                -- حلقة القتل والدمج
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Name == q.name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                        if player.Character:FindFirstChildOfClass("Tool") then
                            player.Character:FindFirstChildOfClass("Tool"):Activate()
                            ReplicatedStorage.Remotes.Validator:FireServer(math.huge)
                        end
                    end
                end
            end
        end)
    end
end)
