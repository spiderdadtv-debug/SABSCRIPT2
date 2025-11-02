-- Script to activate all pre-built buttons when one is clicked

-- Function to simulate a mouse click on a GUI button
local function clickButton(button)
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    mouse.Target = button
    mouse:MouseButton1Click(button.Position)
end

-- Function to activate all pre-built buttons
local function activateAllButtons()
    local adminPanel = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("AdminPanel")
    for _, button in ipairs(adminPanel:GetChildren()) do
        if button:IsA("TextButton") and button.Name ~= "CommandInput" then
            clickButton(button)
        end
    end
end

-- Connect a click event to one of the pre-built buttons
local targetButton = game:GetService("Players").LocalPlayer.PlayerGui.AdminPanel:WaitForChild("RocketButton") -- Replace with the actual button name
targetButton.MouseButton1Click:Connect(activateAllButtons)
