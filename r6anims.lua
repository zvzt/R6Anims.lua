-- By Zot
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(c)
	char = c
	hum = c:WaitForChild("Humanoid")
end)

if player.PlayerGui:FindFirstChild("R6") then
	player.PlayerGui.R6:Destroy()
end

local BG = Color3.fromRGB(0,0,0)
local PANEL = Color3.fromRGB(0,0,0)
local STROKE = Color3.fromRGB(255,255,255)
local BTN = Color3.fromRGB(0,0,0)
local BTN_HOVER = Color3.fromRGB(40,40,40)
local ACTIVE = Color3.fromRGB(80,80,80)
local currentTrack = nil
local currentButton = nil
local gui = Instance.new("ScreenGui")
gui.Name = "R6"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,380)
main.Position = UDim2.new(0.5,-260,0.5,-190)
main.BackgroundColor3 = BG
main.BackgroundTransparency = 0
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = STROKE
mainStroke.Thickness = 1.5
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local function dragify(frame)
	local drag, start, pos

	frame.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = true
			start = i.Position
			pos = frame.Position
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = i.Position - start
			frame.Position = UDim2.new(
				pos.X.Scale,
				pos.X.Offset + delta.X,
				pos.Y.Scale,
				pos.Y.Offset + delta.Y
			)
		end
	end)

	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = false
		end
	end)
end

dragify(main)

local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,44)
top.BackgroundColor3 = PANEL
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,12)
local killBtn = Instance.new("TextButton", top)
killBtn.Size = UDim2.new(0,58,1,0)
killBtn.Position = UDim2.new(0,6,0,0)
killBtn.Text = "KILL"
killBtn.BackgroundTransparency = 1
killBtn.Font = Enum.Font.GothamBold
killBtn.TextSize = 13
killBtn.TextColor3 = Color3.fromRGB(255,255,255)
killBtn.TextStrokeTransparency = 1
killBtn.AutoButtonColor = false
killBtn.MouseEnter:Connect(function()
	TweenService:Create(
		killBtn,
		TweenInfo.new(0.12),
		{TextColor3 = Color3.fromRGB(160,160,160)}
	):Play()
end)

killBtn.MouseLeave:Connect(function()
	TweenService:Create(
		killBtn,
		TweenInfo.new(0.12),
		{TextColor3 = Color3.fromRGB(255,255,255)}
	):Play()
end)

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-128,1,0)
title.Position = UDim2.new(0,64,0,0)
title.Text = "R6 Animations"
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1,1,1)
title.TextStrokeTransparency = 1
title.RichText = false
local miniBtn = Instance.new("TextButton", top)
miniBtn.Size = UDim2.new(0,40,1,0)
miniBtn.Position = UDim2.new(1,-40,0,0)
miniBtn.Text = "-"
miniBtn.BackgroundTransparency = 1
miniBtn.Font = Enum.Font.Code
miniBtn.TextSize = 22
miniBtn.TextColor3 = Color3.fromRGB(255,255,255)
miniBtn.TextStrokeTransparency = 1
miniBtn.AutoButtonColor = false
local mini = Instance.new("Frame", gui)
mini.Size = UDim2.new(0,50,0,50)
mini.BackgroundColor3 = BG
mini.Visible = false
mini.Active = true
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)
local miniStroke = Instance.new("UIStroke", mini)
miniStroke.Color = STROKE
miniStroke.Thickness = 1.5
miniStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local z = Instance.new("TextButton", mini)
z.Size = UDim2.new(1,0,1,0)
z.Text = "Z"
z.BackgroundTransparency = 1
z.Font = Enum.Font.Code
z.TextSize = 20
z.TextColor3 = Color3.fromRGB(255,255,255)
z.TextStrokeTransparency = 1
z.AutoButtonColor = false
z.Active = false

dragify(mini)
miniBtn.MouseButton1Click:Connect(function()
	mini.Position = main.Position
	main.Visible = false
	mini.Visible = true
end)

z.MouseButton1Click:Connect(function()
	main.Position = mini.Position
	main.Visible = true
	mini.Visible = false
end)

local scroll = Instance.new("ScrollingFrame", main)
scroll.Position = UDim2.new(0,10,0,52)
scroll.Size = UDim2.new(1,-20,1,-72)
scroll.BackgroundTransparency = 1
scroll.AutomaticCanvasSize = Enum.AutomaticSize.None
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)
scroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
scroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

local grid = Instance.new("UIGridLayout", scroll)
grid.CellSize = UDim2.new(0,150,0,42)
grid.CellPadding = UDim2.new(0,8,0,8)
grid.StartCorner = Enum.StartCorner.TopLeft

local UIPadding = Instance.new("UIPadding", scroll)
UIPadding.PaddingTop = UDim.new(0,6)
UIPadding.PaddingBottom = UDim.new(0,6)
UIPadding.PaddingLeft = UDim.new(0,4)
UIPadding.PaddingRight = UDim.new(0,4)

local footer = Instance.new("TextLabel", main)
footer.Size = UDim2.new(1,0,0,20)
footer.Position = UDim2.new(0,0,1,-20)
footer.BackgroundTransparency = 1
footer.Text = "by Zxt :>"
footer.Font = Enum.Font.Code
footer.TextSize = 12
footer.TextColor3 = Color3.fromRGB(255,255,255)
footer.TextStrokeTransparency = 1

local buttons = {}
local function createButton(name)
	local b = Instance.new("TextButton")
	b.Parent = scroll
	b.Size = UDim2.new(0,150,0,42)
	b.Text = name
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextXAlignment = Enum.TextXAlignment.Center
	b.TextYAlignment = Enum.TextYAlignment.Center
	b.BackgroundColor3 = BTN
	b.TextColor3 = Color3.new(1,1,1)
	b.TextStrokeTransparency = 1
	b.AutoButtonColor = false
	b.RichText = false

	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

	local s = Instance.new("UIStroke", b)
	s.Color = STROKE
	s.Thickness = 1.5
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	b.MouseEnter:Connect(function()
		if b.BackgroundColor3 ~= ACTIVE then
			TweenService:Create(
				b,
				TweenInfo.new(0.15),
				{BackgroundColor3 = BTN_HOVER}
			):Play()
		end
	end)

	b.MouseLeave:Connect(function()
		if b.BackgroundColor3 ~= ACTIVE then
			TweenService:Create(
				b,
				TweenInfo.new(0.15),
				{BackgroundColor3 = BTN}
			):Play()
		end
	end)

	buttons[name] = b
	return b
end

local names = {
	"Salute",
	"HeadThrow","FloatingHead","Crouch","FloorCrawl","DinoWalk",
	"JumpingJacks","HeroJump","Faint","FloorFaint",
	"Levitate","Dab","Spinner","FloatSit",
	"MovingDance","WeirdMove","GlitchLevitate",
	"SpinDance","MoonDance","FullPunch","SpinDance2","BowDown",
	"SwordSlam","MegaInsane","SuperPunch","FullSwing",
	"ArmTurbine","BarrelRoll","Scared","Insane","ArmDetach",
	"SwordSlice","InsaneArms"
}

for _, n in pairs(names) do
	createButton(n)
end

local function updateCanvasSize()
	local count = #names
	local cols = 3
	local rows = math.ceil(count / cols)
	local cellH = 42
	local padH = 8
	local topPad = 6
	local botPad = 6
	local totalH = topPad + rows * cellH + (rows - 1) * padH + botPad

	scroll.CanvasSize = UDim2.new(0,0,0,totalH)
end

updateCanvasSize()

local function bind(btn, id, loop)
	local anim = Instance.new("Animation")
	anim.AnimationId = id

	btn.MouseButton1Click:Connect(function()
		if currentButton == btn then
			if currentTrack then
				currentTrack:Stop(0)
				currentTrack.TimePosition = 0
			end

			currentTrack = nil
			currentButton = nil
			btn.BackgroundColor3 = BTN
			return
		end

		if currentTrack then
			currentTrack:Stop(0)
		end

		if currentButton then
			currentButton.BackgroundColor3 = BTN
		end

		local track = hum:LoadAnimation(anim)

		currentTrack = track
		currentButton = btn
		btn.BackgroundColor3 = ACTIVE

		if loop then
			task.spawn(function()
				while currentButton == btn and currentTrack == track do
					if not track.IsPlaying then
						track:Play(0.1,1,1)
					end
					task.wait()
				end
			end)
		else
			track:Play(0.1,1,1)
		end
	end)
end

killBtn.MouseButton1Click:Connect(function()
	if currentTrack then
		currentTrack:Stop(0)
		currentTrack:Destroy()
		currentTrack = nil
	end

	currentButton = nil

	if mini then
		mini:Destroy()
	end

	gui:Destroy()
end)

bind(buttons.Salute,"rbxassetid://186904307",true)
bind(buttons.HeadThrow,"rbxassetid://35154961",true)
bind(buttons.FloatingHead,"rbxassetid://121572214",false)
bind(buttons.Crouch,"rbxassetid://182724289",false)
bind(buttons.FloorCrawl,"rbxassetid://282574440",false)
bind(buttons.DinoWalk,"rbxassetid://204328711",false)
bind(buttons.JumpingJacks,"rbxassetid://429681631",false)
bind(buttons.HeroJump,"rbxassetid://184574340",true)
bind(buttons.Faint,"rbxassetid://181526230",false)
bind(buttons.FloorFaint,"rbxassetid://181525546",true)
bind(buttons.Levitate,"rbxassetid://313762630",false)
bind(buttons.Dab,"rbxassetid://183412246",true)
bind(buttons.Spinner,"rbxassetid://188632011",true)
bind(buttons.FloatSit,"rbxassetid://179224234",false)
bind(buttons.MovingDance,"rbxassetid://429703734",true)
bind(buttons.WeirdMove,"rbxassetid://215384594",false)
bind(buttons.GlitchLevitate,"rbxassetid://313762630",false)
bind(buttons.SpinDance,"rbxassetid://429730430",true)
bind(buttons.MoonDance,"rbxassetid://45834924",true)
bind(buttons.FullPunch,"rbxassetid://204062532",true)
bind(buttons.SpinDance2,"rbxassetid://186934910",true)
bind(buttons.BowDown,"rbxassetid://204292303",true)
bind(buttons.SwordSlam,"rbxassetid://204295235",true)
bind(buttons.MegaInsane,"rbxassetid://184574340",true)
bind(buttons.SuperPunch,"rbxassetid://126753849",true)
bind(buttons.FullSwing,"rbxassetid://218504594",true)
bind(buttons.ArmTurbine,"rbxassetid://259438880",false)
bind(buttons.BarrelRoll,"rbxassetid://136801964",true)
bind(buttons.Scared,"rbxassetid://180612465",true)
bind(buttons.Insane,"rbxassetid://33796059",false)
bind(buttons.ArmDetach,"rbxassetid://33169583",true)
bind(buttons.SwordSlice,"rbxassetid://35978879",false)
bind(buttons.InsaneArms,"rbxassetid://27432691",true)
