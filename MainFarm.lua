-- DMS HUB | ALL SEAS DATABASE (1, 2, 3) V18
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- 1️⃣ قاعدة بيانات البحار (NPCs, Monsters, CFrames)
local SeaData = {
    ["Sea1"] = {
        {lvl = 0, name = "Bandit", qName = "BanditQuest1", qNum = 1, npc = CFrame.new(1059, 15, 1547), mob = CFrame.new(1145, 17, 1634)},
        {lvl = 10, name = "Monkey", qName = "JungleQuest", qNum = 1, npc = CFrame.new(-1598, 36, 153), mob = CFrame.new(-1623, 36, 147)},
        {lvl = 30, name = "Pirate", qName = "BuggyQuest1", qNum = 1, npc = CFrame.new(-1141, 4, 3827), mob = CFrame.new(-1141, 4, 3827)},
        -- يمكنك إضافة المزيد من بحر 1 هنا
    },
    ["Sea2"] = {
        {lvl = 700, name = "Raider", qName = "Area1Quest", qNum = 1, npc = CFrame.new(-427, 72, 183), mob = CFrame.new(-427, 72, 183)},
        {lvl = 1000, name = "Don Swan", qName = "SwanQuest", qNum = 1, npc = CFrame.new(2289, 15, 905), mob = CFrame.new(2289, 15, 905)},
    },
    ["Sea3"] = {
        {lvl = 1500, name = "Pirate Millionaire", qName = "TurtleQuest1", qNum = 1, npc = CFrame.new(-13242, 531, -7562), mob = CFrame.new(-13242, 531, -7562)},
        {lvl = 2450, name = "Candy Pirate", qName = "CandyQuest1", qNum = 1, npc = CFrame.new(-1148, 14, -12052), mob = CFrame.new(-1115, 50, -12300)},
        {lvl = 2500, name = "Subordinate", qName = "CakeQuest1", qNum = 1, npc = CFrame.new(-2022, 37, -12140), mob = CFrame.new(-2022, 37, -12140)},
    }
}

-- 2️⃣ وظيفة فحص البحر الحالي
local function getCurrentSea()
    local placeId = game.PlaceId
    if placeId == 2753915549 then return "Sea1"
    elseif placeId == 4442245419 then return "Sea2"
    elseif placeId == 7449925032 then return "Sea3"
    end
end

-- 3️⃣ اختيار المهمة المناسبة لليفلك في بحرك الحالي
function getSmartQuest()
    local myLvl = player.Data.Level.Value
    local sea = getCurrentSea()
    local mySeaData = SeaData[sea]
    local bestMatch = mySeaData[1]

    for _, data in pairs(mySeaData) do
        if myLvl >= data.lvl then
            bestMatch = data
        end
    end
    return bestMatch
end

-- 4️⃣ محرك الفارم (الطيران والجلد)
task.spawn(function()
    while _G.farming do
        task.wait(0.5)
        pcall(function()
            local q = getSmartQuest()
            
            -- إذا ما عندك مهمة -> طر للـ NPC
            if not player.PlayerGui.Main.Quest.Visible then
                local dist = (player.Character.HumanoidRootPart.Position - q.npc.p).Magnitude
                TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(dist/150), {CFrame = q.npc}):Play()
                task.wait(dist/150 + 0.5)
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.qName, q.qNum)
            else
                -- طر للوحش واجلده
                local dist = (player.Character.HumanoidRootPart.Position - q.mob.p).Magnitude
                TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(dist/150), {CFrame = q.mob}):Play()
                
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Name == q.name and v.Humanoid.Health > 0 then
                        while _G.farming and v.Humanoid.Health > 0 and player.PlayerGui.Main.Quest.Visible do
                            player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                            if player.Character:FindFirstChildOfClass("Tool") then
                                player.Character:FindFirstChildOfClass("Tool"):Activate()
                                ReplicatedStorage.Remotes.Validator:FireServer(math.huge)
                            end
                            task.wait(0.01)
                        end
                    end
                end
            end
        end)
    end
end)
