-- Create Loading GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScriptGUI"
pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)
if not gui.Parent then
	gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 405, 0, 160) -- Expanded size
frame.Position = UDim2.new(0.5, -202, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "Loading script!"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Subtitle
local subtitle = Instance.new("TextLabel", frame)
subtitle.Text = "Bypassing anti-cheat, please wait..."
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 55)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(0, 255, 170)
subtitle.Font = Enum.Font.Gotham
subtitle.TextScaled = true

-- Progress bar container
local progressBarBG = Instance.new("Frame", frame)
progressBarBG.Size = UDim2.new(0.8, 0, 0.15, 0)
progressBarBG.Position = UDim2.new(0.1, 0, 0.7, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)

-- Progress bar
local progressBar = Instance.new("Frame", progressBarBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 6)

-- Percentage label
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

-- Loading animation
spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
		percentageLabel.Text = i .. "%"
		wait(0.8) -- 100 steps × 0.8s = 80 seconds
	end
	progressBar.Visible = false
	runButton.Visible = true
end)

-- On run, destroy GUI and load Rayfield GUI
runButton.MouseButton1Click:Connect(function()
	gui:Destroy()

	local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

	local Window = Rayfield:CreateWindow({
		Name = "Fruits And Pets Dupe",
		Icon = 0,
		LoadingTitle = "Dupe",
		LoadingSubtitle = "by Flash",
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
	local petName = ""

	-- Dupe Equipped Tool
	Tab:CreateButton({
		Name = "Dupe Equipped Item",
		Callback = function()
			local player = game.Players.LocalPlayer
			local character = player.Character
			if character then
				local tool = character:FindFirstChildOfClass("Tool")
				if tool and not tostring(tool):match("Seed") then
					for i = 1, multiplier do
						local clone = tool:Clone()
						clone.Parent = player.Backpack
					end
				end
			end
		end
	})

	-- Multiplier Slider
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

	-- Dupe Seeds
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

	-- Pet Spawner Section
	Tab:CreateInput({
		Name = "Pet you want to spawn",
		PlaceholderText = "", -- Blank as requested
		RemoveTextAfterFocusLost = false,
		Callback = function(text)
			petName = text
		end
	})

	Tab:CreateButton({
		Name = "Dupe Pet",
		Callback = function()
			local player = game.Players.LocalPlayer
			local backpack = player:WaitForChild("Backpack")
			local function findPet(name)
				for _, item in pairs(backpack:GetChildren()) do
					if item:IsA("Tool") and item.Name == name then
						return item
					end
				end
				return nil
			end

			local pet = findPet(petName)
			if pet then
				for i = 1, multiplier do
					local clone = pet:Clone()
					clone.Parent = backpack
				end
			else
				warn("Pet not found in Backpack: " .. petName)
			end
		end
	})
end)
