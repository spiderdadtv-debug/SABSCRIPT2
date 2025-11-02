-- KRNL IOS Executor Script for Steal a Brainrot

-- Function to modify the trap duration
local function modifyTrapDuration(newDuration)
    -- Access the game's trap function
    local trapFunction = game:GetService("ReplicatedStorage"):WaitForChild("TrapFunction")

    -- Override the original trap function with a custom one
    local originalTrapFunction = trapFunction.Trap

    trapFunction.Trap = function(player)
        -- Call the original trap function
        originalTrapFunction(player)

        -- Modify the duration
        local trapPart = player.Character:FindFirstChild("TrapPart")
        if trapPart then
            trapPart.CFrame = trapPart.CFrame * CFrame.new(0, 0, 0) -- Reset position
            wait(newDuration) -- Wait for the new duration
            trapPart:Destroy() -- Remove the trap
        end
    end
end

-- Function to modify the admin panel jail duration
local function modifyAdminPanelJailDuration(newDuration)
    -- Access the admin panel script
    local adminPanel = game:GetService("ReplicatedStorage"):WaitForChild("AdminPanel")

    -- Override the original jail function with a custom one
    local originalJailFunction = adminPanel.Jail

    adminPanel.Jail = function(player)
        -- Call the original jail function
        originalJailFunction(player)

        -- Modify the duration
        local jailPart = player.Character:FindFirstChild("JailPart")
        if jailPart then
            jailPart.CFrame = jailPart.CFrame * CFrame.new(0, 0, 0) -- Reset position
            wait(newDuration) -- Wait for the new duration
            jailPart:Destroy() -- Remove the jail
        end
    end
end

-- Set the new duration to 40 seconds for both trap and admin panel jail
modifyTrapDuration(40)
modifyAdminPanelJailDuration(40)
