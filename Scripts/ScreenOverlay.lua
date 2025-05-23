--- This code is from Roblox Devforum: https://devforum.roblox.com/t/screen-overlay-open-source/3556911
--- I only changed Line 203 Default Image to Archie Hub logo and added background transparency

local screenOverlayHandler = {
	_rotationActive = true,
	_rotationThread = nil,
	_frame = nil,
	_screenGui = nil,
	_activeAnimation = false,
}
screenOverlayHandler.__index = screenOverlayHandler

local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local cam = Workspace.CurrentCamera

local openInfo = TweenInfo.new(1.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)

local particleInfo = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false, 0)

local uiCornerInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0, false, 0)

local assetInfo = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut, 0, false, 0)

--[=[
	Creates a particle effect animation on the given `ScreenGui`
	and then destroys it after the animation is completed.

	@param screenGui ScreenGui -- The UI container where the effect will be applied.
	@param onSuccess (() -> ())? -- (Optional) A callback function that is executed after the effect is completed.
]=]
local function createParticleEffects(screenGui: ScreenGui, onSuccess: () -> ()?)
	if not screenGui:IsA("ScreenGui") then
		return
	end

	local activeFrames = {}
	local maxSizePercent = 0.05
	local viewportSize = cam.ViewportSize
	local sizeValue = math.ceil(math.max(viewportSize.X * maxSizePercent, viewportSize.Y * maxSizePercent))
	local frameSize = UDim2.fromScale(sizeValue / viewportSize.X, sizeValue / viewportSize.Y)

	local xFrames = math.ceil(viewportSize.X / sizeValue) + 3
	local yFrames = math.ceil(viewportSize.Y / sizeValue) + 3

	local startX = (viewportSize.X / 2) - ((xFrames - 2) * sizeValue / 2) - sizeValue
	local startY = (viewportSize.Y / 2) - ((yFrames - 2) * sizeValue / 2) - sizeValue

	for x = -1, xFrames do
		activeFrames[x] = {}
		for y = -1, yFrames do
			local frame = Instance.new("Frame")
			frame.Size = frameSize
			frame.Position = UDim2.fromScale(
				(startX + (x * sizeValue)) / viewportSize.X,
				(startY + (y * sizeValue)) / viewportSize.Y
			)
			frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			frame.BackgroundTransparency = 0.2
			frame.AnchorPoint = Vector2.new(0.5, 0.5)
			frame.Name = "TemporaryOverlayFrame"
			frame.Parent = screenGui

			Instance.new("UIAspectRatioConstraint", frame).AspectRatio = 1

			local uiCorner = Instance.new("UICorner")
			uiCorner.CornerRadius = UDim.new(0, 0)
			uiCorner.Parent = frame

			activeFrames[x][y] = frame
		end
	end

	task.delay(0.15, function()
		local frame = screenGui:FindFirstChild("ScreenOverlayFrame")
		if frame then
			frame:Destroy()
		end
	end)

	local minSum = -1 - yFrames
	local maxSum = xFrames + 1

	for sum = minSum, maxSum do
		task.wait(0.015)
		for x = -1, xFrames do
			local y = x - sum
			if activeFrames[x] and activeFrames[x][y] then
				local frame = activeFrames[x][y]
				local frameTween = TweenService:Create(frame, particleInfo, { Size = UDim2.fromOffset(0, 0) })
				frameTween:Play()
				frameTween.Completed:Connect(function()
					frame:Destroy()
				end)

				local uiCorner = frame:FindFirstChildOfClass("UICorner")
				if uiCorner then
					local uiCornerTween =
						TweenService:Create(uiCorner, uiCornerInfo, { CornerRadius = UDim.new(0.5, 0) })
					uiCornerTween:Play()
					uiCornerTween.Completed:Connect(function()
						uiCornerTween:Destroy()
					end)
				end
			end
		end
	end

	task.wait(particleInfo.Time)
	screenGui:Destroy()
	if onSuccess and typeof(onSuccess) == "function" then
		onSuccess()
	end
end

--[=[
	Creates and plays an overlay animation with an optional message.
	
	@param action (() -> ()) -- A function to be executed while the animation is active.
	@param message string? -- (Optional) A message to be displayed during the animation.
]=]
function screenOverlayHandler:Create(action: () -> (), message: string?)
	if typeof(message) ~= "string" then
		message = ""
	end

	if typeof(action) ~= "function" then
		action = function() end
	end

	if self._activeAnimation then
		return
	end

	self:Start(message)
	action()
	self:Stop()
end

--[=[
	Starts the screen overlay animation with an optional message.
	
	@param message string? -- (Optional) A message to be displayed during the animation.
]=]
function screenOverlayHandler:Start(message: string?)
	if self._activeAnimation then
		return
	end

	self._activeAnimation = true

	local function getDiagonal()
		local camViewportSize = cam.ViewportSize
		return math.sqrt((camViewportSize.X ^ 2) + (camViewportSize.Y ^ 2)) * 5
	end

	local diagonal = getDiagonal()
	local targetSize = UDim2.fromOffset(diagonal, diagonal)

	local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
	self._screenGui = Instance.new("ScreenGui")
	self._frame = Instance.new("Frame")
	Instance.new("UICorner", self._frame).CornerRadius = UDim.new(1, 0)

	self._screenGui.Name = "ScreenOverlayGui"
	self._screenGui.IgnoreGuiInset = true
	self._screenGui.Parent = playerGui

	self._frame.Name = "ScreenOverlayFrame"
	self._frame.AnchorPoint = Vector2.new(0.5, 0.5)
	self._frame.Size = UDim2.fromOffset(0, 0)
	self._frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	self._frame.BackgroundTransparency = 0.2
	self._frame.Position = UDim2.fromScale(0.5, 0.5)
	self._frame.Parent = self._screenGui

	local textLabel = Instance.new("TextLabel")
	Instance.new("UITextSizeConstraint", textLabel).MaxTextSize = math.ceil(cam.ViewportSize.Y * 0.025) + 1
	Instance.new("UIAspectRatioConstraint", textLabel).AspectRatio = 10
	textLabel.BackgroundTransparency = 1
	textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	textLabel.Size = UDim2.fromScale(1, 0.1)
	textLabel.TextTransparency = 1
	textLabel.Position = UDim2.fromScale(0.5, 0.725)
	textLabel.TextScaled = true
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.Font = Enum.Font.GothamBold
	textLabel.Name = "TemporaryTextLabel"
	textLabel.Text = message or ""
	textLabel.Parent = self._screenGui

	local textLabelTween =
		TweenService:Create(textLabel, assetInfo, { TextTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.7) })
	textLabelTween:Play()
	textLabelTween.Completed:Connect(function()
		textLabelTween:Destroy()
	end)

	self._rotationActive = false
	self._rotationThread = task.spawn(function()
		local image = Instance.new("ImageLabel")
		image.AnchorPoint = Vector2.new(0.5, 0.5)
		image.Size = UDim2.fromOffset(0, 0)
		image.Position = UDim2.fromScale(0.5, 0.5)
		image.Image = "rbxassetid://" .. 133036854395404
		image.BackgroundTransparency = 1
		image.Parent = self._frame

		local maxSizePercent = 0.22
		local viewportSize = cam.ViewportSize
		local sizeValue = math.ceil(math.max(viewportSize.X * maxSizePercent, viewportSize.Y * maxSizePercent))

		local imageTween = TweenService:Create(image, assetInfo, { Size = UDim2.fromOffset(sizeValue, sizeValue) })
		imageTween:Play()
		imageTween.Completed:Wait()
		imageTween:Destroy()

		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint.Parent = image

		while self._rotationActive do
			local imageRotationTween = TweenService:Create(image, assetInfo, { Rotation = image.Rotation - 180 })
			imageRotationTween:Play()
			imageRotationTween.Completed:Wait()
			imageRotationTween:Destroy()
		end
	end)

	local frameTween = TweenService:Create(self._frame, openInfo, { Size = targetSize })
	frameTween:Play()
	frameTween.Completed:Wait()
	frameTween:Destroy()
end

--[=[
	Stops the screen overlay animation and triggers the particle effect transition.
]=]
function screenOverlayHandler:Stop()
	if not self._frame then
		return
	end

	task.spawn(function()
		self._rotationActive = false
		if self._rotationThread then
			task.cancel(self._rotationThread)
		end

		if self._frame then
			local image = self._frame:FindFirstChildOfClass("ImageLabel")
			if image then
				local shrinkTween = TweenService:Create(
					image,
					assetInfo,
					{ Size = UDim2.fromOffset(0, 0), Rotation = math.floor(image.Rotation / 360) * 360 }
				)
				shrinkTween:Play()
				shrinkTween.Completed:Connect(function()
					shrinkTween:Destroy()
				end)
			end
		end

		if self._screenGui then
			local textLabel = self._screenGui:FindFirstChildOfClass("TextLabel")
			if textLabel then
				local textLabelTween = TweenService:Create(
					textLabel,
					assetInfo,
					{ TextTransparency = 1, Position = UDim2.fromScale(0.5, 0.675) }
				)
				textLabelTween:Play()
				textLabelTween.Completed:Connect(function()
					textLabelTween:Destroy()
				end)
			end
		end

		task.wait(assetInfo.Time)

		createParticleEffects(self._screenGui, function()
			self._activeAnimation = false
		end)
	end)
end

return screenOverlayHandler
