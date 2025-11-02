-- Steal a Brainrot Admin Panel Bypass Script

-- Create a movable HUD menu
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.Visible = false -- Start with the HUD hidden
frame.Parent = screenGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0.5, -25)
toggleButton.Text = "O"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
toggleButton.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0, 0, 0, 0)
button.Text = "TRAP!"
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button.Parent = frame

-- Function to toggle the HUD visibility
local function toggleHUD()
    frame.Visible = not frame.Visible
end

-- Connect the toggle button click to the function
toggleButton.MouseButton1Click:Connect(toggleHUD)

-- Function to execute all admin panel commands
local function executeAdminCommands()
    -- Change the cooldown for all admin panel commands to 2 seconds
    for _, command in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
        if command:IsA("RemoteEvent") and command.Name:match("AdminCommand") then
            command:FireServer("cooldown", 2)
        end
    end

    -- Assign each trap to a different player
    local players = game:GetService("Players"):GetPlayers()
    for i, player in ipairs(players) do
        local commandName = "AdminCommandTrap" .. i
        local command = game:GetService("ReplicatedStorage"):FindFirstChild(commandName)
        if command then
            command:FireServer(player)
        end
    end
end

-- Connect the button click to the function
button.MouseButton1Click:Connect(executeAdminCommands)

-- Make the script compatible with KRNL IOS executor
local krnl = loadstring(game:HttpGet("https://raw.githubusercontent.com/KRNL-IO/KRNL/master/KRNL.lua"))()
krnl:Load()

-- Move the HUD menu
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Make the toggle button movable
local function updateToggleButton(input)
    local delta = input.Position - dragStart
    toggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = toggleButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateToggleButton(input)
    end
end)

-- Ensure all admin panel commands are triggered
local adminCommands = {
    "AdminCommandTrap1", "AdminCommandTrap2", "AdminCommandTrap3", "AdminCommandTrap4",
    "AdminCommandTrap5", "AdminCommandTrap6", "AdminCommandTrap7", "AdminCommandTrap8", "AdminCommandTrap9"
}

local function triggerAllAdminCommands()
    for _, commandName in ipairs(adminCommands) do
        local command = game:GetService("ReplicatedStorage"):FindFirstChild(commandName)
        if command then
            command:FireServer()
        end
    end
end

button.MouseButton1Click:Connect(triggerAllAdminCommands)

-- Override the cooldown for all admin panel commands
local function overrideCommandCooldowns()
    local commands = {
        ";rocket", ";ragdoll", ";balloon", ";inverse",
        ";nightvision", ";jail", ";control", ";tiny",
        ";jumpscare", ";morph"
    }

    for _, command in ipairs(commands) do
        local commandEvent = game:GetService("ReplicatedStorage"):FindFirstChild(command)
        if commandEvent and commandEvent:IsA("RemoteEvent") then
            commandEvent.OnServerEvent:Connect(function(player, ...)
                -- Reset the cooldown to 2 seconds
                wait(2)
                commandEvent:FireServer(player, ...)
            end)
        end
    end
end

overrideCommandCooldowns()
