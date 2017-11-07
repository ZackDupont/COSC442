-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view


	local d

	-- Event Handlers
	local function onHomeRelease(event)
		composer.gotoScene( "menu", "fade", 500 )
		return true
	end




	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.

	local background = display.newImageRect( "images/waterbg.jpg", display.actualContentHeight, display.actualContentWidth )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- all display objects must be inserted into group
	sceneGroup:insert( background )

	homeBtn = widget.newButton{
		left = 1200,
		top = 100,
		width = 250,
		height = 150,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Menu",
		font = native.DroidSans,
		fontSize = 60,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onHomeRelease
	}
	homeBtn.rotation = 90
	sceneGroup:insert(homeBtn)


	-- FISHES
	local fishA = display.newImageRect("images/fish.png", 200, 200)
	fishA.x = 700
	fishA.y = 3000

	local fishI = display.newImageRect("images/BPFish.png", 200, 200)
	fishI.x = 500
	fishI.y = -500

	local fishU = display.newImageRect("images/GFish.png", 200, 200)
	fishU.x = 600
	fishU.y = 3000

	local fishE = display.newImageRect("images/RFish.png", 200, 200)
	fishE.x = 300
	fishE.y = -1000

	local fishO = display.newImageRect("images/YFish.png", 200, 200)
	fishO.x = 420
	fishO.y = 3000

	sceneGroup:insert(fishA)
	sceneGroup:insert(fishI)
	sceneGroup:insert(fishU)
	sceneGroup:insert(fishE)
	sceneGroup:insert(fishO)


	-- MOVING FISHES

	local function moveFishA()
			transition.to(fishA, {x = 700, y = -100, time=9000,onComplete=function() fishA.x = 700 fishA.y = 3000
				transition.to(fishA, {x = 700, y = -100, time=9000, onComplete=moveFishA()})
			end})
	end

	local function moveFishI()
		transition.to(fishI, {x = 500, y = 2700, time=10000,onComplete=function() fishI.x = 500 fishI.y = -1000
			transition.to(fishI, {x = 500, y = 2700, time=10000, onComplete=moveFishI()})
		end})
	end

	local function movefishU()
		transition.to(fishU, {x = 600, y = -1000, time=18000,onComplete=function() fishU.x = 600 fishU.y = 3000
			transition.to(fishU, {x = 600, y = -1000, time=18000, onComplete=movefishU()})
		end})
	end

	local function movefishE()
		transition.to(fishE, {x = 300, y = 3000, time=15000,onComplete=function() fishE.x = 300 fishE.y = -1000
			transition.to(fishE, {x = 300, y = 3000, time=15000, onComplete=movefishE()})
		end})
	end

	local function movefishO()
		transition.to(fishO, {x = 420, y = -1000, time=14000,onComplete=function() fishO.x = 420 fishO.y = 3000
			transition.to(fishO, {x = 420, y = -1000 , time=14000, onComplete=movefishO()})
		end})
	end

	-- CALL MOVEFISH

	for i=1,10,1
	do
		moveFishA()
		moveFishI()
		movefishU()
		movefishE()
		movefishO()
	end


	local backGroup = display.newGroup()
	local mainGroup = display.newGroup()
	local uiGroup = display.newGroup()

	local word = display.newText(uiGroup, "C _ T E", 1300, 2000, native.systemFont, 240)
	word.rotation = 90
	word:setFillColor(0,0,0)
	sceneGroup:insert(word)


	local boat = display.newImageRect(mainGroup, "images/boat.png", 400, 800)
					boat.x = display.contentCenterX + 222
					boat.y = display.contentCenterY - 100
					boat.myName = boat
					sceneGroup:insert(boat)

	local monkey = display.newImageRect(mainGroup, "images/monkey.png", 600, 600)
					monkey.x = boat.x + 169
					monkey.y = boat.y + 100
					sceneGroup:insert(monkey)

	local frod = display.newImageRect( mainGroup, "images/frod.png", 300, 300)
					frod.x = monkey.x + 60
					frod.y = monkey.y + 130
					sceneGroup:insert(frod)

		local hook = display.newImageRect( mainGroup, "images/hook.png", 50, 25)
					hook.x = frod.x + 115
					hook.y = frod.y + 130
					sceneGroup:insert(hook)

		local fLine = display.newLine(mainGroup, frod.x + 150,frod.y + 140 , hook.x + 10,frod.y + 140)
					fLine:setStrokeColor(0)
					fLine.strokeWidth = 5
					sceneGroup:insert(fLine)

	-- Distance
	function distance (fish)
		d = math.sqrt(math.pow(hook.x - fish.x, 2) + math.pow(hook.y - fish.y, 2))
		return d
	end


	local function lowerLineRelease (event)
					display.remove(fLine)
					fLine = display.newLine(mainGroup, frod.x + 150,frod.y + 140 , hook.x - 15,frod.y + 140)
					fLine:setStrokeColor(0)
					fLine.strokeWidth = 5
					sceneGroup:insert(fLine)
					hook.x = hook.x - 40
					return true
	end

	local function raiseLineRelease (event)
					display.remove(fLine)
					fLine = display.newLine(mainGroup, frod.x + 150,frod.y + 140 , hook.x + 60,frod.y + 140)
					fLine:setStrokeColor(0)
					fLine.strokeWidth = 5
					sceneGroup:insert(fLine)
					if hook.x < frod.x + 115 then
						hook.x = hook.x + 40
					end
					return true
	end

	local upButton = widget.newButton
	{
					left = 120,
					top = 2300,
					width = 300,
					height = 150,
					defaultFile = "images/button1.png",
					overFile = "images/button2.png",
					label = "Raise",
					fontSize = 60,
					labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
					onRelease = raiseLineRelease,
	}
	upButton.rotation = 90
	sceneGroup:insert(upButton)

	local downButton = widget.newButton{
					left = -30,
					top = 2300,
					width = 300,
					height = 150,
					defaultFile = "images/button1.png",
					overFile = "images/button2.png",
					label = "Lower",
					fontSize = 60,
					labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
					onRelease = lowerLineRelease,
	}
	downButton.rotation = 90
	sceneGroup:insert(downButton)

	-- delay end game
	local function endGame( event )
		composer.removeScene("level5")
		composer.gotoScene( "menu", "fade", 500 )
	end

	-- Check if fish is caught

	local function listener( event )
		if distance(fishA) < 100 then
			score = display.newText(uiGroup, "C A T E is INCORRECT", 700, 1300, native.systemFont, 120)
			score.rotation = 90
			score:setFillColor(0,0,0)
			sceneGroup:insert(score)
			transition.fadeOut(score, {time = 500})

		elseif distance(fishI) < 100 then
			score = display.newText(uiGroup, "C I T E is NOT what we're looking for!", 700, 1300, native.systemFont, 120)
			score.rotation = 90
			score:setFillColor(0,0,0)
			sceneGroup:insert(score)
			transition.fadeOut(score, {time = 500})

		elseif distance(fishU) < 100 then
			fishU.alpha = 0
			local score = display.newText(uiGroup, "That's right! The correct word is C U T E!", 700, 1300, native.systemFont, 120)
			score.rotation = 90
			score:setFillColor(0,0,0)
			sceneGroup:insert(score)
			display.remove(word)
			word = display.newText(uiGroup, " C U T E ", 1300, 2000, native.systemFont, 240)
			word.rotation = 90
			word:setFillColor(0,0,0)
			sceneGroup:insert(word)
			timer.performWithDelay(1500, endGame, 1)

		elseif distance(fishE) < 100 then
			score = display.newText(uiGroup, "C E T E is INCORRECT!", 700, 1300, native.systemFont, 120)
			score.rotation = 90
			score:setFillColor(0,0,0)
			sceneGroup:insert(score)
			transition.fadeOut(score, {time = 500})


		elseif distance(fishO) < 100 then
			score = display.newText(uiGroup, "C O T E is INCORRECT!", 700, 1300, native.systemFont, 120)
			score.rotation = 90
			score:setFillColor(0,0,0)
			sceneGroup:insert(score)
			transition.fadeOut(score, {time = 500})

		end
	end

	timer.performWithDelay(100, listener, 0)

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		--
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

	end
end

function scene:hide( event )
	local sceneGroup = self.view

	local phase = event.phase

	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)

	elseif phase == "did" then
		-- Called when the scene is now off screen
	end

end


function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
