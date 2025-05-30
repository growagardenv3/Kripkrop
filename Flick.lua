-- Create Loading GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScriptGUI"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 460, 0, 170)
frame.Position = UDim2.new(0.5, -230, 0.5, -85)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
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

-- Subtitle (slightly dimmer to act as a description)
local subtitle = Instance.new("TextLabel", frame)
subtitle.Text = "Bypassing anti-cheat, please wait..."
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 50)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(0, 200, 140)
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

-- Animate Loading (70 seconds)
task.spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
		percentageLabel.Text = tostring(i) .. "%"
		task.wait(0.7) -- 100 steps * 0.7 = 70 seconds
	end
	progressBar.Visible = false
	runButton.Visible = true
end)

-- Run Rayfield GUI
runButton.MouseButton1Click:Connect(function()
	gui:Destroy()

	local success, Rayfield = pcall(function()
		return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
	end)

	if not success or not Rayfield then
		warn("Failed to load Rayfield.")
		return
	end

	local Window = Rayfield:CreateWindow({
		Name = "Fruits And Pets Dupe",
		LoadingTitle = "Dupe",
		LoadingSubtitle = "by Zeneveroux",
		Theme = "Default",
		ConfigurationSaving = { Enabled = false },
		KeySystem = false,
	})

	local MainTab = Window:CreateTab("Main", 4483362458)
	local PetTab = Window:CreateTab("Pet Spawner", 4483362458)

	local multiplier = 2

	MainTab:CreateButton({
		Name = "Dupe Equipped Item",
		Callback = function()
			local player = game.Players.LocalPlayer
			local char = player.Character
			if char then
				local tool = char:FindFirstChildOfClass("Tool")
				if tool and not tool.Name:match("Seed") then
					for i = 1, multiplier do
						local clone = tool:Clone()
						clone.Parent = player.Backpack
					end
				end
			end
		end
	})

	MainTab:CreateSlider({
		Name = "Multiplier",
		Range = {2, 100},
		Increment = 1,
		CurrentValue = multiplier,
		Flag = "MainMult",
		Callback = function(val)
			multiplier = val
		end
	})

	MainTab:CreateButton({
		Name = "Dupe Seeds",
		Callback = function()
			local player = game.Players.LocalPlayer
			for _, item in pairs(player.Backpack:GetChildren()) do
				if item.Name:match("[X%d+]") and item.Name:match("Seed") then
					local count = tonumber(item.Name:match("(%d+)"))
					if count then
						item.Name = item.Name:gsub("(%d+)", tostring(count * multiplier))
					end
				end
			end
		end
	})

	PetTab:CreateInput({
		Name = "Pet",
		PlaceholderText = "e.g. raccoon",
		RemoveTextAfterFocusLost = false,
		Callback = function(text)
			-- Pet logic placeholder
		end
	})

	PetTab:CreateInput({
		Name = "Pet Weight",
		PlaceholderText = "e.g. 3.44kg",
		RemoveTextAfterFocusLost = false,
		Callback = function(text)
			-- Weight logic placeholder
		end
	})

	PetTab:CreateInput({
		Name = "Pet Age",
		PlaceholderText = "e.g. 17",
		RemoveTextAfterFocusLost = false,
		Callback = function(text)
			-- Age logic placeholder
		end
	})

	PetTab:CreateSlider({
		Name = "Multiplier",
		Range = {2, 100},
		Increment = 1,
		CurrentValue = multiplier,
		Flag = "PetMult",
		Callback = function(val)
			multiplier = val
		end
	})

	PetTab:CreateButton({
		Name = "Dupe Pet",
		Callback = function()
			-- Pet dupe logic placeholder
		end
	})
end)
