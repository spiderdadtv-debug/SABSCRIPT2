-- Script to activate all admin panel commands and assign them to different players when ;rocket is clicked

-- Function to simulate a mouse click on a GUI button
local function clickButton(button)
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    mouse.Target = button
    mouse:MouseButton1Click(button.Position)
end

-- Function to send a command to the admin panel for a specific player
local function sendCommandToPlayer(player, command)
    local adminPanel = player.PlayerGui:WaitForChild("AdminPanel")
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

-- Function to activate all commands for different players
local function activateAllCommandsForPlayers()
    local players = game:GetService("Players"):GetPlayers()
    for i, player in ipairs(players) do
        local command = allCommands[i % #allCommands + 1] -- Cycle through commands
        sendCommandToPlayer(player, command)
    end
end

-- Connect the ;rocket command to the activateAllCommandsForPlayers function
game:GetService("Players").LocalPlayer.PlayerGui.AdminPanel.CommandInput.FocusLost:Connect(function(enterPressed, inputObject)
    if enterPressed and inputObject.Text == ";rocket" then
        activateAllCommandsForPlayers()
    end
end)
