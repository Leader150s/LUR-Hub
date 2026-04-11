-- DMS HUB | UNIVERSAL DATABASE (SEA 1, 2, 3)
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- قاعدة البيانات الشاملة
local AllSeaData = {
    ["Sea1"] = {
        {lvl = 0, name = "Bandit", qName = "BanditQuest1", qNum = 1, npc = CFrame.new(1059, 15, 1547), mob = CFrame.new(1145, 17, 1634)},
        {lvl = 10, name = "Monkey", qName = "JungleQuest", qNum = 1, npc = CFrame.new(-1598, 36, 153), mob = CFrame.new(-1623, 36, 147)}
    },
    ["Sea2"] = {
        {lvl = 700, name = "Raider", qName = "Area1Quest", qNum = 1, npc = CFrame.new(-427, 72, 183), mob = CFrame.new(-427, 72, 183)}
    },
    ["Sea3"] = {
        {lvl = 1500, name = "Pirate Millionaire", qName = "TurtleQuest1", qNum = 1, npc = CFrame.new(-13242, 531, -7562), mob = CFrame.new(-13242, 531, -7562)},
        {lvl = 2500, name = "Cookie Pirate", qName = "CakeQuest1", qNum = 1, npc = CFrame.new(-2022, 37, -12140), mob = CFrame.new(-2100, 40, -12200)},
        {lvl = 2800, name = "Cake Guard", qName = "CakeQuest2", qNum = 1, npc = CFrame.new(-2022, 37, -12140), mob = CFrame.new(-2340, 40, -12100)}
    }
}

local function getSea()
    local pId = game.PlaceId
    if pId == 2753915549 then return "Sea1"
    elseif pId == 4442245419 then return "Sea2"
    elseif pId == 7449925032 then return "Sea3" end
end

local function getMyQuest()
    local myLvl = player.Data.Level.Value
    local sea = getSea()
    local data = AllSeaData[sea]
    local best = data[1]
    for _, v in pairs(data) do
        if myLvl >= v.lvl then best = v end
    end
    return best
end

local function tween(target)
    local dist = (player.Character.HumanoidRootPart.Position - target.p).Magnitude
    local t = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(dist/150, Enum.EasingStyle.Linear), {CFrame = target})
    t:Play()
    return t
end

task.spawn(function()
    while _G.farming do
        task.wait(0.5)
        pcall(function()
            local q = getMyQuest()
            if not player.PlayerGui.Main.Quest.Visible then
                local tw = tween(q.npc)
                if tw then tw.Completed:Wait() end
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.qName, q.qNum)
            else
                tween(q.mob)
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
