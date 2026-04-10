
-- LUR HUB - ENGINE (المحرك)
print("تم تفعيل محرك الفاروم بنجاح!")

_G.farming = true -- تشغيل التكرار

task.spawn(function()
    while _G.farming do
        task.wait()
        pcall(function()
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    -- طيران وضرب
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                end
            end
        end)
    end
end)
