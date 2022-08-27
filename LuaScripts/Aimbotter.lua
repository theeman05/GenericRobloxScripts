local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local TRIGGER = Enum.UserInputType.MouseButton2

local ROOT = {
	ID = 0;
	Type = "ScreenGui";
	Properties = {
		Name = "BOTTERGUI";
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	};
	Children = {
		{
			ID = 1;
			Type = "ImageButton";
			Properties = {
				ImageColor3 = Color3.new(0,0,0);
				ScaleType = Enum.ScaleType.Slice;
				Active = true;
				Image = "rbxassetid://8887908111";
				BackgroundTransparency = 1;
				Position = UDim2.new(0,0,0,0);
				SliceScale = 0.03799999877810478;
				Name = "Background";
				Size = UDim2.new(0,250,0,300);
				SliceCenter = Rect.new(Vector2.new(250,250),Vector2.new(250,250));
			};
			Children = {
				{
					ID = 2;
					Type = "ImageLabel";
					Properties = {
						ImageColor3 = Color3.new(53/255,53/255,53/255);
						ScaleType = Enum.ScaleType.Slice;
						Active = true;
						Image = "rbxassetid://8887908111";
						BackgroundTransparency = 1;
						Position = UDim2.new(0,2,0,2);
						SliceScale = 0.035999998450279236;
						Name = "GroupsFrame";
						Size = UDim2.new(1,-4,1,-4);
						SliceCenter = Rect.new(Vector2.new(250,250),Vector2.new(250,250));
					};
					Children = {
						{
							ID = 3;
							Type = "ScrollingFrame";
							Properties = {
								ScrollBarImageColor3 = Color3.new(0,0,0);
								Position = UDim2.new(0,0,0,40);
								Active = true;
								Size = UDim2.new(1,0,1,-100);
								ZIndex = 2;
								BackgroundColor3 = Color3.new(1,2/3,127/255);
								CanvasSize = UDim2.new();
							};
							Children = {
								{
									ID = 4;
									Type = "UIListLayout";
									Properties = {
										Padding = UDim.new(0,2);
										SortOrder = Enum.SortOrder.LayoutOrder;
									};
									Children = {};
								};
								{
									ID = 5;
									Type = "ImageButton";
									Properties = {
										ImageColor3 = Color3.new(1,2/3,127/255);
										ScaleType = Enum.ScaleType.Slice;
										Name = "TestGroup";
										PressedImage = "rbxassetid://8887968624";
										HoverImage = "rbxassetid://8887979312";
										Image = "rbxassetid://8887908111";
										BackgroundTransparency = 1;
										Size = UDim2.new(1,0,0,25);
										SliceScale = 0.0010000000474974513;
										ZIndex = 2;
										Archivable = false;
										SliceCenter = Rect.new(Vector2.new(250,250),Vector2.new(250,250));
									};
									Children = {
										{
											ID = 6;
											Type = "TextLabel";
											Properties = {
												FontSize = Enum.FontSize.Size18;
												TextColor3 = Color3.new(1,1,1);
												Text = "Drones";
												TextStrokeTransparency = 0;
												BackgroundTransparency = 1;
												Font = Enum.Font.SourceSansSemibold;
												Name = "TextButton";
												TextXAlignment = Enum.TextXAlignment.Left;
												Size = UDim2.new(1,0,1,0);
												ZIndex = 2;
												TextSize = 16;
												BackgroundColor3 = Color3.new(1,1,1);
											};
											Children = {
												{
													ID = 7;
													Type = "Frame";
													Properties = {
														Name = "Line";
														Position = UDim2.new(0,0,1,-1);
														Size = UDim2.new(1,0,0,1);
														ZIndex = 2;
														BorderSizePixel = 0;
														BackgroundColor3 = Color3.new(0,0,0);
													};
													Children = {};
												};
											};
										};
									};
								};
								{
									ID = 8;
									Type = "UIPadding";
									Properties = {
										PaddingLeft = UDim.new(0,5);
									};
									Children = {};
								};
							};
						};
						{
							ID = 9;
							Type = "ImageLabel";
							Properties = {
								ImageColor3 = Color3.new(1,2/3,127/255);
								ScaleType = Enum.ScaleType.Slice;
								Image = "rbxassetid://8887908111";
								BackgroundTransparency = 1;
								Position = UDim2.new(0,0,0.5,0);
								SliceScale = 0.035999998450279236;
								Name = "Frame";
								Size = UDim2.new(1,0,0.5,0);
								SliceCenter = Rect.new(Vector2.new(250,250),Vector2.new(250,250));
							};
							Children = {
								{
									ID = 10;
									Type = "ImageButton";
									Properties = {
										ImageColor3 = Color3.new(0,1,127/255);
										ScaleType = Enum.ScaleType.Slice;
										PressedImage = "rbxassetid://8887968624";
										HoverImage = "rbxassetid://8887979312";
										Image = "rbxassetid://8887908111";
										BackgroundTransparency = 1;
										Position = UDim2.new(0.5,-50,1,-50);
										SliceScale = 0.035999998450279236;
										Name = "AddGroupBtn";
										Size = UDim2.new(0,100,0,40);
										SliceCenter = Rect.new(Vector2.new(250,250),Vector2.new(250,250));
									};
									Children = {
										{
											ID = 11;
											Type = "TextLabel";
											Properties = {
												FontSize = Enum.FontSize.Size24;
												TextColor3 = Color3.new(1,1,1);
												Text = "Add Group";
												TextStrokeTransparency = 0;
												Font = Enum.Font.SourceSansBold;
												Name = "TextButton";
												BackgroundTransparency = 1;
												BackgroundColor3 = Color3.new(0,1,127/255);
												TextSize = 20;
												Size = UDim2.new(1,0,1,0);
											};
											Children = {};
										};
									};
								};
							};
						};
						{
							ID = 12;
							Type = "TextLabel";
							Properties = {
								TextWrapped = true;
								TextColor3 = Color3.new(1,1,1);
								Text = "Scannable Groups:";
								TextStrokeTransparency = 0;
								Font = Enum.Font.SourceSansBold;
								BackgroundTransparency = 1;
								Size = UDim2.new(1,-36,0,40);
								FontSize = Enum.FontSize.Size28;
								TextWrap = true;
								TextSize = 27;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {
								{
									ID = 13;
									Type = "Frame";
									Properties = {
										Name = "Line";
										Position = UDim2.new(0,0,1,-1);
										Size = UDim2.new(1,0,0,1);
										BorderSizePixel = 0;
										BackgroundColor3 = Color3.new(0,0,0);
									};
									Children = {};
								};
							};
						};
					};
				};
				{
					ID = 14;
					Type = "ImageLabel";
					Properties = {
						ImageColor3 = Color3.new(53/255,53/255,53/255);
						ScaleType = Enum.ScaleType.Slice;
						Visible = false;
						Image = "rbxassetid://8887908111";
						BackgroundTransparency = 1;
						Position = UDim2.new(0,2,0,2);
						SliceScale = 0.035999998450279236;
						Name = "SelectTargetLabel";
						Size = UDim2.new(1,-4,1,-4);
						SliceCenter = Rect.new(Vector2.new(250,250),Vector2.new(250,250));
					};
					Children = {
						{
							ID = 15;
							Type = "TextLabel";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextColor3 = Color3.new(1,1,1);
								Text = "Select Target Part...";
								Size = UDim2.new(1,-52,1,0);
								TextStrokeTransparency = 0;
								TextWrapped = true;
								Font = Enum.Font.SourceSansBold;
								BackgroundTransparency = 1;
								Position = UDim2.new(0,5,0,0);
								TextSize = 14;
								BackgroundColor3 = Color3.new(1,1,1);
								TextScaled = true;
								TextWrap = true;
							};
							Children = {};
						};
					};
				};
				{
					ID = 16;
					Type = "ImageButton";
					Properties = {
						ImageColor3 = Color3.new(53/255,53/255,53/255);
						ScaleType = Enum.ScaleType.Slice;
						PressedImage = "rbxassetid://8887968624";
						HoverImage = "rbxassetid://8887979312";
						Image = "rbxassetid://8887908111";
						BackgroundTransparency = 1;
						Position = UDim2.new(1,-38,0,2);
						SliceScale = 0.035999998450279236;
						Name = "Close";
						Size = UDim2.new(0,36,0,36);
						SliceCenter = Rect.new(Vector2.new(250,250),Vector2.new(250,250));
					};
					Children = {
						{
							ID = 17;
							Type = "TextLabel";
							Properties = {
								TextWrapped = true;
								TextColor3 = Color3.new(1,0,0);
								Text = "X";
								TextStrokeTransparency = 0;
								Font = Enum.Font.GothamBold;
								BackgroundTransparency = 1;
								Size = UDim2.new(1,0,1,0);
								FontSize = Enum.FontSize.Size48;
								TextWrap = true;
								TextSize = 40;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {};
						};
					};
				};
			};
		};
		{
			ID = 18;
			Type = "ImageLabel";
			Properties = {
				ImageColor3 = Color3.new(0,1,1);
				ImageTransparency = 0.699999988079071;
				AnchorPoint = Vector2.new(0.5,0.5);
				Image = "rbxassetid://8887908111";
				BackgroundTransparency = 1;
				Position = UDim2.new(0.5,0,0.5,0);
				Visible = false;
				Name = "BotCircle";
				Size = UDim2.new(0,150,0,150);
				BackgroundColor3 = Color3.new(1,1,1);
			};
			Children = {};
		};
	};
};

local GROUP_OBJ = {
	ID = 5;
	Type = "ImageButton";
	Properties = {
		ImageColor3 = Color3.new(1,2/3,127/255);
		ScaleType = Enum.ScaleType.Slice;
		Name = "TestGroup";
		PressedImage = "rbxassetid://8887968624";
		HoverImage = "rbxassetid://8887979312";
		Image = "rbxassetid://8887908111";
		BackgroundTransparency = 1;
		Size = UDim2.new(1,0,0,25);
		SliceScale = 0.0010000000474974513;
		ZIndex = 2;
		SliceCenter = Rect.new(Vector2.new(250,250),Vector2.new(250,250));
	};
	Children = {
		{
			ID = 6;
			Type = "TextLabel";
			Properties = {
				FontSize = Enum.FontSize.Size18;
				TextColor3 = Color3.new(1,1,1);
				Text = "Drones";
				TextStrokeTransparency = 0;
				BackgroundTransparency = 1;
				Font = Enum.Font.SourceSansSemibold;
				Name = "TextButton";
				TextXAlignment = Enum.TextXAlignment.Left;
				Size = UDim2.new(1,0,1,0);
				ZIndex = 2;
				TextSize = 16;
				BackgroundColor3 = Color3.new(1,1,1);
			};
			Children = {
				{
					ID = 7;
					Type = "Frame";
					Properties = {
						Name = "Line";
						Position = UDim2.new(0,0,1,-1);
						Size = UDim2.new(1,0,0,1);
						ZIndex = 2;
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(0,0,0);
					};
					Children = {};
				};
			};
		};
	};
}

-- Group background size = {0, 250},{0, 300}
-- SelectTargetLabel size = {0, 225},{0, 40}

-- Custom variables for ease
local ENEMIES = workspace.Drones -- Enemy search folder
local TARGET_PART = "Body" -- The target part name in the enemy
local REQUIRES_HUM = false -- If we need a Humanoid for the search
--

local lPlayer = game.Players.LocalPlayer
local pGui = lPlayer.PlayerGui
local mouse = lPlayer:GetMouse()

local selectBox = Instance.new("SelectionBox", workspace)
selectBox.Color3 = Color3.fromRGB(170,170,255)
selectBox.LineThickness = .05

local camera = workspace.CurrentCamera

local toggled = false 

local groupObjects = {} -- [Group] = "TargetPart"
local target, targetFunct, mouseTarg

local function Scan(item, parent, partsWithId:table, awaitRef:table)
	if item.Properties.Archivable == nil or item.Properties.Archivable == true then
		awaitRef = awaitRef or {}
		local obj = Instance.new(item.Type)
		if (item.ID) then
			local awaiting = awaitRef[item.ID]
			if (awaiting) then
				awaiting[1][awaiting[2]] = obj
				awaitRef[item.ID] = nil
			else
				partsWithId[item.ID] = obj
			end
		end
		for p,v in pairs(item.Properties) do
			if (type(v) == "string") then
				local id = tonumber(v:match("^_R:(%w+)_$"))
				if (id) then
					if (partsWithId[id]) then
						v = partsWithId[id]
					else
						awaitRef[id] = {obj, p}
						v = nil
					end
				end
			end
			obj[p] = v
		end
		for _,c in pairs(item.Children) do
			Scan(c, obj, partsWithId, awaitRef)
		end
		obj.Parent = parent
		return obj
	end
end

local function snapNumber(num, increment)
	return increment and math.round(num / increment) * increment or num
end

---------------------GUI STUFF---------------------
local enteredObjectFunct = nil -- Basically remote MouseLeave
local partswithIdG = {}
local root = Scan(ROOT, pGui, partswithIdG)
local background = partswithIdG[1]
local groupsScroller = partswithIdG[3]

local groupsID, targetsID = 2, 14

local circle = partswithIdG[18]
local circleSize = circle.AbsoluteSize

local selectingTarg = false
local selectedTarg = nil

local prevVisibleObj

local uiObjsDat = {
	[groupsID] = {Object = partswithIdG[groupsID], Size = UDim2.new(0, 250, 0, 300)}; 
	[targetsID] = {Object = partswithIdG[targetsID], Size = UDim2.new(0, 225, 0, 40)}
}

function createGroupBtn(group, targetPartName)
	if not group or groupObjects[group] then
		return
	end
	
	local partswithId = {}
	local groupBtn = Scan(GROUP_OBJ, groupsScroller, partswithId)
	local groupLabel = partswithId[6]
	local arrObjects = group:GetChildren()

	local function mouseLeave()
		groupLabel.Text = group.Name.. " - ".. targetPartName
	end
	
	local function monitorJoints(object)
		local connection
		connection = object.DescendantRemoving:Connect(function(removeObj)
			if removeObj:IsA("Weld") or removeObj:IsA("Motor") then
				table.remove(arrObjects, table.find(arrObjects, object))
				connection:Disconnect()
			end
		end)
	end
	
	for _,object in pairs(arrObjects) do
		monitorJoints(object)
	end
	
	groupBtn.MouseButton1Down:Connect(function()
		groupObjects[group] = nil
		groupBtn:Destroy()
	end)
	
	groupBtn.MouseEnter:Connect(function()
		if enteredObjectFunct then
			enteredObjectFunct()
		end
		enteredObjectFunct = mouseLeave
		groupLabel.Text = group:GetFullName()
	end)
	
	groupBtn.MouseLeave:Connect(function()
		if enteredObjectFunct == mouseLeave then
			mouseLeave()
			enteredObjectFunct = nil
		end
	end)
	
	group.ChildAdded:Connect(function(object)
		monitorJoints(object)
	end)
	
	group.ChildRemoved:Connect(function(object)
		if table.find(arrObjects, object) then
			table.remove(arrObjects, table.find(arrObjects, object))
		end
	end)
	
	mouseLeave()
	
	groupObjects[group] = {["TargetPart"] = targetPartName, ["Objects"] = arrObjects}
end

function showDesiredObj(objID)
	local objDat = uiObjsDat[objID]
	if not objDat then
		return
	end
	
	selectingTarg = false
	
	if prevVisibleObj then
		prevVisibleObj.Visible = false
	end
	
	background.Size = objDat.Size
	objDat.Object.Visible = true
	prevVisibleObj = objDat.Object
end

partswithIdG[10].MouseButton1Down:Connect(function()
	showDesiredObj(targetsID)
	selectingTarg = true
end)

partswithIdG[16].MouseButton1Down:Connect(function()
	showDesiredObj(groupsID)
end)

createGroupBtn(ENEMIES, TARGET_PART)
showDesiredObj(groupsID)

mouse.Button1Down:Connect(function()
	if selectingTarg then
		selectingTarg = false
		createGroupBtn(selectedTarg.Parent.Parent, selectedTarg.Name)
		showDesiredObj(groupsID)
		selectBox.Adornee = nil
	end
end)


do
	local SEL_START_SIG = "SelectionStart"
	local MOUSE_MOVE = Enum.UserInputType.MouseMovement
	local MOUSE_1 = Enum.UserInputType.MouseButton1

	local CURSOR_OFFSET = Vector2.new(0, 0)
	local LENIENCE = .05

	local newBounds = {Min = Vector2.zero, Max = Vector2.zero}
	local mouseDown = false
	local mouseLocation, lastMouseLocation, lastMousePos, delta, desired, newPos, diff
	local movingObjDat
	
	local function onInputChanged(input, gameProcessed)
		local intputType = input.UserInputType
		if intputType == MOUSE_MOVE and movingObjDat then
			mouseLocation = UIS:GetMouseLocation()
			if movingObjDat["AtCursor"] then
				delta = mouseLocation - movingObjDat.Obj.AbsolutePosition + movingObjDat["Bounds"].Min + CURSOR_OFFSET - (movingObjDat.Obj.AbsoluteSize/2)--Vector2.new(movingObjDat.Obj.AbsoluteSize.X/2, movingObjDat.Obj.AbsoluteSize.Y)
			else
				delta = lastMousePos and mouseLocation - lastMousePos or Vector2.new(0,0)
			end

			if movingObjDat["Bounds"] then
				diff = movingObjDat.Bounds.Max - movingObjDat.Bounds.Min

				if diff.X == 0 and diff.Y == 0 then
					delta = Vector2.zero
				elseif diff.X == 0 then
					delta = Vector2.new(0, delta.Y / diff.Y)
				elseif diff.Y == 0 then
					delta = Vector2.new(delta.X / diff.X, 0)
				else
					delta = delta / diff
				end

				desired = movingObjDat.Obj.Position + UDim2.fromScale(delta.X, delta.Y)

				newBounds.Min = movingObjDat["Bounds"].Min / diff
				newBounds.Max = movingObjDat.Bounds.Max / diff

				if diff.X == 0 then
					newBounds.Min = Vector2.new(0, newBounds.Min.Y)
					newBounds.Max = Vector2.new(0, newBounds.Max.Y)
				end

				if diff.Y == 0 then
					newBounds.Min = Vector2.new(newBounds.Min.X, 0)
					newBounds.Max = Vector2.new(newBounds.Max.X, 0)
				end

				newPos = UDim2.new(snapNumber(math.clamp(desired.X.Scale, newBounds.Min.X, newBounds.Max.X), movingObjDat.Increment), 0, snapNumber(math.clamp(desired.Y.Scale, newBounds.Min.Y, newBounds.Max.Y), movingObjDat.Increment), 0)
			else
				desired = movingObjDat.Obj.Position + UDim2.fromOffset(delta.X, delta.Y)
				newPos = desired
			end

			movingObjDat.Obj.Position = newPos

			if movingObjDat["Callback"] then
				movingObjDat.Callback(newPos)
			end

			lastMousePos = mouseLocation
		end
	end

	function moveObjOnHold(btn, object, props)
		props = props or {}
		local data = {["Obj"] = object}
		local parAbsSize = object.Parent and object.Parent.AbsoluteSize or root.AbsoluteSize
		if props["AtCursor"] then
			data["Bounds"] = {
				Min = Vector2.zero;
				Max = parAbsSize;
			}

			data["AtCursor"] = true
		elseif props["AtY"] then
			data["Bounds"] = {
				Min = Vector2.zero;
				Max = Vector2.new(0, parAbsSize.Y);
			}

			data["AtCursor"] = true
		elseif props["AtX"] then
			data["Bounds"] = {
				Min = Vector2.zero;
				Max = Vector2.new(parAbsSize.X, 0);
			}

			data["AtCursor"] = true
		end

		data["Increment"] = props.Increment
		data["Callback"] = props["Callback"]

		if object.Parent then
			object.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				if props["AtY"] then
					data["Bounds"] = {
						Min = Vector2.zero;
						Max = Vector2.new(0, object.Parent.AbsoluteSize.Y);
					}
				elseif props["AtX"] then
					data["Bounds"] = {
						Min = Vector2.zero;
						Max = Vector2.new(object.Parent.AbsoluteSize.X, 0);
					}
				end
			end)
		end

		if btn:IsA("GuiButton") then
			btn.MouseButton1Down:Connect(function()
				movingObjDat = data
			end)
		elseif btn:IsA("TextBox") then
			btn:GetPropertyChangedSignal(SEL_START_SIG):Connect(function()
				if (btn.SelectionStart == 1 or string.len(btn.Text) + 1) and mouseDown then
					mouseLocation = UIS:GetMouseLocation()
					diff = object.Parent.AbsolutePosition + object.Parent.AbsoluteSize - mouseLocation
					if ((diff.X <= data["Bounds"].Max.X and diff.X >= data["Bounds"].Min.X) or props["AtY"]) and ((diff.Y <= data["Bounds"].Max.Y and diff.Y >= data["Bounds"].Min.Y) or props["AtX"]) then
						movingObjDat = data
						btn.CursorPosition = string.len(btn.Text) + 1
						btn.SelectionStart = -1
					end
				end
			end)
		end
	end
	
	moveObjOnHold(background, background)
	
	UIS.InputBegan:Connect(function(input)
		local intputType = input.UserInputType 
		if intputType == TRIGGER then
			toggled = true
			circle.Visible = true
		elseif intputType == MOUSE_1 then
			mouseDown = true
		end
	end)

	UIS.InputEnded:Connect(function(input)
		local intputType = input.UserInputType 
		if intputType == TRIGGER then
			toggled = false
			circle.Visible = false
			camera.CameraType = Enum.CameraType.Custom
		elseif intputType == MOUSE_1 then
			mouseDown = false
			movingObjDat = nil
			lastMousePos = nil
		end
	end)
	UIS.InputChanged:Connect(onInputChanged)
end

-------------------END GUI STUFF-------------------

-------------------AIMBOT STUFF-------------------
function lookCameraAt(lookAtPos)
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = CFrame.lookAt(lPlayer.Character.Head.Position, lookAtPos)
end

-- Check if humanoid is dead
function humIsAlive(humanoid:Humanoid)
	return humanoid.Health > 0
end

-- Get the hrp (if object is alive)
function getBasics(obj, targPart)
	local hum = obj:FindFirstChild("Humanoid")
	local hrp = obj:FindFirstChild(targPart or TARGET_PART)
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

-- Note this is based on the camera pos in a given set
function getClosestTarg()
	local prevClosest, prevDist, curDist, hrp
	for group, targPart in pairs(groupObjects) do
		for _, enemy in pairs(group:GetChildren()) do
			hrp = getBasics(enemy, targPart)
			if hrp then
				curDist = (camera.CFrame.Position - hrp.Position).Magnitude
				if (prevDist and prevDist > curDist) or not prevDist then
					prevDist = (camera.CFrame.Position - hrp.Position).Magnitude
					prevClosest = hrp
				end
			end
		end
	end
	return prevClosest
end

function getClosestInCircle()
	local prevClosest, prevDist, curDist, hrp
	for group, groupData in pairs(groupObjects) do
		for _, enemy in pairs(groupData.Objects) do
			hrp = getBasics(enemy, groupData.TargetPart)
			if hrp and isPosInCircle(hrp.Position) then
				curDist = (camera.CFrame.Position - hrp.Position).Magnitude
				if (prevDist and prevDist > curDist) or not prevDist then
					prevDist = (camera.CFrame.Position - hrp.Position).Magnitude
					prevClosest = hrp
				end
			end
		end
	end
	return prevClosest
end
-------------------END AIMBOT STUFF-------------------

------------------INIT------------------
targetFunct = getClosestInCircle
----------------------------------------

RS.Stepped:Connect(function()
	if toggled then
		--circle.Position = UDim2.new(0,mouse.X,0,mouse.Y)
		target = targetFunct()
		if target then
			lookCameraAt(target.Position)
		end
	end
	
	if selectingTarg then
		mouseTarg = mouse.Target
		if mouseTarg and mouseTarg.Parent and mouseTarg.Parent.Parent and (mouseTarg.Parent.Parent:IsA("Folder") or mouseTarg.Parent.Parent:IsA("Model")) then
			selectBox.Adornee = mouseTarg.Parent
			selectedTarg = mouseTarg
		else
			selectBox.Adornee = nil
		end
	end
end)