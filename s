local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()


local player = game:GetService("Players").LocalPlayer
local shop = player.PlayerGui:FindFirstChild("Main") and player.PlayerGui.Main:FindFirstChild("CoinsShop")

local Window = Fluent:CreateWindow({
    Title = game:GetService("MarketplaceService"):GetProductInfo(109983668079237).Name ..  "  Azc Hub  ",
    SubTitle = "مصنوع بواسطه ساتورو",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 400),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Updates = Window:AddTab({ Title = "معلومات عننا", Icon = "crown" }),
    Main = Window:AddTab({ Title = "السرقه", Icon = "home" }),
    Player = Window:AddTab({ Title = "اللاعب", Icon = "user" }),
    Esp = Window:AddTab({ Title = "الكشف", Icon = "person-standing" }),
    Buy = Window:AddTab({ Title = "المتجر", Icon = "shopping-bag" }),
    Server = Window:AddTab({ Title = "الخادم", Icon = "server" }),
    Settings = Window:AddTab({ Title = "الاعدادات", Icon = "settings" }),
}

local plotName
for _, plot in ipairs(workspace.Plots:GetChildren()) do
    if plot:FindFirstChild("YourBase", true).Enabled then
        plotName = plot.Name
        break
    end
end

local remainingTime = workspace.Plots[plotName].Purchases.PlotBlock.Main.BillboardGui.RemainingTime
local rtp = Tabs.Main:AddParagraph({ Title = "Lock Time: " .. remainingTime.Text })

task.spawn(function()
    while true do
        rtp:SetTitle("Lock Time: " .. remainingTime.Text)
        task.wait(0.25)
    end
end)

Tabs.Main:AddButton({
    Title = "الانتقال للسماء",
    Description = "ينقلك للسماء حين ضغط الزر",
    Callback = function()
    local player = game.Players.LocalPlayer
local savedHeight

local function startAutoStealOnce()
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    savedHeight = humanoidRootPart.Position.Y

    local targetPosition = humanoidRootPart.Position + Vector3.new(0, 200, 0)
    humanoidRootPart.CFrame = CFrame.new(targetPosition)
    
end

startAutoStealOnce()
    end
 })

Tabs.Main:AddButton({
    Title = "الهبوط من السماء",
    Description = "يهبطك من السماء حين ضغط الزر",
    Callback = function()
 local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local distanceToMoveDown = 100

humanoidRootPart.CFrame = humanoidRootPart.CFrame - Vector3.new(0, distanceToMoveDown, 0)
        end
})

local Toggle = Tabs.Player:AddToggle("MyToggle1", {
    Title = "تعزيز السرعه", 
    Description = "يعزز ميزه السرعه حين ضغط الزر",
    Default = false,
    Callback = function(state)
	if state then
-- Script A: السرعة السريعة
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local SpeedValue = 50
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- نحفظ الاتصال علشان نلغيه بعدين
_G.SpeedConnection = RunService.RenderStepped:Connect(function()
    local moveVector = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveVector += camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveVector -= camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveVector -= camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveVector += camera.CFrame.RightVector
    end

    if moveVector.Magnitude > 0 then
        moveVector = moveVector.Unit * SpeedValue
        root.AssemblyLinearVelocity = Vector3.new(moveVector.X, root.AssemblyLinearVelocity.Y, moveVector.Z)
    end
end)

	else
-- Script B: إلغاء السرعة
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- لو الاتصال شغال، نلغيه
if _G.SpeedConnection then
	_G.SpeedConnection:Disconnect()
	_G.SpeedConnection = nil
end

-- نوقف الحركة الخارجية
root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)

-- نرجع WalkSpeed طبيعي
humanoid.WalkSpeed = 16
        end
    end 
})

local Toggle = Tabs.Player:AddToggle("MyToggle", {
    Title = "تعزيز القفز", 
    Description = "يعزز ميزه القفز حين ضغط الزر",
    Default = false,
    Callback = function(state)
        if state then
            -- ????? ????? ???????
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")

            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
            local root = character:FindFirstChild("HumanoidRootPart")

            if not humanoid or not root then
                warn("Humanoid or RootPart not found.")
                return
            end

            humanoid.UseJumpPower = true
            humanoid.JumpPower = 140

            _G.MoonJumpConnection = RunService.Stepped:Connect(function()
                if root.Velocity.Y < 0 then
                    root.Velocity = Vector3.new(root.Velocity.X, root.Velocity.Y * 1, root.Velocity.Z)
                end
            end)
        else
            -- ????? ????? ???????
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChild("Humanoid")
            local root = character:FindFirstChild("HumanoidRootPart")

            if humanoid then
                humanoid.JumpPower = 50
            end

            if _G.MoonJumpConnection then
                _G.MoonJumpConnection:Disconnect()
                _G.MoonJumpConnection = nil
            end
        end
    end
})

Tabs.Player:AddButton({
    Title = "الاختفاء",
    Description = " استخدم عباءة الإخفاء لتكون غير مرئي بدونها، لتعطيلها يجب عليك إعادة الشخصيه",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local cloak = character:FindFirstChild("Invisibility Cloak")
        if cloak and cloak:GetAttribute("SpeedModifier") == 2 then
            cloak.Parent = workspace
        else
            Fluent:Notify({ Title = "Azc Hub", Content = "يرجي استخدام عباءة الإخفاء لتكون غير مرئي", Duration = 2 })
        end
    end
})

Tabs.Player:AddButton({
    Title = "واجهه تعزيز السرعه",
    Description = "يُنشئ لك واجهة تعمل على تعزيز سرعتك",
    Callback = function()
    -- Parent GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "CustomBoostGUI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 120, 0, 60)
mainFrame.Position = UDim2.new(0, 100, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local mainUICorner = Instance.new("UICorner", mainFrame)
mainUICorner.CornerRadius = UDim.new(0, 12)

local innerFrame = Instance.new("TextButton", mainFrame)
innerFrame.Size = UDim2.new(1, -20, 1, -20)
innerFrame.Position = UDim2.new(0, 10, 0, 10)
innerFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
innerFrame.BorderSizePixel = 0
innerFrame.Text = ""
innerFrame.AutoButtonColor = false

local innerUICorner = Instance.new("UICorner", innerFrame)
innerUICorner.CornerRadius = UDim.new(0, 8)

local textLabel = Instance.new("TextLabel", innerFrame)
textLabel.Text = "تعزيز السرعه"
textLabel.Size = UDim2.new(0.7, 0, 1, 0)
textLabel.Position = UDim2.new(0, 8, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 16
textLabel.TextXAlignment = Enum.TextXAlignment.Left

local statusDot = Instance.new("Frame", innerFrame)
statusDot.Size = UDim2.new(0, 12, 0, 12)
statusDot.Position = UDim2.new(1, -20, 0.5, -6)
statusDot.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
statusDot.BorderSizePixel = 0

local dotCorner = Instance.new("UICorner", statusDot)
dotCorner.CornerRadius = UDim.new(1, 0)

-- Boost toggle logic
local boosted = false

innerFrame.MouseButton1Click:Connect(function()
	boosted = not boosted
	
	if boosted then
		-- ✅ شغل السكربت الأول هنا (لما الزر يبقى أخضر)
		statusDot.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		
-- Script A: السرعة السريعة
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local SpeedValue = 50
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- نحفظ الاتصال علشان نلغيه بعدين
_G.SpeedConnection = RunService.RenderStepped:Connect(function()
    local moveVector = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveVector += camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveVector -= camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveVector -= camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveVector += camera.CFrame.RightVector
    end

    if moveVector.Magnitude > 0 then
        moveVector = moveVector.Unit * SpeedValue
        root.AssemblyLinearVelocity = Vector3.new(moveVector.X, root.AssemblyLinearVelocity.Y, moveVector.Z)
    end
end)
	else
		-- ✅ شغل السكربت التاني هنا (لما الزر يبقى أحمر)
		statusDot.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		-- Script B: إلغاء السرعة
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- لو الاتصال شغال، نلغيه
if _G.SpeedConnection then
	_G.SpeedConnection:Disconnect()
	_G.SpeedConnection = nil
end

-- نوقف الحركة الخارجية
root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)

-- نرجع WalkSpeed طبيعي
humanoid.WalkSpeed = 16



	end
end)
    end
})

-- ESP


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local espEnabled = false
local espInstances = {}

local function createESP(player)
    if not espEnabled then return end
    if player == Players.LocalPlayer then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)
    if not humanoidRootPart then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. player.Name
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = humanoidRootPart
    billboard.Parent = humanoidRootPart
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "NameLabel"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player.DisplayName
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard
    
    espInstances[player] = billboard
    
    local function onCharacterAdded(newCharacter)
        if billboard then billboard:Destroy() end
        
        humanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart", 10)
        if humanoidRootPart and espEnabled then
            billboard.Adornee = humanoidRootPart
            billboard.Parent = humanoidRootPart
        end
    end
    
    player.CharacterAdded:Connect(onCharacterAdded)
end

local function removeESP(player)
    local espInstance = espInstances[player]
    if espInstance then
        espInstance:Destroy()
        espInstances[player] = nil
    end
end

local function toggleESP(enable)
    espEnabled = enable
    if enable then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                coroutine.wrap(function()
                    createESP(player)
                end)()
            end
        end
    else
        for player, espInstance in pairs(espInstances) do
            if espInstance then
                espInstance:Destroy()
            end
        end
        espInstances = {}
    end
end

local function initPlayerConnections()
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if player ~= Players.LocalPlayer and espEnabled then
                task.wait(1)
                createESP(player)
            end
        end)
    end)

    Players.PlayerRemoving:Connect(removeESP)
end

initPlayerConnections()

local RaritySettings = {
    ["Legendary"] = {
        Color = Color3.new(1, 1, 0),
        Size = UDim2.new(0, 150, 0, 50)
    },
    ["Mythic"] = {
        Color = Color3.new(1, 0, 0),
        Size = UDim2.new(0, 150, 0, 50)
    },
    ["Brainrot God"] = {
        Color = Color3.new(0.5, 0, 0.5),
        Size = UDim2.new(0, 180, 0, 60)
    },
    ["Secret"] = {
        Color = Color3.new(0, 0, 0),
        Size = UDim2.new(0, 200, 0, 70)
    }
}

local MutationSettings = {
    ["Gold"] = {
        Color = Color3.fromRGB(255, 215, 0),
        Size = UDim2.new(0, 120, 0, 30)
    },

    ["Diamond"] = {
        Color = Color3.fromRGB(0, 191, 255),
        Size = UDim2.new(0, 120, 0, 30)
    },

    ["Rainbow"] = {
        Color = Color3.fromRGB(255, 192, 203),
        Size = UDim2.new(0, 120, 0, 30)
    },

    ["Bloodrot"] = {
        Color = Color3.fromRGB(139, 0, 0),
        Size = UDim2.new(0, 120, 0, 30)
    }
}

local activeESP = {}
local activeLockTimeEsp = false
local lteInstances = {}

local function updatelock()
    if not activeLockTimeEsp then
        for _, instance in pairs(lteInstances) do
            if instance then
                instance:Destroy()
            end
        end
        lteInstances = {}
        return
    end

    for _, plot in pairs(workspace.Plots:GetChildren()) do
        local timeLabel = plot:FindFirstChild("Purchases", true) and 
        plot.Purchases:FindFirstChild("PlotBlock", true) and
        plot.Purchases.PlotBlock.Main:FindFirstChild("BillboardGui", true) and
        plot.Purchases.PlotBlock.Main.BillboardGui:FindFirstChild("RemainingTime", true)
        
        if timeLabel and timeLabel:IsA("TextLabel") then
            local espName = "LockTimeESP_" .. plot.Name
            local existingBillboard = plot:FindFirstChild(espName)
            
            local isUnlocked = timeLabel.Text == "0s"
            local displayText = isUnlocked and "Unlocked" or ("Lock: " .. timeLabel.Text)
            
            local textColor
            if plot.Name == plotName then
                textColor = isUnlocked and Color3.fromRGB(0, 255, 0)
                            or Color3.fromRGB(0, 255, 0)
            else
                textColor = isUnlocked and Color3.fromRGB(220, 20, 60)
                            or Color3.fromRGB(255, 255, 0)
            end
            
            if not existingBillboard then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = espName
                billboard.Size = UDim2.new(0, 200, 0, 30)
                billboard.StudsOffset = Vector3.new(0, 5, 0)
                billboard.AlwaysOnTop = true
                billboard.Adornee = plot.Purchases.PlotBlock.Main
                
                local label = Instance.new("TextLabel")
                label.Text = displayText
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextScaled = true
                label.TextColor3 = textColor
                label.TextStrokeColor3 = Color3.new(0, 0, 0)
                label.TextStrokeTransparency = 0
                label.Font = Enum.Font.SourceSansBold
                label.Parent = billboard
                
                billboard.Parent = plot
                lteInstances[plot.Name] = billboard
            else
                existingBillboard.TextLabel.Text = displayText
                existingBillboard.TextLabel.TextColor3 = textColor
            end
        end
    end
end

local function updateRESP()
    for _, plot in pairs(workspace.Plots:GetChildren()) do
        if plot.Name ~= plotName then
            for _, child in pairs(plot:GetDescendants()) do
                if child.Name == "Rarity" and child:IsA("TextLabel") and RaritySettings[child.Text] then
                    local parentModel = child.Parent.Parent
                    local espName = child.Text.."_ESP"
                    local mutationEspName = "Mutation_ESP"
                    local existingBillboard = parentModel:FindFirstChild(espName)
                    local existingMutationBillboard = parentModel:FindFirstChild(mutationEspName)
                    
                    if activeESP[child.Text] then
                        if not existingBillboard then
                            local settings = RaritySettings[child.Text]
                            
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = espName
                            billboard.Size = settings.Size
                            billboard.StudsOffset = Vector3.new(0, 3, 0)
                            billboard.AlwaysOnTop = true
                            
                            local label = Instance.new("TextLabel")
                            label.Text = child.Parent.DisplayName.Text
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.BackgroundTransparency = 1
                            label.TextScaled = true
                            label.TextColor3 = settings.Color
                            label.TextStrokeColor3 = Color3.new(0, 0, 0)
                            label.TextStrokeTransparency = 0
                            label.Font = Enum.Font.SourceSansBold
                            
                            label.Parent = billboard
                            billboard.Parent = parentModel
                        end
                        
                        local mutation = child.Parent:FindFirstChild("Mutation")
                        if mutation and mutation:IsA("TextLabel") and MutationSettings[mutation.Text] then
                            local mutationSettings = MutationSettings[mutation.Text]
                            
                            if not existingMutationBillboard then
                                local mutationBillboard = Instance.new("BillboardGui")
                                mutationBillboard.Name = mutationEspName
                                mutationBillboard.Size = mutationSettings.Size
                                mutationBillboard.StudsOffset = Vector3.new(0, 6, 0)
                                mutationBillboard.AlwaysOnTop = true
                                
                                local mutationLabel = Instance.new("TextLabel")
                                mutationLabel.Text = mutation.Text
                                mutationLabel.Size = UDim2.new(1, 0, 1, 0)
                                mutationLabel.BackgroundTransparency = 1
                                mutationLabel.TextScaled = true
                                mutationLabel.TextColor3 = mutationSettings.Color
                                mutationLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                                mutationLabel.TextStrokeTransparency = 0
                                mutationLabel.Font = Enum.Font.SourceSansBold
                                
                                mutationLabel.Parent = mutationBillboard
                                mutationBillboard.Parent = parentModel
                            else
                                existingMutationBillboard.TextLabel.Text = mutation.Text
                                existingMutationBillboard.TextLabel.TextColor3 = mutationSettings.Color
                            end
                        elseif existingMutationBillboard then
                            existingMutationBillboard:Destroy()
                        end
                    else
                        if existingBillboard then
                            existingBillboard:Destroy()
                        end
                        if existingMutationBillboard then
                            existingMutationBillboard:Destroy()
                        end
                    end
                end
            end
        end
    end
end

local MultiDropdown = Tabs.Esp:AddDropdown("MultiDropdown", {
    Title = "الكشف",
    Values = {"Lock", "Players", "Legendary", "Mythic", "Brainrot God", "Secret",}
    Multi = true,
    Default = {},
})

MultiDropdown:OnChanged(function(Value)
    if Value["Player"] then
        toggleESP(true)
    else
        toggleESP(false)
    end
    activeESP["Legendary"] = Value["Legendary"] or false
    activeESP["Mythic"] = Value["Mythic"] or false
    activeESP["Brainrot God"] = Value["Brainrot God"] or false
    activeESP["Secret"] = Value["Secret"] or false
    
    activeLockTimeEsp = Value["Lock"] or false
    updatelock()
    
    updateRESP()
    
end)

task.spawn(function()
    while true do
        task.wait(0.25)
        if activeLockTimeEsp then
            updatelock()
        end
        if next(activeESP) ~= nil then
            updateRESP()
        end
    end
end)

Tabs.Buy:AddButton({
    Title = "Slap",
    Description = "شراء الصفعه",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Slap")
    end
})

Tabs.Buy:AddButton({
    Title = "Speed Coil",
    Description = "شراء لفائف السرعة",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Speed Coil")
    end
})

Tabs.Buy:AddButton({
    Title = "Trap",
    Description = "شراء الفخ",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Trap")
    end
})

Tabs.Buy:AddButton({
    Title = "Iron Slap",
    Description = "شراء الصفعه الحديديه",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Iron Slap")
    end
})

Tabs.Buy:AddButton({
    Title = "Gravity Coil",
    Description = "شراء لفائف الجاذبيه",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Gravity Coil")
    end
})

Tabs.Buy:AddButton({
    Title = "Bee Launcher",
    Description = "شراء قاذف النحل",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Bee Launcher")
    end
})

Tabs.Buy:AddButton({
    Title = "Gold Slap",
    Description = "شراء الصفعه الذهبيه",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Gold Slap")
    end
})

Tabs.Buy:AddButton({
    Title = "Coil Combo",
    Description = "Auto Buy Coil Combo",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Coil Combo")
    end
})

Tabs.Buy:AddButton({
    Title = "Rage Table",
    Description = "Auto Buy Rage Table",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Rage Table")
    end
})

Tabs.Buy:AddButton({
    Title = "Diamond Slap",
    Description = "Auto Buy Diamond Slap",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Diamond Slap")
    end
})

Tabs.Buy:AddButton({
    Title = "Grapple Hook",
    Description = "Auto Buy Grapple Hook",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
local Buy = Net:WaitForChild("RF/CoinsShopService/RequestBuy")

Buy:InvokeServer("Grapple Hook")
    end
})

Tabs.Main:AddKeybind("Keybind", {
    Title = "Shop",
    Mode = "Toggle",
    Default = "F",
    Description = "Opens/Closes shop",
    Callback = function(Value)
        shop.Visible = Valu
        shop.Position = Value and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 1.5, 0)
    end,
})

Tabs.Server:AddSection("Server")


Tabs.Server:AddButton({
    Title = "Hop Server",
    Description = "Joins The Most Op Server",
    Callback = function()
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        local Deleted = false
        local File = pcall(function()
            AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
        end)
        if not File then
            table.insert(AllIDs, actualHour)
            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
        end
        function TPReturner()
            local Site;
            if foundAnything == "" then
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            end
            local ID = ""
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                foundAnything = Site.nextPageCursor
            end
            local num = 0;
            for _,v in pairs(Site.data) do
                local Possible = true
                ID = tostring(v.id)
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    for _,Existing in pairs(AllIDs) do
                        if num ~= 0 then
                            if ID == tostring(Existing) then
                                Possible = false
                                end
                            else
                                if tonumber(actualHour) ~= tonumber(Existing) then
                                    local delFile = pcall(function()
                                        delfile("NotSameServers.json")
                                        AllIDs = {}
                                        table.insert(AllIDs, actualHour)
                                        end)
                                    end
                                end
                            num = num + 1
                        end
                    if Possible == true then
                        table.insert(AllIDs, ID)
                        task.wait()
                        pcall(function()
                            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                            task.wait()
                            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                        end)
                task.wait(4)
            end
        end
    end
end
function Teleport()
    while task.wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end
Teleport()
    end
})

Tabs.Server:AddButton({
    Title = "Rejoin",
    Description = "Rejoins The Same Server",
    Callback = function()
        local ts = game:GetService("TeleportService")
        local p = game:GetService("Players").LocalPlayer
        ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
    end
})


local Timer = Tabs.Updates:AddParagraph({ Title = "Time: 00:00:00" })
local st = os.time()

task.spawn(function()
    while true do
        local et = os.difftime(os.time(), st)
        Timer:SetTitle(string.format("Time: %02d:%02d:%02d", math.floor(et / 3600), math.floor((et % 3600) / 60), et % 60))
        task.wait(1)
    end
end)

Tabs.Updates:AddButton({
    Title = "Discord Server",
    Description = "Copies Discord Invite Link",
    Callback = function()
        setclipboard("https://discord.gg/3ENXpTrx2b")
        Fluent:Notify({ Title = "Limitless Legacy", Content = "Copied Successfully", Duration = 2 })
    end
})


Tabs.Updates:AddButton({
    Title = "Execute Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

Window:SelectTab(1)
