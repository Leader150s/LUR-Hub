-- DMS HUB | MAX LEVEL & SMART QUEST V12
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- وظيفة تجلب العالم الحالي (بحر 1، 2، أو 3)
local function getSea()
    local placeId = game.PlaceId
    if placeId == 2753915549 then return "Sea1"
    elseif placeId == 4442245419 then return "Sea2"
    elseif placeId == 7449925032 then return "Sea3"
    end
end

-- وظيفة تحديد المهمة للفل الماكس (تعديل لليفل 2800+)
local function getTarget()
    local sea = getSea()
    if sea == "Sea3" then
        return "Candy Pirate", "Chocolate Island" -- مثال للبحر الثالث
    elseif sea == "Sea2" then
        return "Forgotten Pirate", "Forgotten Island" -- مثال للبحر الثاني
    else
        return "Galley Pirate", "Fountain City" -- البحر الأول
    end
end

task.spawn(function()
    while _G.farming do
        task.wait(1)
        pcall(function()
            local targetName, areaName = getTarget()
            
            -- البحث عن الوحش في الماب
            local enemy = nil
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v.Name == targetName and v.Humanoid.Health > 0 then
                    enemy = v
                    break
                end
            end

            -- إذا ما لقى وحش، يطير لمكان "سباون" الوحوش
            if not enemy then
                -- كود طيران لمنطقة المهمة (Area)
                print("البحث عن الوحوش في: " .. areaName)
            else
                -- طيران للوحش وبدء الجلد (Kill Aura)
                local targetPos = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                -- (نفس كود الطيران والضرب اللي استعملناه سابقاً)
            end
        end)
    end
end)
