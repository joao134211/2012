-- VT HUB MOBILE FINAL
-- StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

-- ESTADOS
local noclipEnabled = false
local teleportEnabled = false
local infiniteJumpEnabled = false
local speedEnabled = false

local normalSpeed = 16

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "VTHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- BOTÃO CR7
local avatarButton = Instance.new("ImageButton")
avatarButton.Parent = gui
avatarButton.Size = UDim2.new(0,55,0,55)
avatarButton.Position = UDim2.new(0,12,0.45,0)
avatarButton.BackgroundColor3 = Color3.fromRGB(10,10,10)
avatarButton.Image = "rbxassetid://17374768014"

Instance.new("UICorner", avatarButton).CornerRadius = UDim.new(0,14)

-- FRAME
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,320,0,360)
frame.Position = UDim2.new(0.5,-160,0.5,-180)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,18)

-- TITULO
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "VT Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.new(1,1,1)

-- LINHA
local line = Instance.new("Frame")
line.Parent = frame
line.Size = UDim2.new(1,-30,0,2)
line.Position = UDim2.new(0,15,0,52)
line.BackgroundColor3 = Color3.fromRGB(40,40,40)
line.BorderSizePixel = 0

-- FUNÇÃO CRIAR BOTÃO
local function createButton(text,posY)

	local holder = Instance.new("Frame")
	holder.Parent = frame
	holder.Size = UDim2.new(0,280,0,48)
	holder.Position = UDim2.new(0.5,-140,0,posY)
	holder.BackgroundColor3 = Color3.fromRGB(35,15,15)

	Instance.new("UICorner",holder).CornerRadius = UDim.new(0,14)

	local button = Instance.new("TextButton")
	button.Parent = holder
	button.Size = UDim2.new(1,0,1,0)
	button.BackgroundTransparency = 1
	button.Text = text .. ": OFF"
	button.Font = Enum.Font.GothamBold
	button.TextSize = 18
	button.TextColor3 = Color3.new(1,1,1)

	return button
end

-- BOTÕES
local noclipButton = createButton("Noclip",80)
local teleportButton = createButton("Teleport",145)
local infiniteJumpButton = createButton("Infinite Jump",210)
local speedButton = createButton("Speed",275)

-- SPEED BOX
local speedBox = Instance.new("TextBox")
speedBox.Parent = frame
speedBox.Size = UDim2.new(0,280,0,40)
speedBox.Position = UDim2.new(0.5,-140,0,330)
speedBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.PlaceholderText = "Digite a velocidade"
speedBox.Text = "50"
speedBox.Font = Enum.Font.GothamBold
speedBox.TextSize = 18
speedBox.ClearTextOnFocus = false

Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,12)

-- NOCLIP
RunService.Stepped:Connect(function()

	if noclipEnabled and character then

		for _,v in pairs(character:GetDescendants()) do

			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

noclipButton.MouseButton1Click:Connect(function()

	noclipEnabled = not noclipEnabled

	if noclipEnabled then

		noclipButton.Text = "Noclip: ON"

	else

		noclipButton.Text = "Noclip: OFF"

		for _,v in pairs(character:GetDescendants()) do

			if v:IsA("BasePart") then
				v.CanCollide = true
			end
		end
	end
end)

-- TELEPORT
local teleportTool

local function createTeleportTool()

	if teleportTool then return end

	teleportTool = Instance.new("Tool")
	teleportTool.Name = "VT Teleport"
	teleportTool.RequiresHandle = false
	teleportTool.CanBeDropped = false
	teleportTool.Parent = player.Backpack

	teleportTool.Activated:Connect(function()

		if hrp then

			hrp.CFrame = CFrame.new(
				mouse.Hit.Position + Vector3.new(0,3,0)
			)
		end
	end)
end

local function removeTeleportTool()

	if teleportTool then
		teleportTool:Destroy()
		teleportTool = nil
	end
end

teleportButton.MouseButton1Click:Connect(function()

	teleportEnabled = not teleportEnabled

	if teleportEnabled then

		createTeleportTool()
		teleportButton.Text = "Teleport: ON"

	else

		removeTeleportTool()
		teleportButton.Text = "Teleport: OFF"
	end
end)

-- INFINITE JUMP
UIS.JumpRequest:Connect(function()

	if infiniteJumpEnabled and humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

infiniteJumpButton.MouseButton1Click:Connect(function()

	infiniteJumpEnabled = not infiniteJumpEnabled

	if infiniteJumpEnabled then
		infiniteJumpButton.Text = "Infinite Jump: ON"
	else
		infiniteJumpButton.Text = "Infinite Jump: OFF"
	end
end)

-- SPEED
speedButton.MouseButton1Click:Connect(function()

	speedEnabled = not speedEnabled

	if speedEnabled then

		local speedValue = tonumber(speedBox.Text)

		if speedValue then
			humanoid.WalkSpeed = speedValue
		else
			humanoid.WalkSpeed = 50
		end

		speedButton.Text = "Speed: ON"

	else

		humanoid.WalkSpeed = normalSpeed
		speedButton.Text = "Speed: OFF"
	end
end)

-- TOGGLE GUI
local visible = true

avatarButton.MouseButton1Click:Connect(function()

	visible = not visible
	frame.Visible = visible
end)

-- RESPAWN
player.CharacterAdded:Connect(function(char)

	character = char
	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")

	if speedEnabled then

		local speedValue = tonumber(speedBox.Text)

		if speedValue then
			humanoid.WalkSpeed = speedValue
		end
	end
end)
