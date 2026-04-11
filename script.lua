local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DMS HUB ⚡ النسخة المدمجة والنهائية",
   LoadingTitle = "DMS HUB | جاري تفعيل القوة الكاملة",
   LoadingSubtitle = "بواسطة Leader150s",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   Theme = "Ocean" 
})

local MainTab = Window:CreateTab("🏠 التحكم المباشر", 4483362458)

_G.farming = false
_G.Weapon = ""

-- جلب أسلحتك الحالية
local function getTools()
    local t = {}
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then table.insert(t, v.Name) end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then table.insert(t, v.Name) end
    end
    return t
end

MainTab:CreateToggle({
   Name = "⚔️ تشغيل الفارم (مدمج - دمج فوري)",
   CurrentValue = false,
   Flag = "FullFarm",
   Callback = function(Value)
      _G.farming = Value
   end,
})

MainTab:CreateDropdown({
   Name = "إختر سلاحك",
   Options = getTools(),
   CurrentOption = {""},
   MultipleOptions = false,
   Callback = function(Option)
      _G.Weapon = Option[1]
   end,
})

-- [[ المحرك المدمج لضمان الاستجابة 100% ]]
task.spawn(function()
    local player = game.Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")

    while true do
        task.wait()
        if _G.farming then
            pcall(function()
                -- 1. تثبيت السلاح بقوة
                if _G.Weapon ~= "" then
                    local tool = player.Backpack:FindFirstChild(_G.Weapon)
                    if tool then
                        player.Character.Humanoid:EquipTool(tool)
                    end
                end

                -- 2. تحديد الهدف (إذا ليفل ماكس يروح لآخر وحوش، إذا أقل يروح للأقرب)
                local myLevel = player.Data.Level.Value
                local targetEnemy = nil
                local shortestDist = math.huge

                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        local enemyLevel = v:FindFirstChild("Level") and v.Level.Value or 0
                        -- شرط التلفيل الذكي: يركز على وحوش قريبة من ليفلك
                        if (myLevel >= 2500 and enemyLevel >= 2400) or (math.abs(myLevel - enemyLevel) <= 250) then
                            local d = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                            if d < shortestDist then
                                shortestDist = d
                                targetEnemy = v
                            end
                        end
                    end
                end

                -- 3. الطيران والجلد (Kill Aura)
                if targetEnemy then
                    local targetPos = targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                    
                    -- طيران سريع واستجابة فورية
                    player.Character.HumanoidRootPart.CFrame = targetPos

                    -- نظام الدمج (Auto Clicker + Network Hit)
                    if player.Character:FindFirstChildOfClass("Tool") then
                        player.Character:FindFirstChildOfClass("Tool"):Activate()
                        -- سحب الوحوش القريبة
                        for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                            if m.Name == targetEnemy.Name and (m.HumanoidRootPart.Position - targetEnemy.HumanoidRootPart.Position).Magnitude < 50 then
                                m.HumanoidRootPart.CFrame = targetEnemy.HumanoidRootPart.CFrame
                                m.HumanoidRootPart.CanCollide = false
                            end
                        end
                        -- إرسال إشارة الضرر المباشرة للسيرفر
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                        ReplicatedStorage.Remotes.Validator:FireServer(math.huge)
                    end
                end
            end)
        end
    end
end)
