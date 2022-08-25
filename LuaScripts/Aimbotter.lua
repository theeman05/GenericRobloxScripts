local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local TRIGGER = Enum.UserInputType.MouseButton2

local CIRCLE_OBJ = {
	ID = 0;
	Type = "ImageLabel";
	Properties = {
		AnchorPoint = Vector2.new(0.5,0.5);
		Image = "rbxassetid://8887908111";
		BackgroundTransparency = 1;
		ImageTransparency = 0.699999988079071;
		Position = UDim2.new(0.5,0,0.5,0);
		Size = UDim2.new(0,150,0,150);
		ImageColor3 = Color3.new(0,1,1);
		BackgroundColor3 = Color3.new(1,1,1);
		Visible = false;
	};
	Children = {}
}

-- Custom variables for ease
local ENEMIES = workspace.Drones -- Enemy search folder
local TARGET_PART = "Body" -- The target part name in the enemy
local REQUIRES_HUM = false -- If we need a Humanoid for the search
--

local lPlayer = game.Players.LocalPlayer
local pGui = lPlayer.PlayerGui
local mouse = lPlayer:GetMouse()

local camera = workspace.CurrentCamera
local targetFunct

local gui = Instance.new("ScreenGui")

local toggled = false 
local target, circle, circleSize

function createObj(objProps, parent)
	local inst = Instance.new(objProps.Type)
	for prop, val in pairs(objProps.Properties) do
		inst[prop] = val
	end
	if parent then
		inst.Parent = parent
	end
	return inst
end

function lookCameraAt(lookAtPos)
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = CFrame.lookAt(lPlayer.Character.Head.Position, lookAtPos)
end

-- Check if humanoid is dead
function humIsAlive(humanoid:Humanoid)
	return humanoid.Health > 0
end

-- Get the hrp (if object is alive)
function getBasics(obj)
	local hum = obj:FindFirstChild("Humanoid")
	local hrp = obj:FindFirstChild(TARGET_PART)
	if hrp and (not REQUIRES_HUM or (hum and humIsAlive(obj.Humanoid))) then
		return hrp
	end
end

-- Test is an object is in the circle
function isPosInCircle(objectPos)
	local locallized, circleRadius, yDist, maxY
	local vector, onScreen = camera:WorldToScreenPoint(objectPos)
	if onScreen and vector.X >= circle.AbsolutePosition.X and vector.X <= circle.AbsolutePosition.X + circleSize.X then
		circleRadius = circleSize.X/2
		locallized = Vector2.new(vector.X-circle.AbsolutePosition.X, vector.Y-circle.AbsolutePosition.Y)
		maxY = math.sqrt(circleRadius^2-(locallized.X-circleRadius)^2)
		yDist = maxY - math.abs(locallized.Y - circleRadius)
		return yDist >= 0 and yDist <= maxY 
	end
end

-- Note this is based on the camera pos in a given set. Defaults to ENEMIES
function getClosestTarg(targets)
	local prevClosest, prevDist, curDist, hrp
	for _,enemy in pairs((targets or ENEMIES):GetChildren()) do
		hrp = getBasics(enemy)
		if hrp then
			curDist = (camera.CFrame.Position - hrp.Position).Magnitude
			if (prevDist and prevDist > curDist) or not prevDist then
				prevDist = (camera.CFrame.Position - hrp.Position).Magnitude
				prevClosest = hrp
			end
		end
	end
	return prevClosest
end

function getClosestInCircle()
	local prevClosest, prevDist, curDist, hrp
	for _, enemy in pairs(ENEMIES:GetChildren()) do
		hrp = getBasics(enemy)
		if hrp and isPosInCircle(hrp.Position) then
			curDist = (camera.CFrame.Position - hrp.Position).Magnitude
			if (prevDist and prevDist > curDist) or not prevDist then
				prevDist = (camera.CFrame.Position - hrp.Position).Magnitude
				prevClosest = hrp
			end
		end
	end
	return prevClosest
end

------------------INIT------------------
circle = createObj(CIRCLE_OBJ, gui)
targetFunct = getClosestInCircle
circleSize = circle.AbsoluteSize
gui.Parent = pGui
----------------------------------------

UIS.InputBegan:Connect(function(input)
	if input.UserInputType == TRIGGER then
		toggled = true
		circle.Visible = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == TRIGGER then
		toggled = false
		circle.Visible = false
		camera.CameraType = Enum.CameraType.Custom
	end
end)

RS.Stepped:Connect(function()
	if toggled then
		--circle.Position = UDim2.new(0,mouse.X,0,mouse.Y)
		target = targetFunct()
		if target then
			lookCameraAt(target.Position)
		end
	end
end)