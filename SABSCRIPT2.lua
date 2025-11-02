-- KRNL IOS Executor Script for Steal a Brainrot

-- Function to modify the admin panel jail duration
local function modifyAdminPanelJailDuration(newDuration)
    -- Access the admin panel script
    local adminPanelScript = game:GetService("ReplicatedStorage"):WaitForChild("AdminPanel"):WaitForChild("JailScript")

    -- Override the original jail function with a custom one
    local originalJailFunction = adminPanelScript.Jail

    adminPanelScript.Jail = function(player)
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

-- Set the new duration to 40 seconds for the admin panel jail
modifyAdminPanelJailDuration(40)
