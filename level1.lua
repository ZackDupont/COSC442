-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()

	local d

	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.

	local background = display.newImageRect( "images/waterbg.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX
	background.y = 0 + display.screenOriginY

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
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
		physics.start()
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
		physics.stop()
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

	package.loaded[physics] = nil
	physics = nil
end

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

local widget = require("widget")
local physics = require("physics")

physics.start()
physics.setGravity(0, 0)


local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

local score = display.newText(uiGroup, "F _ S H ", 1300, 2000, native.systemFont, 240)
score.rotation = 90
score:setFillColor(0,0,0)


local boat = display.newImageRect(mainGroup, "images/boat.png", 400, 800)
        boat.x = display.contentCenterX + 222
        boat.y = display.contentCenterY - 100
        physics.addBody( boat, {radius = 30, isSensor = true })
        boat.myName = boat

local monkey = display.newImageRect(mainGroup, "images/monkey.png", 600, 600)
        monkey.x = boat.x + 128
        monkey.y = boat.y + 280


 local fLine = display.newRect(mainGroup, monkey.x + 48, monkey.y - 147, 17, 0)
        fLine:setFillColor(0.50980392,0.39215686,0.27843137)
				fLine.rotation = 90

-- Distance
function distance (fish)
	d = math.sqrt(math.pow(fLine.x - fish.x, 2) + math.pow(fLine.y - fish.y, 2))
	return d
end

local function lowerLineRelease (event)
        fLine.x = fLine.x - 30
        fLine.height = fLine.height + 60
				return true
end

local function raiseLineRelease (event)
        fLine.x = fLine.x + 30
        fLine.height = fLine.height - 60
				return true
end

local upButton = widget.newButton
{
        left = 120,
        top = 2300,
        width = 300,
        height = 150,
        defaultFile = "images/upButton.png",
        overFile = "images/upButton.png",
        label = "Raise Line",
        onRelease = raiseLineRelease,
}
upButton.rotation = 90

local downButton = widget.newButton{
        left = 0,
        top = 2300,
        width = 300,
        height = 150,
        defaultFile = "images/downButton.png",
        overFile = "images/downButton.png",
        label = "Lower Line",
        onRelease = lowerLineRelease,
}
downButton.rotation = 90

-- Check if fish is caught in console

local function listener( event )
	if distance(fishA) < 200 then
		print("Wrong fish! This is fish A")
		fishA.alpha = 0
	elseif distance(fishI) < 300 then
		fishI.alpha = 0
		print("Correct! The answer is I")
		local score = display.newText(uiGroup, "That's right! The correct word is F I S H! ", 700, 1300, native.systemFont, 120)
		score.rotation = 90
		score:setFillColor(0,0,0)
		local score = display.newText(uiGroup, "F I S H ", 1300, 2000, native.systemFont, 240)
		score.rotation = 90
		score:setFillColor(0,0,0)
	elseif distance(fishU) < 300 then
		print("wrong fish! This is fish U")
		fishU.alpha = 0

	elseif distance(fishE) < 400 then
		print("wrong fish! This is fish E")
		fishE.alpha = 0

	elseif distance(fishO) < 400 then
		print("wrong fish! This is fish O")
		fishO.alpha = 0

	end
end

timer.performWithDelay(100, listener, 0)



---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
