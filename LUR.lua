-- ===================================================
-- 👑 BEN HUB - Official Executing Hub & Custom Theme
-- Version 4.0 | Private DMs, Strict Filter & Auto Clear
-- ===================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- ==================== تحميل الصور الخارجية ====================
local function loadAsset(url, filename)
    if writefile and readfile and getcustomasset then
        pcall(function()
            if not pcall(function() readfile(filename) end) then
                writefile(filename, game:HttpGet(url))
            end
        end)
        local success, asset = pcall(function() return getcustomasset(filename) end)
        if success then return asset end
    end
    return url
end

local BG_IMAGE_ID = loadAsset("https://f.top4top.io/p_3917lvgp10.png", "BenHub_BG.png")
local TOGGLE_IMAGE_ID = loadAsset("https://g.top4top.io/p_3917nj3r41.png", "BenHub_Icon.png")

-- ==================== إنشاء الشاشة الرئيسية ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BenHub_OfficialUI"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 290)
MainFrame.Position = UDim2.new(0.5, -230, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(220, 30, 40)
UIStroke.Thickness = 2

local BackgroundImg = Instance.new("ImageLabel", MainFrame)
BackgroundImg.Size = UDim2.new(1, 0, 1, 0)
BackgroundImg.Image = BG_IMAGE_ID
BackgroundImg.BackgroundTransparency = 1
BackgroundImg.ImageTransparency = 0.55
BackgroundImg.ScaleType = Enum.ScaleType.Crop

-- ==================== دالة السحب والتحريك ====================
local function makeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(MainFrame)

-- ==================== الزر الدائري القابل للتحريك ====================
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Name = "BenHubToggleBtn"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.08, 0, 0.2, 0)
ToggleBtn.Image = TOGGLE_IMAGE_ID
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Visible = false
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(220, 30, 40)
ToggleStroke.Thickness = 2

makeDraggable(ToggleBtn)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ==================== الشريط العلوي (Top Bar) ====================
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 10, 12)
TopBar.BackgroundTransparency = 0.2
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0.28, 0, 1, 0)
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Text = "👑 BEN HUB"
Title.TextColor3 = Color3.fromRGB(255, 40, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local CounterFrame = Instance.new("Frame", TopBar)
CounterFrame.Size = UDim2.new(0.48, 0, 0.7, 0)
CounterFrame.Position = UDim2.new(0.31, 0, 0.15, 0)
CounterFrame.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
CounterFrame.BackgroundTransparency = 0.3
Instance.new("UICorner", CounterFrame).CornerRadius = UDim.new(0, 6)

local StatsLabel = Instance.new("TextLabel", CounterFrame)
StatsLabel.Size = UDim2.new(1, 0, 1, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextColor3 = Color3.fromRGB(255, 220, 220)
StatsLabel.Font = Enum.Font.SourceSansBold
StatsLabel.TextSize = 10
StatsLabel.Text = "👥 التجارب: جاري التحميل... | 🟢 أونلاين: ..."

local function updateRealStats()
    local realOnline = #Players:GetPlayers()
    local totalRuns = 1845
    pcall(function()
        local res = game:HttpGet("https://api.counterapi.dev/v1/benhub_official_v3/runs/up")
        if res then
            local count = string.match(res, '"count":%s*(%d+)')
            if count then totalRuns = tonumber(count) end
        end
    end)
    StatsLabel.Text = "👥 التجارب: " .. tostring(totalRuns) .. " | 🟢 أونلاين: " .. tostring(realOnline)
end
task.spawn(updateRealStats)

local DestroyBtn = Instance.new("TextButton", TopBar)
DestroyBtn.Size = UDim2.new(0, 28, 0, 28)
DestroyBtn.Position = UDim2.new(0.83, 0, 0.16, 0)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 25)
DestroyBtn.Text = "🗑️"
DestroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyBtn.Font = Enum.Font.SourceSansBold
DestroyBtn.TextSize = 13
Instance.new("UICorner", DestroyBtn).CornerRadius = UDim.new(0, 6)
DestroyBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(0.91, 0, 0.16, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false ToggleBtn.Visible = true end)

-- ==================== القائمة الجانبية ====================
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 115, 1, -48)
Sidebar.Position = UDim2.new(0, 5, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 8, 10)
Sidebar.BackgroundTransparency = 0.3
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -130, 1, -48)
Container.Position = UDim2.new(0, 125, 0, 45)
Container.BackgroundTransparency = 1

local Tabs, Pages = {}, {}

local function createTab(name, icon)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, #Tabs * 34 + 5)
    btn.BackgroundColor3 = (#Tabs == 0) and Color3.fromRGB(190, 25, 35) or Color3.fromRGB(30, 15, 20)
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("Frame", Container)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (#Tabs == 0)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(Tabs) do b.BackgroundColor3 = Color3.fromRGB(30, 15, 20) end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    end)

    table.insert(Tabs, btn)
    table.insert(Pages, page)
    return page
end

local EggPage = createTab("سرقة البيض", "🥚")
local AnimalPage = createTab("ركوب الحيوانات", "🐾")
local ExecutorPage = createTab("مشغل السكربتات", "📜")
local TutorialPage = createTab("شروحات", "📚")
local ChatPage = createTab("الشات", "💬")

-- ==================== 💬 نظام الشات المطور والخاص ====================
local ChatMode = "Global" -- "Global" أو "Private"
local ActivePrivateFriend = nil
local FriendsList = {}

local ChatTopBar = Instance.new("Frame", ChatPage)
ChatTopBar.Size = UDim2.new(1, 0, 0, 26)
ChatTopBar.BackgroundTransparency = 1

local GlobalBtn = Instance.new("TextButton", ChatTopBar)
GlobalBtn.Size = UDim2.new(0.48, 0, 1, 0)
GlobalBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
GlobalBtn.Text = "🌐 شات عام"
GlobalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GlobalBtn.Font = Enum.Font.SourceSansBold
GlobalBtn.TextSize = 11
Instance.new("UICorner", GlobalBtn).CornerRadius = UDim.new(0, 5)

local PrivateBtn = Instance.new("TextButton", ChatTopBar)
PrivateBtn.Size = UDim2.new(0.48, 0, 1, 0)
PrivateBtn.Position = UDim2.new(0.51, 0, 0, 0)
PrivateBtn.BackgroundColor3 = Color3.fromRGB(35, 15, 20)
PrivateBtn.Text = "🔒 شات خاص"
PrivateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PrivateBtn.Font = Enum.Font.SourceSansBold
PrivateBtn.TextSize = 11
Instance.new("UICorner", PrivateBtn).CornerRadius = UDim.new(0, 5)

-- إطار الشات العام
local GlobalChatScroll = Instance.new("ScrollingFrame", ChatPage)
GlobalChatScroll.Size = UDim2.new(1, 0, 0.65, 0)
GlobalChatScroll.Position = UDim2.new(0, 0, 0, 30)
GlobalChatScroll.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
GlobalChatScroll.BackgroundTransparency = 0.3
GlobalChatScroll.ScrollBarThickness = 3
GlobalChatScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
GlobalChatScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Instance.new("UICorner", GlobalChatScroll).CornerRadius = UDim.new(0, 6)

local GlobalLayout = Instance.new("UIListLayout", GlobalChatScroll)
GlobalLayout.Padding = UDim.new(0, 4)

-- إطار الشات الخاص والأصدقاء
local PrivateMainFrame = Instance.new("Frame", ChatPage)
PrivateMainFrame.Size = UDim2.new(1, 0, 0.65, 0)
PrivateMainFrame.Position = UDim2.new(0, 0, 0, 30)
PrivateMainFrame.BackgroundTransparency = 1
PrivateMainFrame.Visible = false

-- قائمة الأصدقاء على اليسار
local FriendsFrame = Instance.new("Frame", PrivateMainFrame)
FriendsFrame.Size = UDim2.new(0.38, 0, 1, 0)
FriendsFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
FriendsFrame.BackgroundTransparency = 0.3
Instance.new("UICorner", FriendsFrame).CornerRadius = UDim.new(0, 6)

local AddFriendBtn = Instance.new("TextButton", FriendsFrame)
AddFriendBtn.Size = UDim2.new(0.92, 0, 0, 22)
AddFriendBtn.Position = UDim2.new(0.04, 0, 0.04, 0)
AddFriendBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
AddFriendBtn.Text = "➕ إضافة صديق"
AddFriendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AddFriendBtn.Font = Enum.Font.SourceSansBold
AddFriendBtn.TextSize = 10
Instance.new("UICorner", AddFriendBtn).CornerRadius = UDim.new(0, 5)

local FriendsScroll = Instance.new("ScrollingFrame", FriendsFrame)
FriendsScroll.Size = UDim2.new(0.92, 0, 0.8, 0)
FriendsScroll.Position = UDim2.new(0.04, 0, 0.16, 0)
FriendsScroll.BackgroundTransparency = 1
FriendsScroll.ScrollBarThickness = 2
local FriendsLayout = Instance.new("UIListLayout", FriendsScroll)
FriendsLayout.Padding = UDim.new(0, 3)

-- شاشة الرسائل الخاصة المباشرة
local PrivateChatScroll = Instance.new("ScrollingFrame", PrivateMainFrame)
PrivateChatScroll.Size = UDim2.new(0.6, 0, 1, 0)
PrivateChatScroll.Position = UDim2.new(0.4, 0, 0, 0)
PrivateChatScroll.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
PrivateChatScroll.BackgroundTransparency = 0.3
PrivateChatScroll.ScrollBarThickness = 3
PrivateChatScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
PrivateChatScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Instance.new("UICorner", PrivateChatScroll).CornerRadius = UDim.new(0, 6)

local PrivateLayout = Instance.new("UIListLayout", PrivateChatScroll)
PrivateLayout.Padding = UDim.new(0, 4)

-- نافذة إدخال اسم الصديق
local AddFriendModal = Instance.new("Frame", ChatPage)
AddFriendModal.Size = UDim2.new(0.8, 0, 0.45, 0)
AddFriendModal.Position = UDim2.new(0.1, 0, 0.25, 0)
AddFriendModal.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
AddFriendModal.Visible = false
AddFriendModal.ZIndex = 5
Instance.new("UICorner", AddFriendModal).CornerRadius = UDim.new(0, 8)

local SearchInput = Instance.new("TextBox", AddFriendModal)
SearchInput.Size = UDim2.new(0.9, 0, 0, 26)
SearchInput.Position = UDim2.new(0.05, 0, 0.2, 0)
SearchInput.BackgroundColor3 = Color3.fromRGB(15, 8, 10)
SearchInput.PlaceholderText = "اكتب اسم حساب روبلوكس..."
SearchInput.Text = ""
SearchInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchInput.Font = Enum.Font.SourceSans
SearchInput.TextSize = 11
SearchInput.ZIndex = 6
Instance.new("UICorner", SearchInput).CornerRadius = UDim.new(0, 5)

local ConfirmAddBtn = Instance.new("TextButton", AddFriendModal)
ConfirmAddBtn.Size = UDim2.new(0.42, 0, 0, 24)
ConfirmAddBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
ConfirmAddBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
ConfirmAddBtn.Text = "إضافة"
ConfirmAddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmAddBtn.Font = Enum.Font.SourceSansBold
ConfirmAddBtn.TextSize = 11
ConfirmAddBtn.ZIndex = 6
Instance.new("UICorner", ConfirmAddBtn).CornerRadius = UDim.new(0, 5)

local CancelAddBtn = Instance.new("TextButton", AddFriendModal)
CancelAddBtn.Size = UDim2.new(0.42, 0, 0, 24)
CancelAddBtn.Position = UDim2.new(0.53, 0, 0.6, 0)
CancelAddBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CancelAddBtn.Text = "إلغاء"
CancelAddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelAddBtn.Font = Enum.Font.SourceSansBold
CancelAddBtn.TextSize = 11
CancelAddBtn.ZIndex = 6
Instance.new("UICorner", CancelAddBtn).CornerRadius = UDim.new(0, 5)

AddFriendBtn.MouseButton1Click:Connect(function() AddFriendModal.Visible = true end)
CancelAddBtn.MouseButton1Click:Connect(function() AddFriendModal.Visible = false SearchInput.Text = "" end)

-- أدوات الكتابة والإرسال السفلي
local InputBox = Instance.new("TextBox", ChatPage)
InputBox.Size = UDim2.new(0.72, 0, 0, 28)
InputBox.Position = UDim2.new(0, 0, 0.83, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
InputBox.PlaceholderText = "اكتب رسالتك هنا..."
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.SourceSans
InputBox.TextSize = 11
InputBox.ClearTextOnFocus = false
Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 5)

local SendBtn = Instance.new("TextButton", ChatPage)
SendBtn.Size = UDim2.new(0.25, 0, 0, 28)
SendBtn.Position = UDim2.new(0.74, 0, 0.83, 0)
SendBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
SendBtn.Text = "إرسال 🚀"
SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendBtn.Font = Enum.Font.SourceSansBold
SendBtn.TextSize = 11
Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 5)

-- ==================== 🔥 نظام الفلترة والمحتوى المطور ====================
local badWords = {
    "انعل", "ابوك", "امك", "ختك", "أختك", "اختك", "رب", "دين", "الله", "كلب", "حمار", "سب", "كس", "قحبة", 
    "طيز", "زب", "منيوك", "قواد", "http", "https", "www", "%.com", "%.gg", "%.net", "%.org"
}

local function filterText(msg)
    local lowerMsg = string.lower(msg)
    for _, word in pairs(badWords) do
        if string.find(lowerMsg, string.lower(word)) then
            return "[رسالة محظورة 🚫: يمنع الشتم والروابط والكفر]"
        end
    end
    return msg
end

local function addChatMessage(senderName, userId, messageText, targetScroll)
    if not messageText or messageText == "" then return end
    targetScroll = targetScroll or GlobalChatScroll

    local msgFrame = Instance.new("Frame", targetScroll)
    msgFrame.Size = UDim2.new(0.98, 0, 0, 32)
    msgFrame.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
    msgFrame.BackgroundTransparency = 0.2
    Instance.new("UICorner", msgFrame).CornerRadius = UDim.new(0, 5)

    local AvatarImg = Instance.new("ImageLabel", msgFrame)
    AvatarImg.Size = UDim2.new(0, 24, 0, 24)
    AvatarImg.Position = UDim2.new(0.02, 0, 0.12, 0)
    AvatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userId) .. "&w=150&h=150"
    AvatarImg.BackgroundTransparency = 1
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

    task.defer(function()
        targetScroll.CanvasPosition = Vector2.new(0, targetScroll.AbsoluteCanvasSize.Y)
    end)
end

-- إضافة صديق للقائمة
local function addNewFriend(username)
    if username == "" or FriendsList[username] then return end
    
    local success, userId = pcall(function()
        return Players:GetUserIdFromNameAsync(username)
    end)

    if not success or not userId then
        ConfirmAddBtn.Text = "غير موجود!"
        task.wait(1)
        ConfirmAddBtn.Text = "إضافة"
        return
    end

    FriendsList[username] = userId

    local fBtn = Instance.new("TextButton", FriendsScroll)
    fBtn.Size = UDim2.new(1, 0, 0, 26)
    fBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
    fBtn.Text = "👤 " .. username
    fBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fBtn.Font = Enum.Font.SourceSansBold
    fBtn.TextSize = 10
    Instance.new("UICorner", fBtn).CornerRadius = UDim.new(0, 5)

    fBtn.MouseButton1Click:Connect(function()
        ActivePrivateFriend = {Name = username, Id = userId}
        for _, child in pairs(FriendsScroll:GetChildren()) do
            if child:IsA("TextButton") then child.BackgroundColor3 = Color3.fromRGB(30, 15, 20) end
        end
        fBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
        InputBox.PlaceholderText = "رسالة خاصة إلى " .. username .. "..."
    end)

    AddFriendModal.Visible = false
    SearchInput.Text = ""
end

ConfirmAddBtn.MouseButton1Click:Connect(function()
    addNewFriend(SearchInput.Text)
end)

local function handleSendMessage()
    local text = InputBox.Text
    if text and string.gsub(text, "%s+", "") ~= "" then
        if ChatMode == "Global" then
            addChatMessage(LocalPlayer.Name, LocalPlayer.UserId, text, GlobalChatScroll)
        elseif ChatMode == "Private" then
            if ActivePrivateFriend then
                addChatMessage(LocalPlayer.Name, LocalPlayer.UserId, text, PrivateChatScroll)
            else
                InputBox.PlaceholderText = "اختر صديق أولاً من القائمة!"
            end
        end
        InputBox.Text = ""
    end
end

SendBtn.MouseButton1Click:Connect(handleSendMessage)
InputBox.FocusLost:Connect(function(enterPressed) if enterPressed then handleSendMessage() end end)

GlobalBtn.MouseButton1Click:Connect(function()
    ChatMode = "Global"
    GlobalBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    PrivateBtn.BackgroundColor3 = Color3.fromRGB(35, 15, 20)
    GlobalChatScroll.Visible = true
    PrivateMainFrame.Visible = false
    InputBox.PlaceholderText = "اكتب رسالتك في الشات العام..."
end)

PrivateBtn.MouseButton1Click:Connect(function()
    ChatMode = "Private"
    PrivateBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    GlobalBtn.BackgroundColor3 = Color3.fromRGB(35, 15, 20)
    GlobalChatScroll.Visible = false
    PrivateMainFrame.Visible = true
    if ActivePrivateFriend then
        InputBox.PlaceholderText = "رسالة خاصة إلى " .. ActivePrivateFriend.Name .. "..."
    else
        InputBox.PlaceholderText = "اختر صديق أولاً للدردشة الخاصة..."
    end
end)

-- ⏰ تنظيف ورست الشات العام تلقائياً كل 3 دقائق (180 ثانية)
task.spawn(function()
    while task.wait(180) do
        for _, child in pairs(GlobalChatScroll:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        addChatMessage("الأنظمة", 1, "🔄 تم إعادة ضبط وتنظيف الشات العام تلقائياً.", GlobalChatScroll)
    end
end)

-- رسائل ترحيب أولية
addChatMessage("Ben System", 1, "مرحباً بك في شات Ben Hub العام! (يرست الشات كل 3 دقائق).", GlobalChatScroll)
addChatMessage("Ben System", 1, "اختر صديق أو أضف اسم حسابه للبدء بالمحادثة الخاصة.", PrivateChatScroll)
