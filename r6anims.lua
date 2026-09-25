-- By Zot
local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local Workspace=game:GetService("Workspace")

local player=Players.LocalPlayer
local playerGui=player:WaitForChild("PlayerGui")
local targetParent=playerGui

pcall(function()
	if gethui then
		targetParent=gethui()
	else
		targetParent=game:GetService("CoreGui")
	end
end)

local WINDOW=Color3.fromRGB(0,0,0)
local WINDOW_STROKE=Color3.fromRGB(45,45,50)
local PANEL=Color3.fromRGB(18,18,22)
local PANEL_STROKE=Color3.fromRGB(32,32,36)
local BUTTON=Color3.fromRGB(24,24,28)
local BUTTON_HOVER=Color3.fromRGB(32,32,38)
local BUTTON_ACTIVE=Color3.fromRGB(48,48,58)
local BUTTON_STROKE=Color3.fromRGB(40,40,48)
local TEXT=Color3.fromRGB(240,240,245)
local BUTTON_TEXT=Color3.fromRGB(225,225,232)
local MUTED=Color3.fromRGB(150,150,160)

local old=targetParent:FindFirstChild("R6")
if old then
	old:Destroy()
end

if targetParent~=playerGui then
	local oldPlayerGui=playerGui:FindFirstChild("R6")
	if oldPlayerGui then
		oldPlayerGui:Destroy()
	end
end

local char=player.Character or player.CharacterAdded:Wait()
local hum=char:WaitForChild("Humanoid")
local animator=hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator")

local currentTrack=nil
local currentButton=nil

local gui=Instance.new("ScreenGui")
gui.Name="R6"
gui.ResetOnSpawn=false
gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
gui.Parent=targetParent

local function corner(object,radius)
	local c=Instance.new("UICorner",object)
	c.CornerRadius=UDim.new(0,radius)
	return c
end

local function stroke(object,color,thickness)
	local s=Instance.new("UIStroke",object)
	s.Color=color
	s.Thickness=thickness
	s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
	return s
end

local function setButtonActive(button,state)
	if not button or not button.Parent then
		return
	end
	button.BackgroundColor3=state and BUTTON_ACTIVE or BUTTON
end

local function makeDraggable(dragHandle,targetFrame)
	targetFrame=targetFrame or dragHandle

	local dragging=false
	local dragStart
	local startPos

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragging=true
			dragStart=input.Position
			startPos=Vector2.new(
				targetFrame.Position.X.Offset,
				targetFrame.Position.Y.Offset
			)

			input.Changed:Connect(function()
				if input.UserInputState==Enum.UserInputState.End then
					dragging=false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if not dragging then
			return
		end

		if input.UserInputType~=Enum.UserInputType.MouseMovement and input.UserInputType~=Enum.UserInputType.Touch then
			return
		end

		local camera=Workspace.CurrentCamera
		if not camera then
			return
		end

		local delta=input.Position-dragStart
		local size=targetFrame.AbsoluteSize
		local viewport=camera.ViewportSize
		local topOffset=-57
		local bottomOffset=57

		local x=math.clamp(
			startPos.X+delta.X,
			0,
			math.max(0,viewport.X-size.X)
		)

		local y=math.clamp(
			startPos.Y+delta.Y,
			topOffset,
			math.max(topOffset,viewport.Y-size.Y-bottomOffset)
		)

		targetFrame.Position=UDim2.fromOffset(x,y)
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragging=false
		end
	end)
end

local main=Instance.new("Frame",gui)
main.Name="SlateWindow_R6Animations"
main.Size=UDim2.fromOffset(360,445)
main.BackgroundColor3=WINDOW
main.BorderSizePixel=0
main.ClipsDescendants=true
main.Active=true
corner(main,10)
stroke(main,WINDOW_STROKE,1.2)

local camera=Workspace.CurrentCamera
if camera then
	local viewport=camera.ViewportSize
	main.Position=UDim2.fromOffset(
		math.floor((viewport.X-main.Size.X.Offset)/2),
		math.floor((viewport.Y-main.Size.Y.Offset)/2)
	)
else
	main.Position=UDim2.new(.5,-180,.5,-222)
end

local header=Instance.new("Frame",main)
header.Name="HeaderBar"
header.Size=UDim2.new(1,0,0,38)
header.BackgroundTransparency=1
header.BorderSizePixel=0
header.Active=true

local title=Instance.new("TextLabel",header)
title.Text="R6 Animations"
title.TextSize=20
title.TextColor3=TEXT
title.FontFace=Font.new(
	"rbxasset://fonts/families/SourceSansPro.json",
	Enum.FontWeight.Bold,
	Enum.FontStyle.Normal
)
title.Position=UDim2.fromOffset(12,0)
title.Size=UDim2.new(1,-90,1,0)
title.BackgroundTransparency=1
title.TextXAlignment=Enum.TextXAlignment.Left

local minimizeBtn=Instance.new("TextButton",header)
minimizeBtn.Name="MinimizeBtn"
minimizeBtn.Active=true
minimizeBtn.AutoButtonColor=false
minimizeBtn.Text="—"
minimizeBtn.TextSize=16
minimizeBtn.TextColor3=MUTED
minimizeBtn.Font=Enum.Font.GothamBold
minimizeBtn.Size=UDim2.fromOffset(20,20)
minimizeBtn.Position=UDim2.new(1,-52,0,9)
minimizeBtn.BackgroundTransparency=1
minimizeBtn.BorderSizePixel=0
minimizeBtn.ZIndex=20

local closeBtn=Instance.new("TextButton",header)
closeBtn.Name="CloseBtn"
closeBtn.Active=true
closeBtn.AutoButtonColor=false
closeBtn.Text="X"
closeBtn.TextSize=14
closeBtn.TextColor3=MUTED
closeBtn.Font=Enum.Font.GothamBold
closeBtn.Size=UDim2.fromOffset(20,20)
closeBtn.Position=UDim2.new(1,-28,0,9)
closeBtn.BackgroundTransparency=1
closeBtn.BorderSizePixel=0
closeBtn.ZIndex=20

local function headerHover(button)
	button.MouseEnter:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(.15),
			{TextColor3=TEXT}
		):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(.15),
			{TextColor3=MUTED}
		):Play()
	end)
end

headerHover(minimizeBtn)
headerHover(closeBtn)

makeDraggable(header,main)

local content=Instance.new("Frame",main)
content.Position=UDim2.new(0,10,0,42)
content.Size=UDim2.new(1,-20,1,-50)
content.BackgroundTransparency=1

local animationContainer=Instance.new("Frame",content)
animationContainer.Name="AnimationPicker"
animationContainer.Size=UDim2.new(1,0,1,0)
animationContainer.BackgroundColor3=PANEL
animationContainer.BorderSizePixel=0
corner(animationContainer,9)
stroke(animationContainer,PANEL_STROKE,1)

local animationTitle=Instance.new("TextLabel",animationContainer)
animationTitle.Size=UDim2.new(1,-16,0,20)
animationTitle.Position=UDim2.fromOffset(8,4)
animationTitle.BackgroundTransparency=1
animationTitle.Text="Animations"
animationTitle.TextColor3=TEXT
animationTitle.Font=Enum.Font.GothamBold
animationTitle.TextSize=11
animationTitle.TextXAlignment=Enum.TextXAlignment.Left

local animationScroll=Instance.new("ScrollingFrame",animationContainer)
animationScroll.Name="AnimationList"
animationScroll.Position=UDim2.new(0,8,0,26)
animationScroll.Size=UDim2.new(1,-16,1,-34)
animationScroll.BackgroundTransparency=1
animationScroll.BorderSizePixel=0
animationScroll.ScrollBarThickness=3
animationScroll.ScrollBarImageTransparency=.25
animationScroll.CanvasSize=UDim2.new(0,0,0,0)
animationScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y

local animationGrid=Instance.new("UIGridLayout",animationScroll)
animationGrid.CellSize=UDim2.fromOffset(154,28)
animationGrid.CellPadding=UDim2.fromOffset(8,6)
animationGrid.SortOrder=Enum.SortOrder.LayoutOrder

local buttons={}

local function createButton(name,layoutOrder)
	local button=Instance.new("TextButton",animationScroll)
	button.Name="Animation_"..name:gsub("%W","")
	button.LayoutOrder=layoutOrder
	button.BackgroundColor3=BUTTON
	button.BorderSizePixel=0
	button.AutoButtonColor=false
	button.Text=name
	button.TextColor3=BUTTON_TEXT
	button.TextSize=10
	button.Font=Enum.Font.GothamMedium
	corner(button,4)
	stroke(button,BUTTON_STROKE,1)

	button.MouseEnter:Connect(function()
		if currentButton~=button then
			TweenService:Create(
				button,
				TweenInfo.new(.1),
				{BackgroundColor3=BUTTON_HOVER}
			):Play()
		end
	end)

	button.MouseLeave:Connect(function()
		if currentButton~=button then
			TweenService:Create(
				button,
				TweenInfo.new(.1),
				{BackgroundColor3=BUTTON}
			):Play()
		end
	end)

	buttons[name]=button
	return button
end

local animations={
	{"Salute","rbxassetid://186904307",true},
	{"HeadThrow","rbxassetid://35154961",true},
	{"FloatingHead","rbxassetid://121572214",false},
	{"Crouch","rbxassetid://182724289",false},
	{"FloorCrawl","rbxassetid://282574440",false},
	{"DinoWalk","rbxassetid://204328711",false},
	{"JumpingJacks","rbxassetid://429681631",false},
	{"HeroJump","rbxassetid://184574340",true},
	{"Faint","rbxassetid://181526230",false},
	{"FloorFaint","rbxassetid://181525546",true},
	{"Levitate","rbxassetid://313762630",false},
	{"Dab","rbxassetid://183412246",true},
	{"Spinner","rbxassetid://188632011",true},
	{"FloatSit","rbxassetid://179224234",false},
	{"MovingDance","rbxassetid://429703734",true},
	{"WeirdMove","rbxassetid://215384594",false},
	{"GlitchLevitate","rbxassetid://313762630",false},
	{"SpinDance","rbxassetid://429730430",true},
	{"MoonDance","rbxassetid://45834924",true},
	{"FullPunch","rbxassetid://204062532",true},
	{"SpinDance2","rbxassetid://186934910",true},
	{"BowDown","rbxassetid://204292303",true},
	{"SwordSlam","rbxassetid://204295235",true},
	{"MegaInsane","rbxassetid://184574340",true},
	{"SuperPunch","rbxassetid://126753849",true},
	{"FullSwing","rbxassetid://218504594",true},
	{"ArmTurbine","rbxassetid://259438880",false},
	{"BarrelRoll","rbxassetid://136801964",true},
	{"Scared","rbxassetid://180612465",true},
	{"Insane","rbxassetid://33796059",false},
	{"ArmDetach","rbxassetid://33169583",true},
	{"SwordSlice","rbxassetid://35978879",false},
	{"InsaneArms","rbxassetid://27432691",true}
}

for index,data in ipairs(animations) do
	createButton(data[1],index)
end

local function bind(button,id,loop)
	local anim=Instance.new("Animation")
	anim.AnimationId=id

	button.MouseButton1Click:Connect(function()
		if currentButton==button then
			if currentTrack then
				currentTrack:Stop(0)
				currentTrack.TimePosition=0
			end

			currentTrack=nil
			currentButton=nil
			setButtonActive(button,false)
			return
		end

		if currentTrack then
			currentTrack:Stop(0)
		end

		if currentButton then
			setButtonActive(currentButton,false)
		end

		local track=animator:LoadAnimation(anim)

		currentTrack=track
		currentButton=button
		setButtonActive(button,true)

		if loop then
			task.spawn(function()
				while currentButton==button and currentTrack==track do
					if not track.IsPlaying then
						track:Play(.1,1,1)
					end
					task.wait()
				end
			end)
		else
			track:Play(.1,1,1)
		end
	end)
end

for _,data in ipairs(animations) do
	bind(buttons[data[1]],data[2],data[3])
end

player.CharacterAdded:Connect(function(newCharacter)
	if currentTrack then
		pcall(function()
			currentTrack:Stop(0)
		end)
	end

	if currentButton then
		setButtonActive(currentButton,false)
	end

	currentTrack=nil
	currentButton=nil

	char=newCharacter
	hum=newCharacter:WaitForChild("Humanoid")
	animator=hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator")
end)

local collapsed=false
local sizeTween=nil
local FULL_WIDTH=360
local FULL_HEIGHT=445
local COLLAPSED_HEIGHT=38

local function clampMain(height)
	local camera=Workspace.CurrentCamera
	if not camera then
		return
	end

	local viewport=camera.ViewportSize
	local topOffset=-57
	local bottomOffset=57

	local x=math.clamp(
		main.Position.X.Offset,
		0,
		math.max(0,viewport.X-FULL_WIDTH)
	)

	local y=math.clamp(
		main.Position.Y.Offset,
		topOffset,
		math.max(topOffset,viewport.Y-height-bottomOffset)
	)

	main.Position=UDim2.fromOffset(x,y)
end

local function setCollapsed(state)
	if collapsed==state then
		return
	end

	collapsed=state

	if sizeTween then
		sizeTween:Cancel()
		sizeTween=nil
	end

	if collapsed then
		content.Visible=false

		sizeTween=TweenService:Create(
			main,
			TweenInfo.new(.18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Size=UDim2.fromOffset(FULL_WIDTH,COLLAPSED_HEIGHT)}
		)

		sizeTween:Play()
	else
		clampMain(FULL_HEIGHT)

		sizeTween=TweenService:Create(
			main,
			TweenInfo.new(.18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Size=UDim2.fromOffset(FULL_WIDTH,FULL_HEIGHT)}
		)

		local thisTween=sizeTween
		thisTween.Completed:Once(function()
			if not collapsed and sizeTween==thisTween and main.Parent then
				content.Visible=true
			end
		end)

		thisTween:Play()
	end
end

minimizeBtn.MouseButton1Click:Connect(function()
	setCollapsed(not collapsed)
end)

closeBtn.MouseButton1Click:Connect(function()
	if currentTrack then
		pcall(function()
			currentTrack:Stop(0)
			currentTrack:Destroy()
		end)
		currentTrack=nil
	end

	currentButton=nil
	gui:Destroy()
end)
