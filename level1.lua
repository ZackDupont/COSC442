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

local fish1 = display.newImageRect("images/BPFish.png", 200, 200)
fish1.x = 500
fish1.y = -500

local fish2 = display.newImageRect("images/GFish.png", 200, 200)
fish2.x = 600
fish2.y = 3000

local fish3 = display.newImageRect("images/RFish.png", 200, 200)
fish3.x = 300
fish3.y = -1000

local fish4 = display.newImageRect("images/YFish.png", 200, 200)
fish4.x = 420
fish4.y = 3000

-- MOVING FISHES

local function moveFishA()
  transition.to(fishA, {x = 700, y = -100, time=9000,onComplete=function() fishA.x = 700 fishA.y = 3000
    transition.to(fishA, {x = 700, y = -100, time=9000, onComplete=moveFishA()})
  end})
end

local function moveFish1()
  transition.to(fish1, {x = 500, y = 2700, time=10000,onComplete=function() fish1.x = 500 fish1.y = -1000
    transition.to(fish1, {x = 500, y = 2700, time=10000, onComplete=moveFish1()})
  end})
end

local function moveFish2()
  transition.to(fish2, {x = 600, y = -1000, time=12000,onComplete=function() fish2.x = 600 fish2.y = 3000
    transition.to(fish2, {x = 600, y = -1000, time=12000, onComplete=moveFish2()})
  end})
end

local function moveFish3()
  transition.to(fish3, {x = 300, y = 3000, time=15000,onComplete=function() fish3.x = 300 fish1.y = -1000
    transition.to(fish3, {x = 300, y = 1000, time=15000, onComplete=moveFish3()})
  end})
end

local function moveFish4()
  transition.to(fish4, {x = 420, y = -1000, time=14000,onComplete=function() fish4.x = 420 fish1.y = 3000
    transition.to(fish4, {x = 420, y = -1000 , time=14000, onComplete=moveFish4()})
  end})
end

-- CALL MOVEFISH

for i=1,10,1
do
  moveFishA()
  moveFish1()
  moveFish2()
  moveFish3()
  moveFish4()
end

local widget = require("widget")
local physics = require("physics")

physics.start()
physics.setGravity(0, 0)




local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

local score = display.newText(uiGroup, "F I S H ", 1300, 2000, native.systemFont, 240)
score.rotation = 90
score:setFillColor(0,0,0)

 local score = display.newText(uiGroup, "That's right! The correct word is F I S H! ", 700, 1300, native.systemFont, 120)
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


 local fLine = display.newRect(mainGroup, monkey.x + 20, monkey.y, 30, 150)
        fLine:setFillColor(brown)
        -- fLine:toBack()
fLine.rotation = 90

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











---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
