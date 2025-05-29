-- Create Loading GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScriptGUI"
gui.ResetOnSpawn = false
pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)
if not gui.Parent then
	gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 430, 0, 180)
frame.Position = UDim2.new(0.5, -210, 0.5, -85)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BackgroundTransparency = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "Loading script!"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Subtitle
local subtitle = Instance.new("TextLabel", frame)
subtitle.Text = "Bypassing anti-cheat, please wait..."
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 50)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(0, 255, 170)
subtitle.Font = Enum.Font.Gotham
subtitle.TextScaled = true

-- Progress Bar Background
local progressBarBG = Instance.new("Frame", frame)
progressBarBG.Size = UDim2.new(0.8, 0, 0.15, 0)
progressBarBG.Position = UDim2.new(0.1, 0, 0.7, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)

-- Progress Bar Fill
local progressBar = Instance.new("Frame", progressBarBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 6)

-- Percentage Label
local percentageLabel = Instance.new("TextLabel", frame)
percentageLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
percentageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
percentageLabel.Size = UDim2.new(0, 100, 0, 30)
percentageLabel.BackgroundTransparency = 1
percentageLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
percentageLabel.Font = Enum.Font.GothamBold
percentageLabel.TextScaled = true
percentageLabel.Text = "0%"

-- Run Button
local runButton = Instance.new("TextButton", progressBarBG)
runButton.Size = UDim2.new(1, 0, 1, 0)
runButton.Position = UDim2.new(0, 0, 0, 0)
runButton.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
runButton.TextColor3 = Color3.fromRGB(0, 0, 0)
runButton.Font = Enum.Font.GothamBold
runButton.TextScaled = true
runButton.Text = "RUN SCRIPT"
runButton.Visible = false
Instance.new("UICorner", runButton).CornerRadius = UDim.new(0, 6)

-- Animate Loading
spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
		percentageLabel.Text = i .. "%"
		wait(0.05)
	end
	progressBar.Visible = false
	runButton.Visible = true
end)

-- Button Click Logic
runButton.MouseButton1Click:Connect(function()
	gui:Destroy()

	local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
	local Window = Rayfield:CreateWindow({
		Name = "Fruits And Pets Dupe",
		Icon = 0,
		LoadingTitle = "Dupe",
		LoadingSubtitle = "by Zeneveroux",
		Theme = "Default",
		DisableRayfieldPrompts = false,
		DisableBuildWarnings = false,
		ConfigurationSaving = { Enabled = false },
		Discord = { Enabled = false, Invite = "noinvitelink", RememberJoins = true },
		KeySystem = false,
		KeySettings = {
			Title = "Untitled",
			Subtitle = "Key System",
			Note = "No method of obtaining the key is provided",
			FileName = "Key",
			SaveKey = true,
			GrabKeyFromSite = false,
			Key = { "" }
		}
	})

	local Tab = Window:CreateTab("Main", 4483362458)
	local multiplier = 2

	local function dupeEquippedTool()
		local player = game.Players.LocalPlayer
		local character = player.Character
		if character then
			local equippedTool = character:FindFirstChildOfClass("Tool")
			if equippedTool and not tostring(equippedTool):match("Seed") then
				for i = 1, multiplier do
					local clone = equippedTool:Clone()
					clone.Parent = player.Backpack
				end
			end
		end
	end

	Tab:CreateButton({
		Name = "Dupe Equipped Item",
		Callback = dupeEquippedTool
	})

	Tab:CreateSlider({
		Name = "Multiplier",
		Range = {2, 100},
		Increment = 1,
		Suffix = "",
		CurrentValue = multiplier,
		Flag = "a",
		Callback = function(value)
			multiplier = value
		end
	})

	Tab:CreateButton({
		Name = "Dupe Seeds",
		Callback = function()
			local player = game.Players.LocalPlayer
			for _, item in pairs(player.Backpack:GetChildren()) do
				if tostring(item):match("[X%d+]") and tostring(item):match("Seed") then
					local count = tonumber(item.Name:match("(%d+)"))
					if count then
						item.Name = item.Name:gsub("(%d+)", tostring(count * multiplier))
					end
				end
			end
		end
	})

	local PetTab = Window:CreateTab("Pet Spawner", 4483362458)

	PetTab:CreateInput({
		Name = "",
		PlaceholderText = "",
		RemoveTextAfterFocusLost = false,
		Callback = function(input)
			-- handle pet name
		end
	})

	PetTab:CreateSlider({
		Name = "Multiplier",
		Range = {2, 100},
		Increment = 1,
		CurrentValue = multiplier,
		Flag = "petMultiplier",
		Callback = function(value)
			multiplier = value
		end
	})

	PetTab:CreateButton({
		Name = "Dupe Pet",
		Callback = function()
			local player = game.Players.LocalPlayer
			local backpack = player:FindFirstChild("Backpack")
			if backpack then
				for _, item in pairs(backpack:GetChildren()) do
					if item:IsA("Tool") and not item.Name:match("Seed") then
						for i = 1, multiplier do
							local clone = item:Clone()
							clone.Parent = backpack
						end
					end
				end
			end
		end
	})
end)
