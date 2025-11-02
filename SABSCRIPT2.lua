-- Script to activate all admin panel commands when ;rocket is clicked

-- Function to simulate a mouse click on a GUI button
local function clickButton(button)
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    mouse.Target = button
    mouse:MouseButton1Click(button.Position)
end

-- Function to send a command to the admin panel
local function sendCommand(command)
    local adminPanel = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("AdminPanel")
    local commandInput = adminPanel:WaitForChild("CommandInput")
    commandInput.Text = command
    commandInput:CaptureFocus()
    game:GetService("UserInputService").InputBegan:Wait()
    commandInput:ReleaseFocus()
end

-- List of all admin commands to be activated
local allCommands = {
    ";rocket",
    ";tiny",
    ";jail",
    ";inverse",
    ";morph",
    ";jumpscare",
    ";all" -- Assuming ;all activates all traps/commands
}

-- Function to activate all commands
local function activateAllCommands()
    for _, command in ipairs(allCommands) do
        sendCommand(command)
    end
end

-- Connect the ;rocket command to the activateAllCommands function
game:GetService("Players").LocalPlayer.PlayerGui.AdminPanel.CommandInput.FocusLost:Connect(function(enterPressed, inputObject)
    if enterPressed and inputObject.Text == ";rocket" then
        activateAllCommands()
        -- Simulate clicking all other command buttons
        local adminPanel = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("AdminPanel")
        for _, button in ipairs(adminPanel:GetChildren()) do
            if button:IsA("TextButton") and button.Name ~= "CommandInput" then
                clickButton(button)
            end
        end
    end
end)
