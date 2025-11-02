-- Ensure the script runs on the client side
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Function to set the cooldown for a tool
local function setToolCooldown(tool, cooldown)
    local toolScript = tool:FindFirstChildOfClass("LocalScript")
    if toolScript then
        toolScript.Disabled = true
        toolScript:Destroy()
    end

    local newScript = Instance.new("LocalScript")
    newScript.Name = "ToolCooldownScript"
    newScript.Parent = tool

    newScript.Source = [[
        local tool = script.Parent
        local cooldownTime = ]] .. cooldown .. [[
        local canUse = true

        tool.Activated:Connect(function()
            if canUse then
                canUse = false
                tool:WaitForChild("Handle").Transparency = 0.5
                wait(cooldownTime)
                tool:WaitForChild("Handle").Transparency = 0
                canUse = true
            end
        end)
    ]]

    newScript.Disabled = false
end

-- Function to apply the cooldown to all tools in the game
local function applyCooldownToAllTools(cooldown)
    for _, player in ipairs(Players:GetPlayers()) do
        for _, tool in ipairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                setToolCooldown(tool, cooldown)
            end
        end
    end

    Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Connect(function(character)
            for _, tool in ipairs(newPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    setToolCooldown(tool, cooldown)
                end
            end
        end)
    end)
end

-- Apply the cooldown of 2 seconds to all tools
applyCooldownToAllTools(2)
