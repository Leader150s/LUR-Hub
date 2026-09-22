-- ===================================================
-- 👑 BEN HUB - Chat Module (ChatModule.lua)
-- ===================================================

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

return function(ChatPage)
    -- إطار علوي لتبديل الأقسام (شات عام / شات خاص)
    local ChatTopBar = Instance.new("Frame", ChatPage)
    ChatTopBar.Size = UDim2.new(1, 0, 0, 26)
    ChatTopBar.BackgroundTransparency = 1
    ChatTopBar.ZIndex = 4

    local GlobalBtn = Instance.new("TextButton", ChatTopBar)
    GlobalBtn.Size = UDim2.new(0.48, 0, 1, 0)
    GlobalBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    GlobalBtn.Text = "🌐 شات عام"
    GlobalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GlobalBtn.Font = Enum.Font.SourceSansBold
    GlobalBtn.TextSize = 11
    GlobalBtn.ZIndex = 5
    Instance.new("UICorner", GlobalBtn).CornerRadius = UDim.new(0, 5)

    local PrivateBtn = Instance.new("TextButton", ChatTopBar)
    PrivateBtn.Size = UDim2.new(0.48, 0, 1, 0)
    PrivateBtn.Position = UDim2.new(0.51, 0, 0, 0)
    PrivateBtn.BackgroundColor3 = Color3.fromRGB(35, 15, 20)
    PrivateBtn.Text = "🔒 شات خاص"
    PrivateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PrivateBtn.Font = Enum.Font.SourceSansBold
    PrivateBtn.TextSize = 11
    PrivateBtn.ZIndex = 5
    Instance.new("UICorner", PrivateBtn).CornerRadius = UDim.new(0, 5)

    -- شاشة الشات العام
    local GlobalChatScroll = Instance.new("ScrollingFrame", ChatPage)
    GlobalChatScroll.Size = UDim2.new(1, 0, 0.65, 0)
    GlobalChatScroll.Position = UDim2.new(0, 0, 0, 30)
    GlobalChatScroll.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
    GlobalChatScroll.BackgroundTransparency = 0.2
    GlobalChatScroll.ScrollBarThickness = 3
    GlobalChatScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    GlobalChatScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    GlobalChatScroll.ZIndex = 4
    Instance.new("UICorner", GlobalChatScroll).CornerRadius = UDim.new(0, 6)

    local GlobalLayout = Instance.new("UIListLayout", GlobalChatScroll)
    GlobalLayout.Padding = UDim.new(0, 4)

    -- صندوق الإرسال والكتابة
    local InputBox = Instance.new("TextBox", ChatPage)
    InputBox.Size = UDim2.new(0.72, 0, 0, 28)
    InputBox.Position = UDim2.new(0, 0, 0.83, 0)
    InputBox.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
    InputBox.PlaceholderText = "اكتب رسالتك في الشات العام..."
    InputBox.Text = ""
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.Font = Enum.Font.SourceSans
    InputBox.TextSize = 11
    InputBox.ClearTextOnFocus = false
    InputBox.ZIndex = 4
    Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 5)

    local SendBtn = Instance.new("TextButton", ChatPage)
    SendBtn.Size = UDim2.new(0.25, 0, 0, 28)
    SendBtn.Position = UDim2.new(0.74, 0, 0.83, 0)
    SendBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    SendBtn.Text = "إرسال 🚀"
    SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SendBtn.Font = Enum.Font.SourceSansBold
    SendBtn.TextSize = 11
    SendBtn.ZIndex = 4
    Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 5)

    -- فلتر الكلمات البذيئة والروابط الممنوعة
    local badWords = {"انعل", "ابوك", "امك", "ختك", "أختك", "اختك", "رب", "دين", "الله", "كلب", "حمار", "سب", "كس", "قحبة", "طيز", "زب", "منيوك", "قواد", "http", "https", "www", "%.com", "%.gg"}

    local function filterText(msg)
        local lowerMsg = string.lower(msg)
        for _, word in pairs(badWords) do
            if string.find(lowerMsg, string.lower(word)) then
                return "[رسالة محظورة 🚫: يمنع الشتم والروابط]"
            end
        end
        return msg
    end

    -- دالة إضافة رسالة للشات
    local function addChatMessage(senderName, userId, messageText, targetScroll)
        if not messageText or messageText == "" then return end
        targetScroll = targetScroll or GlobalChatScroll

        local msgFrame = Instance.new("Frame", targetScroll)
        msgFrame.Size = UDim2.new(0.98, 0, 0, 32)
        msgFrame.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
        msgFrame.BackgroundTransparency = 0.2
        msgFrame.ZIndex = 5
        Instance.new("UICorner", msgFrame).CornerRadius = UDim.new(0, 5)

        local AvatarImg = Instance.new("ImageLabel", msgFrame)
        AvatarImg.Size = UDim2.new(0, 24, 0, 24)
        AvatarImg.Position = UDim2.new(0.02, 0, 0.12, 0)
        AvatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userId) .. "&w=150&h=150"
        AvatarImg.BackgroundTransparency = 1
        AvatarImg.ZIndex = 6
        Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(1, 0)

        local ContentLbl = Instance.new("TextLabel", msgFrame)
        ContentLbl.Size = UDim2.new(0.85, 0, 1, 0)
        ContentLbl.Position = UDim2.new(0.12, 0, 0, 0)
        ContentLbl.Text = "[" .. senderName .. "]: " .. filterText(messageText)
        ContentLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        ContentLbl.Font = Enum.Font.SourceSansBold
        ContentLbl.TextSize = 10
        ContentLbl.TextXAlignment = Enum.TextXAlignment.Left
        ContentLbl.TextWrapped = true
        ContentLbl.BackgroundTransparency = 1
        ContentLbl.ZIndex = 6

        task.defer(function()
            targetScroll.CanvasPosition = Vector2.new(0, targetScroll.AbsoluteCanvasSize.Y)
        end)
    end

    -- ربط زر الإرسال
    local function handleSendMessage()
        local text = InputBox.Text
        if text and string.gsub(text, "%s+", "") ~= "" then
            addChatMessage(LocalPlayer.Name, LocalPlayer.UserId, text, GlobalChatScroll)
            InputBox.Text = ""
        end
    end

    SendBtn.MouseButton1Click:Connect(handleSendMessage)
    InputBox.FocusLost:Connect(function(enterPressed) if enterPressed then handleSendMessage() end end)

    addChatMessage("Ben System", 1, "مرحباً بك في شات Ben Hub العام!", GlobalChatScroll)
end
