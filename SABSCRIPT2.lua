-- Ensure the script runs on the client side
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Function to set the cooldown for the Medusa Head
local function setMedusaHeadCooldown(cooldown)
    local player = Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    local tool = backpack:FindFirstChild("Medusa Head")

    if tool then
        local toolScript = tool:FindFirstChildOfClass("LocalScript")
        if toolScript then
            toolScript.Disabled = true
            toolScript:Destroy()
        end

        local newScript = Instance.new("LocalScript")
        newScript.Name = "MedusaHeadCooldownScript"
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
end

-- Apply the cooldown of 2 seconds to the Medusa Head
setMedusaHeadCooldown(2)
