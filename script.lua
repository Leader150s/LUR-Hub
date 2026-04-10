-- LUR HUB BF: Auto Quest & Farm
local farming = false
FarmBtn.MouseButton1Click:Connect(function()
    farming = not farming
    FarmBtn.Text = farming and "جارِ التلفيل..." or "أوتو فارم: مطفأ"

    spawn(function()
        while farming do
            wait(0.1)
            pcall(function()
                -- 1. التأكد من وجود مهمة، إذا لم توجد يذهب لأخذها
                if not game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") then
                    -- كود الذهاب لصاحب المهمة (مثال لمنطقة معينة)
                    -- ملاحظة: يجب كتابة اسم الـ NPC الخاص بالجزيرة التي أنت فيها
                    local args = { [1] = "StartQuest", [2] = "QuestNameHere", [3] = 1 }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                else
                    -- 2. الطيران للوحوش وقتلهم
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            -- طيران سريع خلف الوحش
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            
                            -- استخدام القتال (Combat)
                            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat")
                            if tool then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                            end
                        end
                    end
                end
            end)
        end
    end)
end)
