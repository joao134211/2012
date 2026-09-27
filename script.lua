--// ============================================================
--//  VT UNIVERSAL
--// ============================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

for _, v in ipairs(playerGui:GetChildren()) do
	if v.Name == "VTUniversal" then v:Destroy() end
end

--// ==================== ESTADOS ====================
local estado = {
	infiniteJump = false, gravity = false, hitbox = false,
	noclip = false, fly = false, speed = false,
	peidin = false, float = false, teleporte = false,
}
local infiniteJumpConn, noclipConn, flyConn
local flyVel, flyGyro
local floatPart, floatConn

--// ==================== CORES ====================
local BG       = Color3.fromRGB(15, 15, 22)
local HEADER   = Color3.fromRGB(25, 25, 38)
local CARD     = Color3.fromRGB(38, 38, 52)
local HOVER    = Color3.fromRGB(55, 55, 75)
local INATIVO  = Color3.fromRGB(45, 45, 62)
local ATIVO    = Color3.fromRGB(0, 200, 120)
local NEON     = Color3.fromRGB(140, 90, 255)
local TXT      = Color3.fromRGB(240, 240, 255)
local TXT2     = Color3.fromRGB(150, 150, 175)

--// ==================== SCREEN GUI ====================
local gui = Instance.new("ScreenGui")
gui.Name = "VTUniversal"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--// ==================== TOGGLE (FIXO, quadrado) ====================
local toggle = Instance.new("TextButton")
toggle.Name = "VTButton"
toggle.Size = UDim2.new(0, 50, 0, 50)
toggle.Position = UDim2.new(0, 18, 0.25, -25)
toggle.BackgroundColor3 = HEADER
toggle.TextColor3 = TXT
toggle.Text = "VT"
toggle.Font = Enum.Font.GothamBlack
toggle.TextSize = 18
toggle.AutoButtonColor = false
toggle.Active = false
toggle.Parent = gui
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 4)
local ts = Instance.new("UIStroke", toggle)
ts.Color = NEON
ts.Thickness = 2

--// ==================== FRAME PRINCIPAL ====================
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 270, 0, 380)
frame.Position = UDim2.new(0.5, -135, 0.5, -190)
frame.BackgroundColor3 = BG
frame.BorderSizePixel = 0
frame.Active = true
frame.ClipsDescendants = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
local fs = Instance.new("UIStroke", frame)
fs.Color = NEON
fs.Thickness = 1.5

-- Drag
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)
frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local d = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
	end
end)

--// ==================== HEADER ====================
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = HEADER
header.BorderSizePixel = 0
header.Parent = frame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 4)

local headerCover = Instance.new("Frame")
headerCover.Size = UDim2.new(1, 0, 0, 10)
headerCover.Position = UDim2.new(0, 0, 1, -10)
headerCover.BackgroundColor3 = HEADER
headerCover.BorderSizePixel = 0
headerCover.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ VT Universal"
title.TextColor3 = TXT
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

--// ==================== ABAS ====================
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -16, 0, 30)
tabBar.Position = UDim2.new(0, 8, 0, 46)
tabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
tabBar.BorderSizePixel = 0
tabBar.Parent = frame
Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 3)

local mainTab = Instance.new("TextButton")
mainTab.Size = UDim2.new(0.5, -2, 1, -4)
mainTab.Position = UDim2.new(0, 2, 0, 2)
mainTab.BackgroundColor3 = NEON
mainTab.TextColor3 = TXT
mainTab.Text = "MAIN"
mainTab.Font = Enum.Font.GothamBold
mainTab.TextSize = 12
mainTab.BorderSizePixel = 0
mainTab.AutoButtonColor = false
mainTab.Parent = tabBar
Instance.new("UICorner", mainTab).CornerRadius = UDim.new(0, 3)

local extraTab = Instance.new("TextButton")
extraTab.Size = UDim2.new(0.5, -2, 1, -4)
extraTab.Position = UDim2.new(0.5, 0, 0, 2)
extraTab.BackgroundColor3 = Color3.fromRGB(50, 50, 68)
extraTab.TextColor3 = TXT2
extraTab.Text = "EXTRA"
extraTab.Font = Enum.Font.GothamBold
extraTab.TextSize = 12
extraTab.BorderSizePixel = 0
extraTab.AutoButtonColor = false
extraTab.Parent = tabBar
Instance.new("UICorner", extraTab).CornerRadius = UDim.new(0, 3)

--// ==================== PÁGINAS ====================
local function criarPagina()
	local page = Instance.new("ScrollingFrame")
	page.Size = UDim2.new(1, -16, 1, -84)
	page.Position = UDim2.new(0, 8, 0, 80)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 4
	page.ScrollBarImageColor3 = NEON
	page.CanvasSize = UDim2.new(0, 0, 0, 400)
	page.ScrollingDirection = Enum.ScrollingDirection.Y
	page.Parent = frame
	return page
end

local mainPage = criarPagina()
local extraPage = criarPagina()
extraPage.Visible = false

--// ==================== HELPERS DE UI ====================
local function newButton(parent, y, texto)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -4, 0, 30)
	b.Position = UDim2.new(0, 2, 0, y)
	b.BackgroundColor3 = INATIVO
	b.TextColor3 = TXT
	b.Text = texto
	b.Font = Enum.Font.GothamSemibold
	b.TextSize = 13
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
	local s = Instance.new("UIStroke", b)
	s.Color = NEON
	s.Thickness = 1
	s.Transparency = 0.7
	b.MouseEnter:Connect(function()
		if b.BackgroundColor3 ~= ATIVO then b.BackgroundColor3 = HOVER end
	end)
	b.MouseLeave:Connect(function()
		if b.BackgroundColor3 ~= ATIVO then b.BackgroundColor3 = INATIVO end
	end)
	return b, s
end

local function newBox(parent, y, placeholder, textoInicial)
	local b = Instance.new("TextBox")
	b.Size = UDim2.new(1, -4, 0, 26)
	b.Position = UDim2.new(0, 2, 0, y)
	b.BackgroundColor3 = CARD
	b.TextColor3 = TXT
	b.PlaceholderText = placeholder
	b.PlaceholderColor3 = TXT2
	b.Text = textoInicial or ""
	b.Font = Enum.Font.Gotham
	b.TextSize = 12
	b.BorderSizePixel = 0
	b.ClearTextOnFocus = false
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
	local s = Instance.new("UIStroke", b)
	s.Color = Color3.fromRGB(80, 190, 255)
	s.Thickness = 1
	s.Transparency = 0.6
	return b, s
end

local function setAtivo(btn, stroke, ativo)
	if ativo then
		btn.BackgroundColor3 = ATIVO
		stroke.Color = Color3.fromRGB(0, 255, 160)
		stroke.Transparency = 0.2
	else
		btn.BackgroundColor3 = INATIVO
		stroke.Color = NEON
		stroke.Transparency = 0.7
	end
end

--// ==================== MAIN PAGE ====================
local y = 0
local GAP = 5

local jumpBtn, jumpStroke = newButton(mainPage, y, "🦘  Infinite Jump"); y = y + 30 + GAP
local gravBtn, gravStroke = newButton(mainPage, y, "🌌  Gravity"); y = y + 30 + GAP
local gravBox = newBox(mainPage, y, "Ex: 20"); y = y + 26 + GAP
local hitboxBtn, hitboxStroke = newButton(mainPage, y, "📦  Hitbox"); y = y + 30 + GAP
local hitboxBox = newBox(mainPage, y, "Ex: 20"); y = y + 26 + GAP
local noclipBtn, noclipStroke = newButton(mainPage, y, "👻  Noclip"); y = y + 30 + GAP
local flyBtn, flyStroke = newButton(mainPage, y, "🕊  Fly"); y = y + 30 + GAP
local flyBox = newBox(mainPage, y, "Velocidade Fly (Ex: 100)"); y = y + 26 + GAP
local speedBtn, speedStroke = newButton(mainPage, y, "💨  Speed"); y = y + 30 + GAP
local speedBox = newBox(mainPage, y, "Velocidade Speed (Ex: 100)", "100"); y = y + 26 + 10

mainPage.CanvasSize = UDim2.new(0, 0, 0, y)

--// ==================== EXTRA PAGE ====================
local ye = 0

local peidinBtn, peidinStroke = newButton(extraPage, ye, "🥷  Peidin"); ye = ye + 30 + GAP
local floatBtn, floatStroke = newButton(extraPage, ye, "🎈  Float"); ye = ye + 30 + GAP
local tpBtn, tpStroke = newButton(extraPage, ye, "🌐  Teleporte"); ye = ye + 30 + GAP
local tpBox = newBox(extraPage, ye, "Nome do jogador"); ye = ye + 26 + 10

extraPage.CanvasSize = UDim2.new(0, 0, 0, ye)

--// ==================== TROCAR ABAS ====================
mainTab.MouseButton1Click:Connect(function()
	mainPage.Visible = true
	extraPage.Visible = false
	mainTab.BackgroundColor3 = NEON
	mainTab.TextColor3 = TXT
	extraTab.BackgroundColor3 = Color3.fromRGB(50, 50, 68)
	extraTab.TextColor3 = TXT2
end)

extraTab.MouseButton1Click:Connect(function()
	mainPage.Visible = false
	extraPage.Visible = true
	extraTab.BackgroundColor3 = NEON
	extraTab.TextColor3 = TXT
	mainTab.BackgroundColor3 = Color3.fromRGB(50, 50, 68)
	mainTab.TextColor3 = TXT2
end)

--// ==================== TOGGLE VT ====================
toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

--// ==================== HELPERS GERAIS ====================
local function getChar() return player.Character end
local function getHRP()
	local c = getChar()
	return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHum()
	local c = getChar()
	return c and c:FindFirstChildOfClass("Humanoid")
end

--// ==================== INFINITE JUMP ====================
jumpBtn.MouseButton1Click:Connect(function()
	estado.infiniteJump = not estado.infiniteJump
	setAtivo(jumpBtn, jumpStroke, estado.infiniteJump)
	if estado.infiniteJump then
		infiniteJumpConn = UserInputService.JumpRequest:Connect(function()
			local h = getHum()
			if h and estado.infiniteJump then
				h:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	else
		if infiniteJumpConn then infiniteJumpConn:Disconnect() infiniteJumpConn = nil end
	end
end)

--// ==================== GRAVITY ====================
gravBtn.MouseButton1Click:Connect(function()
	if not estado.gravity then
		local v = tonumber(gravBox.Text)
		if not v then gravBox.Text = "Inválido" return end
		Workspace.Gravity = v
		estado.gravity = true
		setAtivo(gravBtn, gravStroke, true)
	else
		Workspace.Gravity = 196.2
		estado.gravity = false
		setAtivo(gravBtn, gravStroke, false)
	end
end)

--// ==================== HITBOX ====================
hitboxBtn.MouseButton1Click:Connect(function()
	estado.hitbox = not estado.hitbox
	setAtivo(hitboxBtn, hitboxStroke, estado.hitbox)
	if estado.hitbox then
		local v = tonumber(hitboxBox.Text)
		if not v then hitboxBox.Text = "Inválido" estado.hitbox = false setAtivo(hitboxBtn, hitboxStroke, false) return end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local r = p.Character:FindFirstChild("HumanoidRootPart")
				if r then r.Size = Vector3.new(v, v, v) end
			end
		end
	else
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local r = p.Character:FindFirstChild("HumanoidRootPart")
				if r then r.Size = Vector3.new(2, 2, 1) end
			end
		end
	end
end)

--// ==================== NOCLIP ====================
noclipBtn.MouseButton1Click:Connect(function()
	estado.noclip = not estado.noclip
	setAtivo(noclipBtn, noclipStroke, estado.noclip)
	if estado.noclip then
		noclipConn = RunService.Stepped:Connect(function()
			local c = getChar()
			if c then
				for _, p in ipairs(c:GetDescendants()) do
					if p:IsA("BasePart") then p.CanCollide = false end
				end
			end
		end)
	else
		if noclipConn then noclipConn:Disconnect() noclipConn = nil end
	end
end)

--// ==================== FLY ====================
local function stopFly()
	if flyConn then flyConn:Disconnect() flyConn = nil end
	if flyVel then flyVel:Destroy() flyVel = nil end
	if flyGyro then flyGyro:Destroy() flyGyro = nil end
	local h = getHum()
	if h then h.PlatformStand = false end
end

flyBtn.MouseButton1Click:Connect(function()
	estado.fly = not estado.fly
	setAtivo(flyBtn, flyStroke, estado.fly)
	if estado.fly then
		local c = getChar()
		if not c then return end
		local root = c:WaitForChild("HumanoidRootPart", 3)
		if not root then return end

		flyVel = Instance.new("BodyVelocity")
		flyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		flyVel.Velocity = Vector3.zero
		flyVel.Parent = root

		flyGyro = Instance.new("BodyGyro")
		flyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
		flyGyro.P = 1000
		flyGyro.D = 50
		flyGyro.Parent = root

		flyConn = RunService.RenderStepped:Connect(function()
			local cc = getChar()
			if not cc then return end
			local r = cc:FindFirstChild("HumanoidRootPart")
			local h = cc:FindFirstChildOfClass("Humanoid")
			if not r or not h then return end
			h.PlatformStand = true

			local cam = Workspace.CurrentCamera
			local dir = Vector3.zero
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end

			local spd = tonumber(flyBox.Text) or 100
			if dir.Magnitude > 0 then
				flyVel.Velocity = dir.Unit * spd
			else
				flyVel.Velocity = Vector3.zero
			end
			flyGyro.CFrame = cam.CFrame
		end)
	else
		stopFly()
	end
end)

--// ==================== SPEED ====================
speedBtn.MouseButton1Click:Connect(function()
	estado.speed = not estado.speed
	setAtivo(speedBtn, speedStroke, estado.speed)
	local h = getHum()
	if not h then return end
	if estado.speed then
		local v = tonumber(speedBox.Text)
		if not v then speedBox.Text = "Inválido" estado.speed = false setAtivo(speedBtn, speedStroke, false) return end
		h.WalkSpeed = v
	else
		h.WalkSpeed = 16
	end
end)

--// ==================== PEIDIN ====================
local function criarPeidin()
	local tool = Instance.new("Tool")
	tool.Name = "Peidin"
	tool.RequiresHandle = false
	tool.CanBeDropped = false
	tool.Activated:Connect(function()
		local mouse = player:GetMouse()
		local r = getHRP()
		if mouse.Hit and r then
			r.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
		end
	end)
	tool.Parent = player:WaitForChild("Backpack")
end

peidinBtn.MouseButton1Click:Connect(function()
	estado.peidin = not estado.peidin
	setAtivo(peidinBtn, peidinStroke, estado.peidin)
	local bp = player:FindFirstChild("Backpack")
	local c = getChar()
	if estado.peidin then
		if bp and not bp:FindFirstChild("Peidin") then criarPeidin() end
	else
		if bp and bp:FindFirstChild("Peidin") then bp.Peidin:Destroy() end
		if c and c:FindFirstChild("Peidin") then c.Peidin:Destroy() end
	end
end)

--// ==================== FLOAT ====================
floatBtn.MouseButton1Click:Connect(function()
	estado.float = not estado.float
	setAtivo(floatBtn, floatStroke, estado.float)
	if estado.float then
		floatPart = Instance.new("Part")
		floatPart.Size = Vector3.new(6, 1, 6)
		floatPart.Transparency = 1
		floatPart.Anchored = true
		floatPart.CanCollide = true
		floatPart.CanQuery = false
		floatPart.CanTouch = false
		floatPart.Name = "FloatPlatform"
		floatPart.Parent = Workspace
		floatConn = RunService.Heartbeat:Connect(function()
			local r = getHRP()
			if r and floatPart then
				floatPart.CFrame = CFrame.new(r.Position - Vector3.new(0, 3.5, 0))
			end
		end)
	else
		if floatConn then floatConn:Disconnect() floatConn = nil end
		if floatPart then floatPart:Destroy() floatPart = nil end
	end
end)

--// ==================== TELEPORTE ====================
tpBtn.MouseButton1Click:Connect(function()
	local nome = tpBox.Text
	if nome == "" then tpBox.Text = "Digite um nome" return end
	local alvo
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower() == nome:lower() or p.DisplayName:lower() == nome:lower() then
			alvo = p break
		end
	end
	if not alvo then tpBox.Text = "Não encontrado" return end
	local ra = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
	local rm = getHRP()
	if ra and rm then
		rm.CFrame = ra.CFrame * CFrame.new(0, 0, 3)
		tpBox.Text = "Teleportado!"
	end
end)

--// ==================== RESPAWN ====================
player.CharacterAdded:Connect(function()
	task.wait(1)
	local bp = player:FindFirstChild("Backpack")
	if estado.peidin and bp and not bp:FindFirstChild("Peidin") then criarPeidin() end
	if estado.speed then
		local h = getHum()
		local v = tonumber(speedBox.Text)
		if h and v then h.WalkSpeed = v end
	end
end)

print("[VT Universal] Carregado com sucesso!")
