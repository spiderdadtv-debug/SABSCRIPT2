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
            local lastUsed = tick()

            tool.Activated:Connect(function()
                if tick() - lastUsed >= cooldownTime then
                    lastUsed = tick()
                    -- Add any additional logic for using the Medusa Head here
                    print("Medusa Head used!")
                end
            end)
        ]]

        newScript.Disabled = false
    end
end

-- Function to ensure the cooldown is applied to the Medusa Head even when the player respawns
local function ensureCooldownOnRespawn()
    local player = Players.LocalPlayer
    player.CharacterAdded:Connect(function(character)
        wait(1) -- Wait for the character to fully load
        local tool = player.Backpack:FindFirstChild("Medusa Head")
        if tool then
            setMedusaHeadCooldown(2)
        end
    end)
end

-- Apply the cooldown of 2 seconds to the Medusa Head and ensure it persists on respawn
setMedusaHeadCooldown(2)
ensureCooldownOnRespawn()
