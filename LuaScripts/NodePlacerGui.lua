--[[
	Sup -
	this is a script which spawns a screen gui containing the necessities to
	place, traverse, and delete waypoint nodes by the user.
	Enjoy...
--]]

local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local MODES = {
	Standby 	= "On Standby";
	Placing 	= "Placing Nodes";
	Following 	= "Following Nodes";
	Delete 		= "Deleting Nodes";
}

local root = {
	ID = 0;
	Type = "Frame";
	Properties = {
		Position = UDim2.new(0.890999972820282,0,0.3089999854564667,0);
		Size = UDim2.new(0,178,0,153);
		Name = "Backdrop";
		BackgroundColor3 = Color3.new(2/3,113/255,0);
	};
	Children = {
		{
			ID = 1;
			Type = "ImageButton";
			Properties = {
				Position = UDim2.new(0,-5,0,-5);
				Size = UDim2.new(0,178,0,153);
				Name = "Inner";
				BackgroundColor3 = Color3.new(1,2/3,0);
				AutoButtonColor = false;
				Image = "";
			};
			Children = {
				{
					ID = 2;
					Type = "TextLabel";
					Properties = {
						FontSize = Enum.FontSize.Size14;
						TextColor3 = Color3.new(0,0,0);
						Text = "Currently:";
						Font = Enum.Font.SourceSansBold;
						BackgroundTransparency = 1;
						Position = UDim2.new(0,5,0,25);
						TextXAlignment = Enum.TextXAlignment.Left;
						Size = UDim2.new(0,60,0,25);
						TextSize = 14;
						BackgroundColor3 = Color3.new(1,1,1);
					};
					Children = {};
				};
				{
					ID = 3;
					Type = "TextLabel";
					Properties = {
						FontSize = Enum.FontSize.Size18;
						TextColor3 = Color3.new(0,0,0);
						TextStrokeColor3 = Color3.new(1,1,1);
						Text = "Node Editor";
						Font = Enum.Font.SourceSansBold;
						BackgroundTransparency = 1;
						Size = UDim2.new(1,0,0,25);
						TextSize = 18;
						BackgroundColor3 = Color3.new(1,1,1);
					};
					Children = {};
				};
				{
					ID = 4;
					Type = "TextLabel";
					Properties = {
						FontSize = Enum.FontSize.Size14;
						TextColor3 = Color3.new(1,1/3,0);
						Text = "On Standby";
						TextXAlignment = Enum.TextXAlignment.Left;
						Font = Enum.Font.SourceSansBold;
						Name = "Current";
						Position = UDim2.new(0,65,0,25);
						BackgroundTransparency = 1;
						Size = UDim2.new(0,60,0,25);
						TextSize = 14;
						BackgroundColor3 = Color3.new(1,1,1);
					};
					Children = {};
				};
				{
					ID = 5;
					Type = "Frame";
					Properties = {
						Name = "Buttons";
						Position = UDim2.new(0,0,0,50);
						BackgroundTransparency = 1;
						Size = UDim2.new(0,178,0,100);
						BackgroundColor3 = Color3.new(1,1,1);
					};
					Children = {
						{
							ID = 6;
							Type = "TextButton";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextColor3 = Color3.new(1,1,1);
								Text = "Standby";
								Font = Enum.Font.SourceSans;
								Name = "Standby";
								Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
								Size = UDim2.new(1,0,0,25);
								TextSize = 14;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {};
						};
						{
							ID = 7;
							Type = "TextButton";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextColor3 = Color3.new(1,1,1);
								Text = "Place Nodes";
								Font = Enum.Font.SourceSans;
								Name = "PlaceNodes";
								Position = UDim2.new(0,0,0,25);
								Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
								Size = UDim2.new(1,0,0,25);
								TextSize = 14;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {};
						};
						{
							ID = 8;
							Type = "TextButton";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextColor3 = Color3.new(1,1,1);
								Text = "Follow Nodes";
								Font = Enum.Font.SourceSans;
								Name = "FollowNodes";
								Position = UDim2.new(0,0,0,50);
								Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
								Size = UDim2.new(1,0,0,25);
								TextSize = 14;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {};
						};
						{
							ID = 9;
							Type = "TextButton";
							Properties = {
								FontSize = Enum.FontSize.Size14;
								TextColor3 = Color3.new(1,1,1);
								Text = "Delete Nodes";
								Font = Enum.Font.SourceSans;
								Name = "DeleteNodes";
								Position = UDim2.new(0,0,0,75);
								Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
								Size = UDim2.new(1,0,0,25);
								TextSize = 14;
								BackgroundColor3 = Color3.new(1,1,1);
							};
							Children = {};
						};
					};
				};
				{
					ID = 10;
					Type = "UICorner";
					Properties = {CornerRadius=UDim.new(0,5)};
					Children = {};
				};
			};
		};
		{
			ID = 11;
			Type = "UICorner";
			Properties = {CornerRadius=UDim.new(0,5)};
			Children = {};
		};
	};
};

local nodeGUI = Instance.new("ScreenGui")
nodeGUI.ResetOnSpawn = false

local nodeFolder = Instance.new("Folder", workspace)
nodeFolder.Name = "Nodes"

local selBox = Instance.new("SelectionBox", nodeGUI)
selBox.Color3 = Color3.new(1,0,0)
selBox.LineThickness = .05

local mode = MODES.Standby

local nodes = {}
local partsWithId = {}
local awaitRef = {}

local prevMousePos = Vector2.new(0,0)
local dragging = false
local curNode = 1

local diff, curLoc, humanoid, placementNode, deleteNode

local function Scan(item, parent)
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
		Scan(c, obj)
	end
	obj.Parent = parent
	return obj
end

local function followNodes()
	if humanoid then
		humanoid:MoveTo(nodes[curNode].Position - Vector3.new(0,45,0))
	end
end

local function charAdded(character)
	humanoid = character:WaitForChild("Humanoid", 5)
	humanoid.MoveToFinished:Connect(function(reached)
		if mode == MODES.Following then
			if reached then
				curNode = curNode < table.getn(nodes) and curNode + 1 or 1
			end
			followNodes()
		end
	end)
end

local function spawnNode()
	local node = Instance.new("Part")
	node.Anchored = true
	node.CanCollide = false
	node.Transparency = .86
	node.Color = Color3.new(1,0,0)
	node.Size = Vector3.new(2,100,2)
	node.Position = mouse.Hit.Position + Vector3.new(0,50,0)
	node.Parent = nodeFolder
	mouse.TargetFilter = node
	return node
end

local function placeNode()
	placementNode.Color = Color3.new(0,1,1)
	table.insert(nodes, placementNode)
end

local function updateModeTxt()
	partsWithId[4].Text = mode
	if mode ~= MODES.Placing then
		if placementNode then
			placementNode:Destroy()
			placementNode = nil
		end
		
		if deleteNode then
			deleteNode = nil
			selBox.Adornee = nil
		end
	end
end

function assignButtonFuncts()
	partsWithId[1].MouseButton1Down:Connect(function()
		prevMousePos = UIS:GetMouseLocation()
		dragging = true
	end)
	partsWithId[1].MouseButton1Up:Connect(function()
		dragging = false
	end)
	partsWithId[6].MouseButton1Down:Connect(function()
		mode = MODES.Standby
		updateModeTxt()
	end)
	partsWithId[7].MouseButton1Down:Connect(function()
		if not placementNode then
			placementNode = spawnNode()
			mode = MODES.Placing
			updateModeTxt()
		end
	end)
	partsWithId[8].MouseButton1Down:Connect(function()
		if table.getn(nodes) > 0 then
			mode = MODES.Following
			followNodes()
			updateModeTxt()
		end
	end)
	partsWithId[9].MouseButton1Down:Connect(function()
		mode = MODES.Delete
		updateModeTxt()
	end)
end

-- INIT --
Scan(root, nil).Parent = nodeGUI
nodeGUI.Parent = player.PlayerGui
assignButtonFuncts()
charAdded(player.Character)
player.CharacterAdded:Connect(charAdded)
----------

mouse.Button1Down:Connect(function()
	if mode == MODES.Placing then
		placeNode()
		placementNode = spawnNode()
	elseif mode == MODES.Delete and deleteNode then
		table.remove(nodes, table.find(nodes, deleteNode))
		deleteNode:Destroy()
		deleteNode = nil
		if curNode > table.getn(nodes) then
			curNode = 1
		end
	end
end)

RS.Stepped:Connect(function()
	if dragging then
		curLoc=UIS:GetMouseLocation()
		diff = curLoc-prevMousePos
		partsWithId[0].Position = partsWithId[0].Position+UDim2.new(0,diff.X,0,diff.Y)
		prevMousePos = curLoc
	end
	
	if mode == MODES.Placing and placementNode then
		local hPos = mouse.Hit.Position
		if (hPos-workspace.Camera.CFrame.Position).Magnitude < 400 then
			placementNode.Position = hPos + Vector3.new(0,50,0)
		end
	elseif mode == MODES.Delete then
		local targ = mouse.Target
		if targ and targ:IsDescendantOf(nodeFolder) then
			local tableLoc = table.find(nodes, targ)
			if table.find(nodes, targ) then
				deleteNode = targ
				selBox.Adornee = targ
			end
		else
			deleteNode = nil
			selBox.Adornee = nil
		end
	end
end)