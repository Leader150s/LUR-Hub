-- ===================================================
-- 👑 LUR HUB - Global Chat Module (ChatModule.lua)
-- Updated: Public Chat Only & Fixed UI
-- ===================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

return function(ChatPage)
    -- عنوان أو رأسية الشات العام
    local ChatTopBar = Instance.new("Frame", ChatPage)
    ChatTopBar.Size = UDim2.new(1, 0, 0, 26)
    ChatTopBar.BackgroundTransparency = 1
    ChatTopBar.ZIndex = 4

    local GlobalTitle = Instance.new("TextButton", ChatTopBar)
    GlobalTitle.Size = UDim2.new(1, 0, 1, 0)
    GlobalTitle.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    GlobalTitle.Text = "🌐 الشات العام (LUR Hub)"
    GlobalTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    GlobalTitle.Font = Enum.Font.SourceSansBold
    GlobalTitle.TextSize = 12
    GlobalTitle.ZIndex = 5
    Instance.new("UICorner", GlobalTitle).CornerRadius = UDim.new(0, 5)

    -- شاشة الشات العام (مكبرة لتأخذ المساحة بالكامل بعد إزالة الخاص)
    local GlobalChatScroll = Instance.new("ScrollingFrame", ChatPage)
    GlobalChatScroll.Size = UDim2.new(1, 0, 0.72, 0)
    GlobalChatScroll.Position = UDim2.new(0, 0, 0, 32)
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
    InputBox.Size = UDim2.new(0.72, 0, 0, 30)
    InputBox.Position = UDim2.new(0, 0, 0.82, 0)
    InputBox.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
    InputBox.PlaceholderText = "اكتب رسالتك هنا..."
    InputBox.Text = ""
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.Font = Enum.Font.SourceSans
    InputBox.TextSize = 11
    InputBox.ClearTextOnFocus = false
    InputBox.ZIndex = 4
    Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 5)

    local SendBtn = Instance.new("TextButton", ChatPage)
    SendBtn.Size = UDim2.new(0.25, 0, 0, 30)
    SendBtn.Position = UDim2.new(0.74, 0, 0.82, 0)
    SendBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    SendBtn.Text = "إرسال 🚀"
    SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SendBtn.Font = Enum.Font.SourceSansBold
    SendBtn.TextSize = 11
    SendBtn.ZIndex = 4
    Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 5)

    -- فلتر الكلمات البذيئة والروابط
    local badWords = {"انعل", "ابوك", "امك", "ختك", "أختك", "اختك", "رب", "دين", "كلب", "حمار", "سب", "كس", "قحبة", "طيز", "زب", "منيوك", "قواد", "http", "https", "www", "%.com", "%.gg"}

    local function filterText(msg)
        local lowerMsg = string.lower(msg)
        for _, word in pairs(badWords) do
            if string.find(lowerMsg, string.lower(word)) then
                return "[رسالة محظورة 🚫]"
            end
        end
        return msg
    end

    -- دالة إضافة رسالة للشات
    local function addChatMessage(senderName, userId, messageText)
        if not messageText or messageText == "" then return end

        local msgFrame = Instance.new("Frame", GlobalChatScroll)
        msgFrame.Size = UDim2.new(0.98, 0, 0, 34)
        msgFrame.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
        msgFrame.BackgroundTransparency = 0.2
        msgFrame.ZIndex = 5
        Instance.new("UICorner", msgFrame).CornerRadius = UDim.new(0, 5)

        local AvatarImg = Instance.new("ImageLabel", msgFrame)
        AvatarImg.Size = UDim2.new(0, 26, 0, 26)
        AvatarImg.Position = UDim2.new(0.02, 0, 0.12, 0)
        AvatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userId) .. "&w=150&h=150"
        AvatarImg.BackgroundTransparency = 1
        AvatarImg.ZIndex = 6
        Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(1, 0)

        local ContentLbl = Instance.new("TextLabel", msgFrame)
        ContentLbl.Size = UDim2.new(0.83, 0, 1, 0)
        ContentLbl.Position = UDim2.new(0.14, 0, 0, 0)
        ContentLbl.Text = "[" .. senderName .. "]: " .. filterText(messageText)
        ContentLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        ContentLbl.Font = Enum.Font.SourceSansBold
        ContentLbl.TextSize = 11
        ContentLbl.TextXAlignment = Enum.TextXAlignment.Left
        ContentLbl.TextWrapped = true
        ContentLbl.BackgroundTransparency = 1
        ContentLbl.ZIndex = 6

        task.defer(function()
            GlobalChatScroll.CanvasPosition = Vector2.new(0, GlobalChatScroll.AbsoluteCanvasSize.Y)
        end)
    end

    -- ربط زر الإرسال
    local function handleSendMessage()
        local text = InputBox.Text
        if text and string.gsub(text, "%s+", "") ~= "" then
            addChatMessage(LocalPlayer.Name, LocalPlayer.UserId, text)
            InputBox.Text = ""
        end
    end

    SendBtn.MouseButton1Click:Connect(handleSendMessage)
    InputBox.FocusLost:Connect(function(enterPressed) if enterPressed then handleSendMessage() end end)

    addChatMessage("LUR System", 1, "مرحباً بك في الشات العام لـ LUR Hub!")
end
